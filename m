From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Need a little help with underruns / fullduplex
Date: Sat, 21 Jun 2003 09:25:16 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0306210921530.9621-100000@pnote.perex-int.cz>
References: <20030620191413.GE4116@pruts.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030620191413.GE4116@pruts.nl>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "alsa@zevv.nl" <alsa@zevv.nl>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 20 Jun 2003, alsa@zevv.nl wrote:

> 	while(1) {
> 		
> 		r = snd_pcm_readi(pcmr, buf, BUFSIZE);
> 
> 		if(r != BUFSIZE) printf("rec  r=%d\n", r);
> 		checkr(r);
> 
> 		r = snd_pcm_writei(pcmp, buf, BUFSIZE);
> 
> 		if(r != BUFSIZE) printf("play r=%d\n", r);
> 		if(r == -EPIPE) {
> 			snd_pcm_prepare(pcmp);
> 		} else {
> 			checkr(r);
> 		}
> 
> 	}


This loop is definitely wrong. I explained several times why. You cannot 
do while (1) { read(); write(); } but:

/* prefill the playback buffer with the desired latency */
while (!minimal_latency_reached)
	write();
start_capture();
start_playback();
/* normal loop */
while (1) {
	read();
	write();
}

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
