From: Stephen Warren <swarren@nvidia.com>
Subject: ASoC: One HW register bit affecting two paths
Date: Tue, 26 Apr 2011 11:47:43 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04973BBD1E@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id D18CB24433
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Apr 2011 20:47:52 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Mark Brown (broonie@opensource.wolfsonmicro.com)" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Mark,

There's one small issue with the WM8903 DMIC patch I sent recently:

In HW, there's a single control bit that affects two paths. This is
currently represented as two widgets, Left ADC Input and Right ADC
Input, each having its own control, both of which point at the same
register bit.

When alsamixer sets one of these controls, both the Left ADC Input and
Right ADC Input controls read back with the value that was set, since
they both read from the same register bit. However, if only one of the
controls is actually manipulated, then only the paths associated with
that single widget are updated by dapm_mux_update_power. To solve this,
the user must currently also toggle the other control back to the
original value and then to the new value in order to update the paths.

I can see some possible ways to solve this, presented below:

Solution 1: Applying updates to N controls:

Modify snd_soc_dapm_put_* to search for and loop over all widgets using
the same control name or register bit(s) in, and perform the same update
for each.

Essentially, this is the same idea as solution 2 below, but with the
implementation performing all the comparisons within snd_soc_dapm_put_*,
rather than pre-computing the sharing arrangement when creating controls.

The disadvantage here is the perhaps significant run-time comparison
costs within the loop over all widgets. Also, each snd_soc_dapm_put_*
duplicates that same code, unless the control's .get/.put point at a
single unified ASoC function which implements the looping, and then
dispatches based on a different function pointer.


Solution 2: Sharing controls:

* When calling snd_soc_cnew, store a list of widgets in the control
  instead of a single widget.

* Modify snd_soc_dapm_{get,put}_* to retrieve the list of widgets, and
  iterate over them all.

* Modify dapm_new_{mux,*} to:

+ Search for an existing control with the same name.

+ If found: Add this widget to the list stored in the control.

+ If not found: Create a new control with a single-entry list containing
  the current widget. 

The advantage here is isolating the searching for widgets using the same
register bits to control creation rather than usage.

Data setup would be:

// Two mono muxes, sharing a control
SND_SOC_DAPM_MUX("Left ADC Input", SND_SOC_NOPM, 0, 0, &adcinput_mux),
SND_SOC_DAPM_MUX("Right ADC Input", SND_SOC_NOPM, 0, 0, &adcinput_mux),

// Existing style of path definitions
{ "Left ADC Input", "ADC", "Left Input PGA" },
{ "Left ADC Input", "DMIC", "DMICDAT" },
{ "Right ADC Input", "ADC", "Right Input PGA" },
{ "Right ADC Input", "DMIC", "DMICDAT" },
{ "ADCL", NULL, "Left ADC Input" },
{ "ADCL", NULL, "CLK_DSP" },
{ "ADCR", NULL, "Right ADC Input" },
{ "ADCR", NULL, "CLK_DSP" },


Solution 3: Stereo widgets:

* Modify w->{sources,sinks} to be arrays (an entry for each channel,
  probably just L/R entries initially)

* Modify path list parsing to allow source/sink widget names to contain
  a ":L"/":R" suffix indicating which w->sources[] array index to use.

The arrays would be required so that path traversal code wouldn't find
a false path from ADCR to Right Input PGA; the L/R connectivity needs
to be completely separate.

* snd_soc_dapm_add_route's "find src and dest widgets" loop would need
  to be enhanced to understand the new syntax, and be able to match up
  widget names by ignoring ":xxx" when searching, at least for widgets
  explicitly marked stereo.

* Other fallout of the above that I haven't thought through yet.

// A single stereo mux
SND_SOC_DAPM_MUX("ADC Input", SND_SOC_NOPM, 0, 0, &adcinput_mux),

// Enhanced style of path definitions
{ "ADC Input:L", "ADC", "Left Input PGA" },
{ "ADC Input:L", "DMIC", "DMICDAT" },
{ "ADC Input:R", "ADC", "Right Input PGA" },
{ "ADC Input:R", "DMIC", "DMICDAT" },
{ "ADCL", NULL, "ADC Input:R" },
{ "ADCL", NULL, "CLK_DSP" },
{ "ADCR", NULL, "ADC Input:R" },
{ "ADCR", NULL, "CLK_DSP" },


Do you have any other ideas how this might be solved, or a preference
for which solution to pursue?

Thanks.

-- 
nvpublic
