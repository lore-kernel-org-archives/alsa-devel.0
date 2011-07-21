From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [PATCH V2 0/2] ALSA: ASoC for Au1000/1500/1100
Date: Thu, 21 Jul 2011 19:27:51 +0200
Message-ID: <CAOLZvyEaKdSwC9ZU_FrYYAqmTkHfCsztftip_sY0Vfe9wDN7Og@mail.gmail.com>
References: <1311266050-22199-1-git-send-email-manuel.lauss@googlemail.com>
	<s5hmxg78st2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 22B11244D4
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Jul 2011 19:27:52 +0200 (CEST)
Received: by gyc15 with SMTP id 15so748855gyc.38
	for <alsa-devel@alsa-project.org>; Thu, 21 Jul 2011 10:27:52 -0700 (PDT)
In-Reply-To: <s5hmxg78st2.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Linux-MIPS <linux-mips@linux-mips.org>, alsa-devel@alsa-project.org, Ralf Baechle <ralf@linux-mips.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 21, 2011 at 7:08 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Thu, 21 Jul 2011 18:34:08 +0200,
> Manuel Lauss wrote:
>>
>> Hello,
>>
>> These 2 patches implement ASoC drivers for the AC97 and I2S
>> controllers found on early Alchemy chips. =A0They are largely
>> based on the old mips/au1x00.c driver which they replace.
>
> In general, dropping an old driver happens a bit later after the new
> driver comes in. =A0You can make the old one as deprecated at first.

Makes sense, just ignore patch 2 then ;)

Thanks,
        Manuel Lauss
