From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH 05/10] soc - tlv320aic3x - Convert to use
 bulk registration APIs
Date: Tue, 13 May 2008 16:20:02 +0300
Message-ID: <20080513162002.a7f8ccd7.jarkko.nikula@nokia.com>
References: <1210678815-9755-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1210678815-9755-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1210678815-9755-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1210678815-9755-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1210678815-9755-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20080513153419.360c23e6.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id DC25924ADC
	for <alsa-devel@alsa-project.org>;
	Tue, 13 May 2008 15:19:56 +0200 (CEST)
In-Reply-To: <20080513153419.360c23e6.jarkko.nikula@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

My own patch [1] fixed this problem. Thanks to new log message "Failed
to add route Mono Out->MONOLOUT" :-)


Jarkko

1.
http://mailman.alsa-project.org/pipermail/alsa-devel/2008-May/007721.html

On Tue, 13 May 2008 15:34:19 +0300
Jarkko Nikula <jarkko.nikula@nokia.com> wrote:

> On Tue, 13 May 2008 12:40:10 +0100
> "ext Mark Brown" <broonie@opensource.wolfsonmicro.com> wrote:
> 
> > Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> > Cc: Jarkko Nikula <jarkko.nikula@nokia.com>
> > ---
> >  sound/soc/codecs/tlv320aic3x.c |   15 ++++-----------
> >  1 files changed, 4 insertions(+), 11 deletions(-)
> > 
> Hmm. I applied patches 2, 3, 5 and 10 to my n810-aic33 setup and
> following codec controls below disappear. Probably I miss some patch
> from asoc-dev since I build this test on top of linux-omap with two
> recent aic3x patches from Daniel?
> 
> 
> Jarkko
> 
> --- curr	2008-05-13 15:18:09.000000000 +0300
> +++ new	2008-05-13 15:19:40.000000000 +0300
> @@ -20,18 +20,7 @@
>  Simple mixer control 'Left DAC_L1 Mixer Mono',0
>  Simple mixer control 'Left HPCOM Mux',0
>  Simple mixer control 'Left Line1L Mux',0
> -Simple mixer control 'Left Line2 Bypass Mixer HP Swit',0
> -Simple mixer control 'Left Line2 Bypass Mixer HPCOM S',0
> -Simple mixer control 'Left Line2 Bypass Mixer Line Sw',0
> -Simple mixer control 'Left Line2 Bypass Mixer Mono Sw',0
>  Simple mixer control 'Left Line2L Mux',0
> -Simple mixer control 'Left PGA Bypass Mixer HP',0
> -Simple mixer control 'Left PGA Bypass Mixer HPCOM Swi',0
> -Simple mixer control 'Left PGA Bypass Mixer Line Swit',0
> -Simple mixer control 'Left PGA Bypass Mixer Mono Swit',0
> -Simple mixer control 'Left PGA Mixer Line1L',0
> -Simple mixer control 'Left PGA Mixer Line2L',0
> -Simple mixer control 'Left PGA Mixer Mic3L',0
>  Simple mixer control 'PGA',0
>  Simple mixer control 'Right DAC Mux',0
>  Simple mixer control 'Right DAC_R1 Mixer HP',0
> @@ -40,16 +29,5 @@
>  Simple mixer control 'Right DAC_R1 Mixer Mono',0
>  Simple mixer control 'Right HPCOM Mux',0
>  Simple mixer control 'Right Line1R Mux',0
> -Simple mixer control 'Right Line2 Bypass Mixer HP Swi',0
> -Simple mixer control 'Right Line2 Bypass Mixer HPCOM ',0
> -Simple mixer control 'Right Line2 Bypass Mixer Line S',0
> -Simple mixer control 'Right Line2 Bypass Mixer Mono S',0
>  Simple mixer control 'Right Line2R Mux',0
> -Simple mixer control 'Right PGA Bypass Mixer HP Switc',0
> -Simple mixer control 'Right PGA Bypass Mixer HPCOM Sw',0
> -Simple mixer control 'Right PGA Bypass Mixer Line Swi',0
> -Simple mixer control 'Right PGA Bypass Mixer Mono Swi',0
> -Simple mixer control 'Right PGA Mixer Line1R',0
> -Simple mixer control 'Right PGA Mixer Line2R',0
> -Simple mixer control 'Right PGA Mixer Mic3R',0
>  Simple mixer control 'Speaker Function',0
