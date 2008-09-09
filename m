From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: wm8731 capture -dapm failure
Date: Tue, 9 Sep 2008 16:42:14 +0100
Message-ID: <200809091642.14114.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (smtp-out-4.talktalk.net [62.24.128.234])
	by alsa0.perex.cz (Postfix) with ESMTP id 717071037F1
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Sep 2008 17:34:53 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, ALSA devel <alsa-devel@alsa-project.org>
Cc: Cliff Cai <cliff.cai@analog.com>, Bryan Wu <cooloney@kernel.org>, Liam Girdwood <lrg@kernel.org>
List-Id: alsa-devel@alsa-project.org

I've started a new thread to avoid confusion, and copied bits here:

On Monday 08 September 2008 21:51, Mark Brown wrote:
> On Mon, Sep 08, 2008 at 09:27:13PM +0100, Alan Horstmann wrote:
> > With just this one change we have been successful in running the codec
> > over spi. =A0At present we do have an issue with dapm during capture
> > -nothing is being turned on! =A0Any pointers would be appreciated.
>
> If you define DEBUG when building soc-dapm.c (a define at the top of the
> source file will do the trick) then it will be very verbose about the
> decisions it's making - that will normally point out the problem.
> Probably either one of the input controls is not configured to make a
> path from the input pins to the ADC or the input has been mistakenly
> marked as disabled.

That gets us lots of info to digest, and it does look like there are no dap=
m =

capture paths -listing below.  What we cannot fathom is why!

Can users of wm8731 confirm successful capture with dapm on any platform?  =
It =

is not clear at this stage whether we are looking for a problem on our =

platform, or a general bug in the driver dapm code.

Any assistance would be appreciated.

Alan

widget ADC
 HiFi Capture stream Capture event 1
widget DAC
 HiFi Playback stream Capture event 1
reg old 5f new 5f change 0
reg old 5f new 5f change 0
DAPM WM8731 snd_soc_dapm_stream_event
Ext Spk: Off  in 0 out 1
 in  static LHPOUT
Int Mic: Off  in 1 out 0
 out static Mic Bias
LLINEIN: Off  in 0 out 1
 out static Line Input
RLINEIN: Off  in 0 out 1
 out static Line Input
MICIN: Off  in 1 out 0
 in  static Mic Bias
 out static Mic Bias
Mic Bias: Off  in 1 out 0
 in  static Int Mic
 in  static MICIN
 out static MICIN
Line Input: Off  in 0 out 1
 in  static RLINEIN
 in  static LLINEIN
 out Line In Input Mux
Input Mux: Off  in 0 out 1
 in  Line In Line Input
 out static ADC
ADC: Off  in 0 out 1
 in  static Input Mux
RHPOUT: Off  in 0 out 1
 in  static Output Mixer
ROUT: Off  in 0 out 1
 in  static Output Mixer
LHPOUT: Off  in 0 out 1
 in  static Output Mixer
 out static Ext Spk
LOUT: Off  in 0 out 1
 in  static Output Mixer
DAC: Off  in 0 out 4
 out HiFi Playback Switch Output Mixer
Output Mixer: Off  in 0 out 4
 in  HiFi Playback Switch DAC
 out static LOUT
 out static LHPOUT
 out static ROUT
 out static RHPOUT
