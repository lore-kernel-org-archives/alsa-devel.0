From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH v3] pass ELD to HDMI/DP audio driver
Date: Fri, 5 Aug 2011 08:52:20 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF049F171F05@HQMAIL01.nvidia.com>
References: <yunk4atlwnr.fsf@aiko.keithp.com>
	<20110804094024.GB21137@localhost>	<yunsjph835u.fsf@aiko.keithp.com>
	<20110805124958.GA9531@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 26D131039DB
	for <alsa-devel@alsa-project.org>;
	Fri,  5 Aug 2011 17:52:30 +0200 (CEST)
In-Reply-To: <20110805124958.GA9531@localhost>
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
To: Wu Fengguang <fengguang.wu@intel.com>, Keith Packard <keithp@keithp.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Ben@alsa-project.org, "Wang,  Zhenyu Z" <zhenyu.z.wang@intel.com>, "intel-gfx@lists.freedesktop..." <intel-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Zhao, Yakui" <yakui.zhao@intel.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Skeggs <bskeggs@redhat.com>, Jeremy Bush <contractfrombelow@gmail.com>, Christopher White <c.white@pulseforce.com>, "Bossart,  Pierre-louis" <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org

Wu Fengguang wrote at Friday, August 05, 2011 6:50 AM:
> On Fri, Aug 05, 2011 at 02:03:41AM +0800, Keith Packard wrote:
> > On Thu, 4 Aug 2011 17:40:24 +0800, Wu Fengguang <fengguang.wu@intel.com> wrote:
...
> > > You may wonder why the mode parameter is needed in intel_write_eld().
> > > This is because the ELD field aud_synch_delay (ie. A/V sync delay) may
> > > have different values in progressive/interleaved display modes.
> >
> > Ok, so you can't write ELD data until the display is active, which
> > happens at mode_set time.
> >
> > Do you need to provide ELD when the display is inactive? Is this only to
> > enable audio output when the display is not on? In that case, we will
> 
> Good questions!  In general the audio functionalities should not
> depend on the display activeness. There are even audio-only HDMI
> devices. So I'll need to make intel_write_eld() work even without
> information about the current display mode.

Is there such a thing as an audio-only HDMI signal though; the audio data
is transferred inside the blanking region of the HDMI video signal, which
kinda implies that there needs to be some video content (even if the pixel
data is e.g. hard-coded black rather than being scanned out from a frame-
buffer) so as to define where those blanking regions are within the signal.

-- 
nvpublic
