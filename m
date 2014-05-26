From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 2/2] ASoC: dapm: Add a helper to get the
 platform for DAPM kcontrol
Date: Mon, 26 May 2014 22:17:59 +0530
Message-ID: <20140526164759.GH21128@intel.com>
References: <1401106136-3745-1-git-send-email-vinod.koul@intel.com>
 <1401106136-3745-2-git-send-email-vinod.koul@intel.com>
 <5383419F.9040105@metafoo.de> <20140526162345.GG21128@intel.com>
 <5383714C.6020809@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id B7246261A2F
 for <alsa-devel@alsa-project.org>; Mon, 26 May 2014 19:04:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <5383714C.6020809@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Kp Jeeja <jeeja.kp@intel.com>, alsa-devel@alsa-project.org, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Mon, May 26, 2014 at 06:52:28PM +0200, Lars-Peter Clausen wrote:
> On 05/26/2014 06:23 PM, Vinod Koul wrote:
> >On Mon, May 26, 2014 at 03:29:03PM +0200, Lars-Peter Clausen wrote:
> >>On 05/26/2014 02:08 PM, Vinod Koul wrote:
> >>[...]
> >>>+ * snd_soc_dapm_kcontrol_platform() - Returns the platform associated to a kcontrol
> >>>+ * @kcontrol: The kcontrol
> >>>+ */
> >>>+struct snd_soc_platform *snd_soc_dapm_kcontrol_platform(
> >>>+		struct snd_kcontrol *kcontrol)
> >>>+{
> >>>+	return dapm_kcontrol_get_wlist(kcontrol)->widgets[0]->platform;
> >>>+}
> >>>+EXPORT_SYMBOL_GPL(snd_soc_dapm_kcontrol_platform);
> >>
> >>This conflicts with the series that moves DAPM support to the
> >>component level [1].
> >
> >Thanks for the pointer, has this series been merged?
> >Dont see it in topic/core in Mark's tree.
> 
> It hasn't been merged yet.
Okay, what is the state of the series? Would it merged soonish? If this is
approach going to be taken then we need to plan for intercepting this

> >
> >I will take a look but fwiw this statement is not entirely true in the cover
> >letter of patch:
> >
> >"This will allow any component to have DAPM widgets and routes, which was
> >previously only possible for CODECs, and will allow any component to have DAPM
> >widgets with controls (i.e. Mixers and MUXs), which was previously only possible
> >for CODECs"
> >
> >I am already running a system which models platform and has Mixers,
> >Muxes and works fine (tested on 3.10 and 3.14).
> 
> It works if you use custom controls. But it does not work with the
> standard SOC_DAPM_* controls.
Not sure as we are using SOC_DAPM but yes with *_E versions and our own get/put
handlers with additional dapm event handlers.
I have also tested with a version which used non _E versions and only dapm event
handlers. So not sure where you found it difficult. I was able to model a fiarly
complex DSP and able to do both playback as well as loopback tests.

We haven't wrriten our own SOC_DAPM_* controls yet.

> >Few bits of code is in RFC I sent earlier and will post these in detail over
> >next few weeks
> 
> Do you think it is necessary that these two patches get merged
> before you send the other patches? It would be good to see things in
> context. That will make it easier to properly review patch 1 of this
> series.
Actually yes, as our mixer/mux get and put handlers would need to find the
platform pointer as well as set and get the values.

-- 
~Vinod
