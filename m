From: Anders =?iso-8859-1?Q?Bostr=F6m?= <anders@netinsight.se>
Subject: Re: [Pkg-alsa-devel] Bug#438118: alsa-utils: aplay
 non-blocking mode isn't working
Date: Fri, 14 Dec 2007 11:37:36 +0100 (CET)
Message-ID: <20071214.113736.1254634191.anders@netinsight.se>
References: <s5hzlzkrn8r.wl%tiwai@suse.de>
	<20070927.141629.1300548182.anders@netinsight.se>
	<s5hsl4ktvxn.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ernst.netinsight.se (ernst.netinsight.se [212.247.11.2])
	by alsa0.perex.cz (Postfix) with SMTP id 50E89243CE
	for <alsa-devel@alsa-project.org>; Fri, 14 Dec 2007 11:37:44 +0100 (CET)
In-Reply-To: <s5hsl4ktvxn.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, 438118@bugs.debian.org
List-Id: alsa-devel@alsa-project.org

>>>>> "TI" == Takashi Iwai <tiwai@suse.de> writes:

 TI> OK, thanks, I see the problem now.
 >> 
 TI> I don't remember whether it's a feature or a bug.  The drain ioctl
 TI> rejects the non-block mode.
 >> 
 >> I can understand the idea here, that in non-blocking mode, no call
 >> should block, ever. But on the other hand, if you call the drain
 >> ioctl, you probably expect it to work, even in non-blocking mode. Why
 >> would you otherwise call it?

 TI> Yes, that's my opinion, too.  This particular ioctl is to block the
 TI> operation, so it should be allowed as long as it's called.

 TI> But I vaguely remember that we discussed about it, and the current
 TI> form is the result of that.  Namely, we can call
 TI> snd_pcm_nonblock(FALSE) explicitly before calling snd_pcm_drain().

 TI> Though, I prefer fixing the behavior in the core side to allow the
 TI> blocking with this call...  Any reasonable objections in mind?

Any progress in including a solotion to this bug in mainstream
alsa & linux kernel? Has anything been done? The patch works fine for
me...

/ Anders
