From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: What does snd_pcm_delay() actually return?
Date: Thu, 12 Jun 2008 23:00:06 +0200
Message-ID: <20080612210005.GC20818@tango.0pointer.de>
References: <20080609190225.GA4534@tango.0pointer.de>
	<s5h1w333o7r.wl%tiwai@suse.de> <g2pc9p$16h$1@ger.gmane.org>
	<s5hod670x1s.wl%tiwai@suse.de> <g2r2j5$g3$1@ger.gmane.org>
	<s5hwskurh3h.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 28BC424A71
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Jun 2008 23:00:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hwskurh3h.wl%tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

On Thu, 12.06.08 14:08, Takashi Iwai (tiwai@suse.de) wrote:

> AFAIK, the problem here is that the handling of hwptr isn't
> inconsistent in the pulse plugin.  The definition of hwptr is the
> point being played (or at least, the point where it was already
> processed).  So, it's fine that you take the network latency into
> account for calculation of hwptr like the pulse delay callback
> actually does.
> 
> But, then, pointer callback also must contain the same latency.  If
> the hwptr with network latency doesn't work well, then delay callback
> shouldn't have the latency as well.

But we need the network latency in there, because it is necessary for
doing a/v synchronization. The network latency can be quite
substantial. 

The "hw_ptr/appl_ptr" is just too simple to cover the networked
cases. 

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
