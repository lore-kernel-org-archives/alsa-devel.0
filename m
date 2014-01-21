From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Need your advice: Add a new communication inteface
 between HD-Audio and Gfx drivers for hotplug notification/ELD update
Date: Tue, 21 Jan 2014 12:35:53 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F82B231778@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A38E261603
 for <alsa-devel@alsa-project.org>; Tue, 21 Jan 2014 13:36:00 +0100 (CET)
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
To: "Takashi Iwai (tiwai@suse.de)" <tiwai@suse.de>, "Barnes, Jesse" <jesse.barnes@intel.com>, "Daniel Vetter (daniel@ffwll.ch)" <daniel@ffwll.ch>, "Zanoni, Paulo R" <paulo.r.zanoni@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
List-Id: alsa-devel@alsa-project.org

Dear audio and gfx stakeholders,

We hope to add a new interface between audio and gfx driver, for gfx driver to notify audio about HDMI/DP hot-plug and ELD update.
Would you please share some comments on the proposal below?

Background of this issue: On Intel Haswell/Broadwell platforms, there is a HW restriction that after the display HD-Audio controller is in D3,
it cannot be waken up by HDMI/DP hot-plug. Consequently, although the gfx driver can still detect the HDMI/DP hot-plug,
audio driver has no idea about this and cannot notify user space whether the external HDMI/DP monitor is available for audio playback,
because the audio controller cannot wake up to D0 and receive HW unsolicited event about hot-plug from the audio codec.
This limitation will affect user space to decide whether we can output audio over HDMI/DP.

To solve the above limitation, Takashi suggested to add a new communication interface between audio and gfx driver: create a common object
containing the ops registered by both graphics and audio drivers, then communicate through it, something like vga_switcheroo.

Is it okay to create this kernel object in i915 driver?

I915 can export an API like "display_register_audio_client" for audio driver to register a client and hot-plug notification ops.

I915 can also call some API like "display_register_gfx_client" itself and register ops for audio driver to query monitor presence and ELD info on a specific port.
It would be faster for audio driver than quering ELD by command/response over the HD-A bus, thus avoid delay in i915 mode set.
This will also avoid waking up the audio devices unnecessarily if the user space does not really want to use HDMI/DP for audio playback.

Whenever i195 enables/disables audio on a port in modeset, it can call some API like "display_set_audio_state()" on this kernel object and trigger notifications to the audio driver.

When the audio driver is probed (in the delayed probe stage), it can request i915 API symbol to register the audio client for this communication kernel object.
Since the 1st i915 mode set may happen before audio driver registers the ops, we'll let audio driver check ELD once after registering the audio client ops.
And for the platforms which uses this communication interface, we can disable unsolicited event for HDMI/DP hot-plug in the audio driver.

We hope to hear your feedback and start to work out more details.

Thanks & Best Regards
Mengdong
