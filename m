From: Erik Friesen <friesendrywall@gmail.com>
Subject: Re: SGTL5000 startup error on reboot
Date: Mon, 15 Feb 2016 09:58:13 -0500
Message-ID: <CAEuupisLQFu_MSfi=H1eMCn6-nu3eyH56-Qa3TF_+EqOJO7DSQ@mail.gmail.com>
References: <CAEuupit7TCsr56MUOC4iyL+cP+TLFSOpjCZPrq1cTY4foX5Ykw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f173.google.com (mail-io0-f173.google.com
 [209.85.223.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 513552606D1
 for <alsa-devel@alsa-project.org>; Mon, 15 Feb 2016 15:58:14 +0100 (CET)
Received: by mail-io0-f173.google.com with SMTP id g203so134839538iof.2
 for <alsa-devel@alsa-project.org>; Mon, 15 Feb 2016 06:58:14 -0800 (PST)
In-Reply-To: <CAEuupit7TCsr56MUOC4iyL+cP+TLFSOpjCZPrq1cTY4foX5Ykw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hey, its posted for others, but I am unsubscribing to the list, so
future correspondence should be direct to email.

On Mon, Feb 8, 2016 at 7:53 AM, Erik Friesen <friesendrywall@gmail.com> wrote:
> I find that the codec is getting a write failure at sgtl5000_fill_defaults at
>
> { SGTL5000_CHIP_ANA_POWER, 0x7060 },
>
> about half the time following a software reboot, and with external
> vddd powered with 1.8v.  Reading this register shows that it is
> already at 0x7060, so I am not sure what is up with that, but I would
> suspect a hardware bug in the codec.
>
> Using this code has fixed this so far.
>
> static int sgtl5000_fill_defaults(struct sgtl5000_priv *sgtl5000)
> {
>  int i, ret, val, index;
>  int reg;
>  for (i = 0; i < ARRAY_SIZE(sgtl5000_reg_defaults); i++) {
>   val = sgtl5000_reg_defaults[i].def;
>   index = sgtl5000_reg_defaults[i].reg;
>   ret = regmap_read(sgtl5000->regmap, index, &reg);
>   if (ret) {
>    printk(KERN_WARNING "SGTL5000 probe read failed at %i\n", i);
>   return ret;
>   }
>   if (reg != val) {
>    ret = regmap_write(sgtl5000->regmap, index, val);
>   }
>   if (ret) {
>    printk(KERN_WARNING "SGTL5000 probe write failed %x at %i index %i
> @ %x\n", val, i, index,  reg);
>    return ret;
>   }
>  }
>  return 0;
> }
