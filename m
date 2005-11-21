From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: fifo_size
Date: Mon, 21 Nov 2005 11:11:49 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0511211108350.10364@tm8103.perex-int.cz>
References: <1132517980.9292.13.camel@localhost.localdomain>
 <s5hy83inwtm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 269D1169
	for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2005 11:11:50 +0100 (MET)
In-Reply-To: <s5hy83inwtm.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Adrian McMenamin <adrian@mcmen.demon.co.uk>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 21 Nov 2005, Takashi Iwai wrote:

> At Sun, 20 Nov 2005 20:19:39 +0000,
> Adrian McMenamin wrote:
> > 
> > Is it still the case that this member of the pcm_hardware_t is unused -
> > I am scanning through driver code where it has been set and wonder if
> > there is a use for it?
> 
> Nothing, so far.
> I think we can remove this field, since it's misleading.

I think that old ISA chips like CS4232 have FIFOs. The original purpose 
for this field was to inform application about extra latency before the 
signal goes out of soundcard (and versa vice for capture). But yes, in 
most cases we don't have any exact info about buffering / FIFO usage in 
the soundchips, so we can rename this field as reserved and remove 
functions from alsa-lib.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
