From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: snd soc spi read/write
Date: Wed, 10 Aug 2011 01:04:48 +0900
Message-ID: <20110809160447.GM15861@opensource.wolfsonmicro.com>
References: <20110804103558.GA25976@opensource.wolfsonmicro.com>
	<CAHG8p1AeeqL+Cj-4V4NwQpD33H4ogV0rfekHjMqfvG7wQ49fCA@mail.gmail.com>
	<20110805054210.GB16956@opensource.wolfsonmicro.com>
	<CAHG8p1AkbrfX3dkLw=MNf24V3peMB33z-vLdVyzRxvGmSNTWSg@mail.gmail.com>
	<20110805063414.GB20809@opensource.wolfsonmicro.com>
	<CAHG8p1BBza_M_Cgrq2O2U+Xc-=rPHeNBKMD_KwfZsLX5Npz9jA@mail.gmail.com>
	<20110805072908.GA28149@opensource.wolfsonmicro.com>
	<CAHG8p1BSW1_enLqJL4fxxHvTd3MdwmS+Av+zy4i23BH+TuhJqw@mail.gmail.com>
	<20110805083058.GB4977@opensource.wolfsonmicro.com>
	<CAHG8p1AG2mteW0Bw6ScHCsM5okLr7Vd7Hqy=T8zz+C746qpn+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B25F42460E
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Aug 2011 18:04:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAHG8p1AG2mteW0Bw6ScHCsM5okLr7Vd7Hqy=T8zz+C746qpn+g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Scott Jiang <scott.jiang.linux@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 09, 2011 at 11:41:30AM +0800, Scott Jiang wrote:

> There are three methods:
> 1. pass different registers to snd_soc_read and snd_soc_write. But
> snd_kcontrol and snd_soc_dapm_widget can't work because I pass only
> one register.
> 2. deal with this bit in hw_read, but this will be deprecated by
> others whose chip doesn't have this bit.
> 3. I'd like to use SND_SOC_CUS type, but it has been removed since
> linux 3.0. I suggest we can reserve this type, considering SPI is a
> simple "de facto" standard.

No, like I say we just need to teach regmap about this stuff.  It's not
that odd, it's just your hardware designers seem to want to consume
extra bandwidth on the control bus for some reason AFAICT as it looks
like all the registers are 0x8xx.
