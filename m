From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: [PATCH 1/4] pulse: get rid of a number of assert()s
Date: Fri, 31 Jul 2009 15:48:32 +0100
Message-ID: <h4v080$v96$1@ger.gmane.org>
References: <20090731140133.GA31121@omega>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id D5E912456B
	for <alsa-devel@alsa-project.org>;
	Fri, 31 Jul 2009 16:48:48 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MWtPa-0005i8-KV
	for alsa-devel@alsa-project.org; Fri, 31 Jul 2009 14:48:46 +0000
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 31 Jul 2009 14:48:46 +0000
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 31 Jul 2009 14:48:46 +0000
In-Reply-To: <20090731140133.GA31121@omega>
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

'Twas brillig, and Lennart Poettering at 31/07/09 15:01 did gyre and gimble:
> Instead of hitting an assert when any of the plugin functions is called
> in an invalid context we should return a clean error to make sure
> programs are not unnecessarily aborted.
> 
> This should fix issues such as http://pulseaudio.org/ticket/595
> ---
>  pulse/ctl_pulse.c |   35 +++++++++++++++++------
>  pulse/pcm_pulse.c |   79 +++++++++++++++++++++++++++++++++++++++++------------
>  pulse/pulse.c     |   34 ++++++++++++++++-------
>  3 files changed, 111 insertions(+), 37 deletions(-)
> 
> diff --git a/pulse/ctl_pulse.c b/pulse/ctl_pulse.c
> index c6cf9e2..1b057ef 100644
> --- a/pulse/ctl_pulse.c
> +++ b/pulse/ctl_pulse.c

> @@ -525,8 +542,8 @@ static int pulse_ctl_poll_revents(snd_ctl_ext_t * ext, struct pollfd *pfd,
>  	snd_ctl_pulse_t *ctl = ext->private_data;
>  	int err = 0;
>  
> -	assert(ctl);
> -	assert(ctl->p);
> +	if (!ctl->p || !ctl->p->mainloop || !ctl->p->context)
> +		return -EBADFD;
>  
>  	pa_threaded_mainloop_lock(ctl->p->mainloop);
>  


Just a smidge overzealous in this one (only one I spotted).


Couldn't find these commits in your alsa-plugins clone at 
git://git.0pointer.de/alsa-plugins.git so couldn't create a followup 
patch so here it is inline (against 1.2.20 so line numbers may be off):

--- alsa-plugins-1.0.20/pulse/ctl_pulse.c~	2009-07-31 15:39:22.000000000 
+0100
+++ alsa-plugins-1.0.20/pulse/ctl_pulse.c	2009-07-31 15:47:32.000000000 
+0100
@@ -542,6 +542,8 @@
  	snd_ctl_pulse_t *ctl = ext->private_data;
  	int err = 0;

+	assert(ctl);
+
  	if (!ctl->p || !ctl->p->mainloop || !ctl->p->context)
  		return -EBADFD;




Col.




-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
   Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
   Mandriva Linux Contributor [http://www.mandriva.com/]
   PulseAudio Hacker [http://www.pulseaudio.org/]
   Trac Hacker [http://trac.edgewall.org/]
