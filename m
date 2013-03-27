From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH] ALSA: hda - delay resume haswell hdmi
 codec in system resume
Date: Wed, 27 Mar 2013 02:03:49 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F8363D66@SHSMSX101.ccr.corp.intel.com>
References: <1364321572-2634-1-git-send-email-mengdong.lin@intel.com>
 <51517F53.7070608@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id E171A261725
 for <alsa-devel@alsa-project.org>; Wed, 27 Mar 2013 03:03:53 +0100 (CET)
In-Reply-To: <51517F53.7070608@canonical.com>
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
To: David Henningsson <david.henningsson@canonical.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: alsa-devel-bounces@alsa-project.org
> [mailto:alsa-devel-bounces@alsa-project.org] On Behalf Of David Henningsson
> Sent: Tuesday, March 26, 2013 6:58 PM


> Just a question: Is there a difference between real system S3 here, and just the
> normal idle power down? I e, I'm a little unsure myself, but it seems like this 300
> ms delay would trigger in both cases, causing an
> (unnecessary?) 300 ms delay every time the codec is idle and you want to start
> playback. Is this correct, or did I get something wrong?


Hi David,

Thanks for your feedback!
There will not be 300ms delay every time in normal idle power down case.

Only the system resume will delay resuming a codec and cause a waiting on first codec access (eg. 1st playback ) after a system resume. Snd_hda_resume(), called by azx_resume(), will check whether a codec can support delay resume, skip these codecs and set the flag "resume_delayed" on them. Normal idle power down will not touch this flag. 

The Haswell codec set_power_state ops (intel_haswell_set_power_state) will only wait if this is a delayed resume and clear this flag after waiting. And actually, there is no waiting even in this case. Because when 1st user operation after system resume happens, Gfx already finishes resuming and audio initialization, so as long as intel_haswell_wait_ready_to_resume() enable the unsol event, the unsol event comes and so so waiting finishes. The 300ms time out is set for safety consideration in case unsol event is lost. I've not observed any unsol event lost till now.

BTW, would you please tell us how Ubuntu decides whether to enable the normal idle power down (parameter "power_save")?
We found this bug on a Haswell mobile machine with "power_save" disabled, which means only system resume will program the codec back to D0. But on a another machine with "power_save" enabled, this bug is not visible because later runtime codec power up can program the codec to D0 and unmute the pin again.

Thanks
Mengdong
