From: Glenn Maynard <glenn@zewt.org>
Subject: Re: snd_pcm_wait returning EPIPE
Date: Mon, 11 Oct 2004 11:26:20 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041011152620.GW12858@zewt.org>
References: <20041007152634.GK12858@zewt.org> <s5hwtxx4kxn.wl@alsa2.suse.de> <20041011141156.GU12858@zewt.org> <s5hfz4l4741.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from h0040333b7dc3.ne.mediaone.net (h00045a576c6a.ne.client2.attbi.com [65.96.98.23])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 44AD82D8
	for <alsa-devel@alsa-project.org>; Mon, 11 Oct 2004 17:26:24 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <s5hfz4l4741.wl@alsa2.suse.de>
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

On Mon, Oct 11, 2004 at 05:17:18PM +0200, Takashi Iwai wrote:
> A good point.  I guess you're right here.  The 32bit ioctl wrapper
> doesn't take care of the boundary value at all.
> 
> Could you try the attached patch?

Not directly, since I don't have access to the machine, but I'll pass it
on to the user and let you know.  Thanks.

-- 
Glenn Maynard


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
