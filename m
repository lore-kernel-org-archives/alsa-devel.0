From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: HCTL element callback
Date: Fri, 3 Sep 2010 08:35:45 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1009030832140.10278@eeebox2.perex-int.cz>
References: <1283464109.6921.10.camel@aviva.ttga.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 6DD9310383A
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Sep 2010 08:35:46 +0200 (CEST)
In-Reply-To: <1283464109.6921.10.camel@aviva.ttga.homeip.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Camilo Polymeris <cpolymeris@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 2 Sep 2010, Camilo Polymeris wrote:

> Hello.
> I am writing this mixer app:
> http://emutrix.googlecode.com
>
> I have trouble with callbacks. So far I have implemented callbacks for
> the master volume fader and clock rate selection (integer and enum,
> resp.)
> But "pad" callbacks (boolean) won't work. In fact, I have noticed that
> alsamixer 1.0.22 also doesn't react to pad changes from the application.
> But the driver reacts to both as expected, so we're dealing with the
> same element.

It seems like a bug in the emu driver. The elem put callbacks does not 
check for changes (they should return 1).

Does this patch help?

diff --git a/sound/pci/emu10k1/emumixer.c b/sound/pci/emu10k1/emumixer.c
index 05afe06..7bd1c1a 100644
--- a/sound/pci/emu10k1/emumixer.c
+++ b/sound/pci/emu10k1/emumixer.c
@@ -622,6 +622,7 @@ static int snd_emu1010_adc_pads_put(struct snd_kcontrol *kcontrol, struct snd_ct
  	if (cache != emu->emu1010.adc_pads) {
  		snd_emu1010_fpga_write(emu, EMU_HANA_ADC_PADS, cache );
  	        emu->emu1010.adc_pads = cache;
+	        return 1;
  	}

  	return 0;
@@ -670,6 +671,7 @@ static int snd_emu1010_dac_pads_put(struct snd_kcontrol *kcontrol, struct snd_ct
  	if (cache != emu->emu1010.dac_pads) {
  		snd_emu1010_fpga_write(emu, EMU_HANA_DAC_PADS, cache );
  	        emu->emu1010.dac_pads = cache;
+	        return 1;
  	}

  	return 0;

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
