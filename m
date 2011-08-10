From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: snd soc spi read/write
Date: Wed, 10 Aug 2011 23:55:50 +0900
Message-ID: <20110810145549.GA5724@opensource.wolfsonmicro.com>
References: <20110805054210.GB16956@opensource.wolfsonmicro.com>
	<CAHG8p1AkbrfX3dkLw=MNf24V3peMB33z-vLdVyzRxvGmSNTWSg@mail.gmail.com>
	<20110805063414.GB20809@opensource.wolfsonmicro.com>
	<CAHG8p1BBza_M_Cgrq2O2U+Xc-=rPHeNBKMD_KwfZsLX5Npz9jA@mail.gmail.com>
	<20110805072908.GA28149@opensource.wolfsonmicro.com>
	<CAHG8p1BSW1_enLqJL4fxxHvTd3MdwmS+Av+zy4i23BH+TuhJqw@mail.gmail.com>
	<20110805083058.GB4977@opensource.wolfsonmicro.com>
	<CAHG8p1AG2mteW0Bw6ScHCsM5okLr7Vd7Hqy=T8zz+C746qpn+g@mail.gmail.com>
	<20110809160447.GM15861@opensource.wolfsonmicro.com>
	<s5hwrela3d8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 59E781038AD
	for <alsa-devel@alsa-project.org>;
	Wed, 10 Aug 2011 16:55:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hwrela3d8.wl%tiwai@suse.de>
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
Cc: uclinux-dist-devel@blackfin.uclinux.org, Scott Jiang <scott.jiang.linux@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 10, 2011 at 01:54:27PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > No, like I say we just need to teach regmap about this stuff.  It's not
> > that odd, it's just your hardware designers seem to want to consume
> > extra bandwidth on the control bus for some reason AFAICT as it looks
> > like all the registers are 0x8xx.

> Actually we should handle the register index only in the lower byte
> for these devices.  For example, ad193x has raw registers ranged from

That would fall within the definition of "teach the register map about
this stuff"...
