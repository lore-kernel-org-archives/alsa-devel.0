From: Scott Jiang <scott.jiang.linux@gmail.com>
Subject: Re: snd soc spi read/write
Date: Tue, 9 Aug 2011 11:41:30 +0800
Message-ID: <CAHG8p1AG2mteW0Bw6ScHCsM5okLr7Vd7Hqy=T8zz+C746qpn+g@mail.gmail.com>
References: <CAHG8p1AsKZdVvTj-ydWhDCEKjJcx9Q82srEOVZS45Q5J486YBw@mail.gmail.com>
	<20110804103558.GA25976@opensource.wolfsonmicro.com>
	<CAHG8p1AeeqL+Cj-4V4NwQpD33H4ogV0rfekHjMqfvG7wQ49fCA@mail.gmail.com>
	<20110805054210.GB16956@opensource.wolfsonmicro.com>
	<CAHG8p1AkbrfX3dkLw=MNf24V3peMB33z-vLdVyzRxvGmSNTWSg@mail.gmail.com>
	<20110805063414.GB20809@opensource.wolfsonmicro.com>
	<CAHG8p1BBza_M_Cgrq2O2U+Xc-=rPHeNBKMD_KwfZsLX5Npz9jA@mail.gmail.com>
	<20110805072908.GA28149@opensource.wolfsonmicro.com>
	<CAHG8p1BSW1_enLqJL4fxxHvTd3MdwmS+Av+zy4i23BH+TuhJqw@mail.gmail.com>
	<20110805083058.GB4977@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51]) by alsa0.perex.cz (Postfix) with ESMTP id 5406F243FF
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Aug 2011 05:41:32 +0200 (CEST)
Received: by qwf7 with SMTP id 7so1671070qwf.38
	for <alsa-devel@alsa-project.org>; Mon, 08 Aug 2011 20:41:30 -0700 (PDT)
In-Reply-To: <20110805083058.GB4977@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Takashi Iwai <tiwai@suse.de>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2011/8/5 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Fri, Aug 05, 2011 at 04:00:52PM +0800, Scott Jiang wrote:
>
>> > Why are you replying off-list? =A0You should implement 16x8 SPI reads =
in
>> > the core stuff I'd expect, then disable cache for the CODEC.
>
>> Sorry, I just forgot to CC.
>> I wonder if rbtree compress type can support this kind of sparse registe=
r?
>
> Yes, rbtree works fine with this. =A0You'd still take a hit on the size of
> your register defaults though.
>
>> And should the patch aginst 3.0 or 3.2?
>
> 3.0 can't be patched, though you could try submitting a patch to the
> stable guys. =A0Probably best to start off with 3.1 and see where we go
> from there.
>

I got a problem here. As Takashi mentioned, our registers have a
read/write bit in the upper 8bit.
There are three methods:
1. pass different registers to snd_soc_read and snd_soc_write. But
snd_kcontrol and snd_soc_dapm_widget can't work because I pass only
one register.
2. deal with this bit in hw_read, but this will be deprecated by
others whose chip doesn't have this bit.
3. I'd like to use SND_SOC_CUS type, but it has been removed since
linux 3.0. I suggest we can reserve this type, considering SPI is a
simple "de facto" standard.
