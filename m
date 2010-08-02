From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [RFC 0/2] soc-dapm or TWL4030: Runtime DAPM ordering
	problem
Date: Mon,  2 Aug 2010 10:08:13 +0300
Message-ID: <1280732895-29010-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 1415010381F
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Aug 2010 09:08:33 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Hello Mark, Liam,

I'm facing the following problem with the TWL4030 codec:
The order of DAPM register write order different in case, when I start a capture
operation after setting up the routing, and when I change the routing during
active capture.
This is really visible, when I want to record from the digital microphone
interface.
Because of this ordering problem, when during active capture I switch to the
digital mic from analog path, the codec would enable analog bias (2.2 volts) to
the digital mic for a moment, and than later it will switch to the correct
digital mic bias (1.8 volts).
Since the twl4030 codec needs several bits in different registers to be changed,
when I change between analog and digital input it is not that obvious how to get
the correct ordering all the time.

I have two different ways to fix this:
A: by reordering how DAPM would handle control changes (patch 1)
B: by changing TWL4030 internal DAPM widgets (patch 2)

Obviously only one of the two patch is needed, and I'm really not sure if the
change in soc-dapm is a correct one, since it will affect all codec driver, and
could potentially cause unexpected glitches.

Some more thoughts..
A: Reordering in soc-dapm.
Currently this is how it works:
A.1 Route setup, followed by capture
- User selects the digimic0 interface (DAPM_MUX_E)
  ADCMICSEL:	TX1IN_SEL->1	MUX_E(TX1 Capture Route) enum register
				selects digital path
  MICBIAS_CTL:	MICBIAS1_CTL->1 MUX_E(TX1 Capture Route) POST_REG
				select digimic bias (1.8 volts)
- Capture starts
  MICBIAS_CTL:	MICBIAS1_EN->1 	MICBIAS(Mic Bias 1) power
				enables the micbias1/digimic0 bias (1.8 volts)
  ADCMICSEL:	DIGIMIC0_EN->1	PGA_E(Digimic0 Enable) power
				enable the digimic0 interface

A.2 Changing from analog path to digital path during capture
- User selects the digimic0 interface from analog source
  AVADC_CTL:	ADCL_EN->0	PGA(ADC Physical Left) power
				turn off ADC left
  ANAMICL:	MICAMPL_EN->0	MIXER(Analog Left) power
				turn off mic amp on analog path
  MICBIAS_CTL:	MICBIAS1_EN->1	MICBIAS(Mic Bias 1) power
				enables the micbias1/digimic0 bias (2.2 volts)
  ADCMICSEL:	DIGIMIC0_EN->1	PGA(Digimic0 Enable) power
				enable the digimic0 interface
  ADCMICSEL:	TX1IN_SEL->1	MUX_E(TX1 Capture Route) enum register
				selects digital path
  MICBIAS_CTL:	MICBIAS1_CTL->1	MUX_E(TX1 Capture Route) POST_REG
				select digimic bias (1.8 volts)

With the reordering in soc-dapm, only the runtime order is going to change:
A.2
  ADCMICSEL:	TX1IN_SEL->1	MUX_E(TX1 Capture Route) enum register
				selects digital path
  MICBIAS_CTL:	MICBIAS1_CTL->1	MUX_E(TX1 Capture Route) POST_REG
				select digimic bias (1.8 volts)
  AVADC_CTL:	ADCL_EN->0	PGA(ADC Physical Left) power
				turn off ADC left
  ANAMICL:	MICAMPL_EN->0	MIXER(Analog Left) power
				turn off mic amp on analog path
  MICBIAS_CTL:	MICBIAS1_EN->1	MICBIAS(Mic Bias 1) power
				enables the micbias1/digimic0 bias (1.8 volts)
  ADCMICSEL:	DIGIMIC0_EN->1	PGA(Digimic0 Enable) power
				enable the digimic0 interface

So first DAPM would do the change in the register, than goes on and check the
needed things to be done in the DAPM tree. This works with the TWL codec, but
I'm not sure what are the implication on other codecs.
But from the ordering point of view now there is no difference between 'cold
start' or runtime change in DAPM write sequence.

B: Reordering in TWL4030 codec driver
The sequence will look like this:
B.1 Route setup, followed by capture
- User selects the digimic0 interface (DAPM_MUX_E)
  ADCMICSEL:	TX1IN_SEL->1	MUX(TX1 Capture Route) enum register
				selects digital path
- Capture starts
  MICBIAS_CTL:	MICBIAS1_CTL->1 SUPPLY(micbias1 select) power
				select digimic bias (1.8 volts)
  MICBIAS_CTL:	MICBIAS1_EN->1 	MICBIAS(Mic Bias 1) power
				enables the micbias1/digimic0 bias (1.8 volts)
  ADCMICSEL:	DIGIMIC0_EN->1	PGA_E(Digimic0 Enable) power
				enable the digimic0 interface

B.2 Changing from analog path to digital path during capture
- User selects the digimic0 interface from analog source
  AVADC_CTL:	ADCL_EN->0	PGA(ADC Physical Left) power
				turn off ADC left
  ANAMICL:	MICAMPL_EN->0	MIXER(Analog Left) power
				turn off mic amp on analog path
  MICBIAS_CTL:	MICBIAS1_CTL->1	SUPPLY(micbias1 select) power
				select digimic bias (1.8 volts)
  MICBIAS_CTL:	MICBIAS1_EN->1	MICBIAS(Mic Bias 1) power
				enables the micbias1/digimic0 bias (1.8 volts)
  ADCMICSEL:	DIGIMIC0_EN->1	PGA(Digimic0 Enable) power
				enable the digimic0 interface
  ADCMICSEL:	TX1IN_SEL->1	MUX(TX1 Capture Route) enum register
				selects digital path

In this case the order is still not the same, but at least I avoid feeding wrong
bias to the digimic interface.

I need either the soc-dapm.c patch _or_ the patch against twl4030 codec to solve
my problem.
Do you see another way to actually solve this problem?
Which approach is acceptable for you?

The series generated on top of (needs th previous TWL DAPM fix):
git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6.git:for-2.6.36

Thank you,
Peter

---
Peter Ujfalusi (2):
  ASoC: soc-dapm: Reorder DAPM register write sequence
  ASoC: TWL4030: Capture route runtime DAPM ordering fix

 sound/soc/codecs/twl4030.c |   48 +++++++++++---------------------------------
 sound/soc/soc-dapm.c       |   41 ++++++++++++++++++++++--------------
 2 files changed, 37 insertions(+), 52 deletions(-)

--
1.7.2
