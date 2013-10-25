From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Enable display power well management in HD-A driver on
 Baytrail platform (Valleyview SOC)
Date: Fri, 25 Oct 2013 09:20:02 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F8013CBF2B@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 1AC262654D9
 for <alsa-devel@alsa-project.org>; Fri, 25 Oct 2013 11:20:07 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Takashi Iwai (tiwai@suse.de)" <tiwai@suse.de>
Cc: "Li, Jocelyn" <jocelyn.li@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Barnes,
 Jesse" <jesse.barnes@intel.com>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>, "David Henningsson (david.henningsson@canonical.com)" <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

We want to enable display power well management on Batrail platform (Valleyview SOC), similar to what we did on Haswell.
Would you please check if our ideas are ok and give some advice?

For Valleyview/VLV the display controller has a power well island. When display is off, the display island can be power gated.
Unlike Haswell, the VLV HD-A controller is not in the display power well. The controller is in south bridge and shared by multiple codecs, same as the predecessors of Haswell.

To assure audio is not disturbed by power well off, the Gfx i915 driver will provide the same API as Haswell: i915_request_power_well & i915_release_power_well
So audio driver can indicate whether audio codec needs the power well.

In HD-A driver, the display codec can suspend to D3 when there this no active streaming or ioctls which will actually trigger transactions to the display codec on HD-A bus.
So our basic idea is to request power before codec resumes to D0 and release power after codec suspends to D3.
And there can be two options for this:

1.       Overwrite the 'set_power_state' ops for the VLV display codec, and request/release Gfx power well there via the i915 API in this ops.

And future VLV specific fixes may also go to this ops.

2.       Add two new codec ops like 'pre_resume/post_suspend', and request/release Gfx power well here.
Which way do you think is better? Personally I don't want to add new ops and prefer 1st option, and VLV-like processors can use the same ops.
And there is an open question:
Can we assume that middleware (e.g. pulseaudio or audio flinger) will close the PCM device if there is no need to play audio for power saving?
Is this a usual way for middleware to work with ALSA?
Now in HD-A driver, once the PCM device is open, the codec will resume to D0. And so the codec will request display power well.
If middleware opens PCM device but doesn't play, there will be power waste. We want to avoid this.

Thanks
Mengdong
