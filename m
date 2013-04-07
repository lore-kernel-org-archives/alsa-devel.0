From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH] ALSA: hda - delay resume haswell hdmi
 codec in system resume
Date: Sun, 7 Apr 2013 00:10:46 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F83752F5@SHSMSX101.ccr.corp.intel.com>
References: <1364321572-2634-1-git-send-email-mengdong.lin@intel.com>
 <51517F53.7070608@canonical.com>
 <F46914AEC2663F4A9BB62374E5EEF8F8363D66@SHSMSX101.ccr.corp.intel.com>
 <5152AB91.4050501@canonical.com>
 <F46914AEC2663F4A9BB62374E5EEF8F8365EC0@SHSMSX101.ccr.corp.intel.com>
 <515AC6AC.8040504@canonical.com>	<s5hr4it6s7n.wl%tiwai@suse.de>
 <515AD3E4.2000208@canonical.com>	<s5hmwtd2ksk.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F837402E@SHSMSX101.ccr.corp.intel.com>
 <s5hk3og3o47.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E2702650A4
 for <alsa-devel@alsa-project.org>; Sun,  7 Apr 2013 02:10:50 +0200 (CEST)
In-Reply-To: <s5hk3og3o47.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Saturday, April 06, 2013 1:05 AM


> > > > Immediate playback:
> > > >   1. System skips hda_call_codec_resume and sets
> codec->resume_delayed.
> > > >   2. Process context wants to start playback, which powers up the
> > > > codec and calls intel_haswell_set_power_state.
> > > >   3. intel_haswell_wait_ready_to_resume enables unsol events and
> > > > starts to wait on ready_to_resume
> > > >   4. Gfx init finishes, and workq context fires the unsol event,
> > > > which calls hdmi_intrinsic_event, which triggers the resume_wq.
> > > >   5. Process context and workq context now continues in parallel,
> > > > potentially (but hopefully not) leading to race conditions?
> > >
> > > The current patch has a small race, but it can be avoided by
> > > clearing
> > > spec->ready_to_resume early enough, e.g. in suspend callback or in
> > > init callback, like the patch below.
> > >
> >
> > I think there is no race for Haswell. In my test I observed that the
> > unsol evnet will not be received until intel_haswell_wait_ready_to_resume()
> enables the unsol event on the pins.
> > So I put "spec->ready_to_resume = 0" before enabling the unsol event.
> 
> Practically your patch would work well, but theoretically the unsol event might
> be issued and handled by hdmi_intrinsic_event() before you go into
> intel_haswell_wait_ready_to_resume().  That is, you _clear_
> spec->ready_to_resume again and wait for the unsol event that had been
> already processed.  That's the race David pointed.
> 
> The fix is simply not to clear spec->ready_to_resume in
> intel_haswell_wait_ready_to_resume() but clear it much earlier already before
> the resume path as my patch does.  Then wait_event() passes immediately
> (and the unsol enablement of is anyway harmless).
> 

Hi Takashi,

I see. Thanks for clarifying!

I'll revise the patch and test it again when I'm in office on Monday.
Also I'll rebase the patch to for-next branch of sound git tree and fix the indentations and spaces errors.

Thanks
Mengdong
