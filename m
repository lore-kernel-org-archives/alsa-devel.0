From: Glenn Maynard <glenn@zewt.org>
Subject: Re: snd_pcm_wait returning EPIPE
Date: Mon, 11 Oct 2004 10:11:57 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041011141156.GU12858@zewt.org>
References: <20041007152634.GK12858@zewt.org> <s5hwtxx4kxn.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from h0040333b7dc3.ne.mediaone.net (h00045a576c6a.ne.client2.attbi.com [65.96.98.23])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 954CD27D
	for <alsa-devel@alsa-project.org>; Mon, 11 Oct 2004 16:12:03 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <s5hwtxx4kxn.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 11, 2004 at 12:18:44PM +0200, Takashi Iwai wrote:
> At Thu, 7 Oct 2004 11:26:34 -0400,
> Glenn Maynard wrote:
> > 
> > I've disabled the underrun state, eg. setting
> > snd_pcm_sw_params_set_stop_threshold to dsnd_pcm_sw_params_get_boundary,
> > which results in EPIPE never being returned from snd_pcm_wait (as I wanted),
> > so I can handle underruns myself.  I'm opening hw:0 directly, to avoid
> > resampling.
> > 
> > However, I'm receiving a report of a system returning EPIPE:
> > 
> > https://sourceforge.net/tracker/index.php?func=detail&aid=1035604&group_id=37892&atid=421366
> > https://sourceforge.net/tracker/download.php?group_id=37892&atid=421366&file_id=103978&aid=1035604
> > 
> > This is apparently on an x86-64 system.
> > 
> > Is this a known problem?  Am I probably doing something wrong that just
> > happens to usually work?  I'm treating EPIPE as an unexpected condition,
> > since it's not clear why it would happen here; should I have it call
> > snd_pcm_prepare() and retry anyway?
> 
> -EPIPE is usually buffer over/underrun (XRUN), so apps are supposed to
> call snd_pcm_prepare() after receiving this.

Right, I understand that.  However, the docs say:

"PCM is automatically stopped in SND_PCM_STATE_XRUN state when available
frames is >= threshold. If the stop threshold is equal to boundary (also
software parameter - sw_param) then automatic stop will be disabled
(thus device will do the endless loop in the ring buffer)."

However, after setting the stop threshold to boundary, I'm still getting
this.

The bug report says:

"...  tried to use 32 bits binaries after having installed all the necessary
32 bits libraries and having loaded the module snd-ioctl32 necessary when a 32
applications tries to link with 64 bits alsa drivers."

This is the only report of this I've received.  Could there be a problem
related to snd-ioctl32?  I don't know exactly what the default boundary
value represents, but it appears to be 0x40000000 on my system; if that
scales to a similar 64-bit value (such as 0x4000000000000000) inside the
64-bit ALSA drivers, I could see problems.  (But I'll stop guessing ...)

-- 
Glenn Maynard


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
