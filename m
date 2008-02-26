From: "Alexandre BOUIN" <a.bouin@kerlink.fr>
Subject: Re: ASoC - Output widgets
Date: Tue, 26 Feb 2008 10:11:42 +0100
Message-ID: <11639.6254547455$1204017163@news.gmane.org>
References: <20080225133430.GB9038@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from scanner-relay-corvus2.pulsation.fr
	(scanner-relay-corvus2.pulsation.fr [80.74.64.70])
	by alsa0.perex.cz (Postfix) with SMTP id B34731037EF
	for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2008 10:11:52 +0100 (CET)
In-Reply-To: <20080225133430.GB9038@sirena.org.uk>
Content-Language: fr
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Mark Brown' <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> Could you please post dmesg output with DAPM_DEBUG turned on which
> shows
> this happening?

Here is my DAPM_DEBUG traces : 
Please notice that for some internal reasons, this driver is not at all the
same as wolfson release ;)

DAPM WM8900 snd_soc_dapm_stream_event
FM Transmitter: On  in 2 out 1
 in  static FMOUT_R
 in  static FMOUT_L
Headphone Jack: On  in 2 out 1
 in  static HPOUT_R
 in  static HPOUT_L
HPOUT_R: Off  in 2 out 1
 in  static HPOUT CP
 out static Headphone Jack
HPOUT_L: Off  in 2 out 1
 in  static HPOUT CP
 out static Headphone Jack
FMOUT_R: Off  in 1 out 1
 in  static FMOUT_R PGA
 out static FM Transmitter
FMOUT_L: Off  in 1 out 1
 in  static FMOUT_L PGA
 out static FM Transmitter
HPOUT CP: On  in 2 out 2
 in  static HPOUT_R PGA
 in  static HPOUT_L PGA
 out static HPOUT_R
 out static HPOUT_L
HPOUT_R PGA: On  in 1 out 2
 in  static MIXOUT_R
 out static HPOUT CP
HPOUT_L PGA: On  in 1 out 2
 in  static MIXOUT_L
 out static HPOUT CP
FMOUT_R PGA: On  in 1 out 1
 in  static MIXOUT_R
 out static FMOUT_R
FMOUT_L PGA: On  in 1 out 1
 in  static MIXOUT_L
 out static FMOUT_L
MIXOUT_R: On  in 1 out 3
 in  DAC_R Switch DAC_R
 out static HPOUT_R PGA
 out static FMOUT_R PGA
MIXOUT_L: On  in 1 out 3
 in  DAC_L Switch DAC_L
 out static HPOUT_L PGA
 out static FMOUT_L PGA
DAC_R: On  in 1 out 3
 out DAC_R Switch MIXOUT_R
DAC_L: On  in 1 out 3
 out DAC_L Switch MIXOUT_L

I initialize FM Transmitter like this : 
	snd_soc_dapm_set_endpoint(codec, "FM Transmitter", 0);
but it still enabled. Why ?
Do you have any ideas on why both HP and FMOUT PGAs are powered ?

Thanks.

Regards,
Alex.
