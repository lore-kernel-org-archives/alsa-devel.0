From: Erik Friesen <friesendrywall@gmail.com>
Subject: SGTL5000 startup error on reboot
Date: Mon, 8 Feb 2016 07:53:20 -0500
Message-ID: <CAEuupit7TCsr56MUOC4iyL+cP+TLFSOpjCZPrq1cTY4foX5Ykw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f176.google.com (mail-ig0-f176.google.com
 [209.85.213.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C220260515
 for <alsa-devel@alsa-project.org>; Mon,  8 Feb 2016 13:53:22 +0100 (CET)
Received: by mail-ig0-f176.google.com with SMTP id hb3so54508597igb.0
 for <alsa-devel@alsa-project.org>; Mon, 08 Feb 2016 04:53:21 -0800 (PST)
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

I find that the codec is getting a write failure at sgtl5000_fill_defaults at

{ SGTL5000_CHIP_ANA_POWER, 0x7060 },

about half the time following a software reboot, and with external
vddd powered with 1.8v.  Reading this register shows that it is
already at 0x7060, so I am not sure what is up with that, but I would
suspect a hardware bug in the codec.

Using this code has fixed this so far.

static int sgtl5000_fill_defaults(struct sgtl5000_priv *sgtl5000)
{
 int i, ret, val, index;
 int reg;
 for (i = 0; i < ARRAY_SIZE(sgtl5000_reg_defaults); i++) {
  val = sgtl5000_reg_defaults[i].def;
  index = sgtl5000_reg_defaults[i].reg;
  ret = regmap_read(sgtl5000->regmap, index, &reg);
  if (ret) {
   printk(KERN_WARNING "SGTL5000 probe read failed at %i\n", i);
  return ret;
  }
  if (reg != val) {
   ret = regmap_write(sgtl5000->regmap, index, val);
  }
  if (ret) {
   printk(KERN_WARNING "SGTL5000 probe write failed %x at %i index %i
@ %x\n", val, i, index,  reg);
   return ret;
  }
 }
 return 0;
}
