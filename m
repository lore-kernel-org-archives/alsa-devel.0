From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: dsnoop issues
Date: Fri, 27 Apr 2007 15:00:22 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0704271446570.8211@tm8103.perex-int.cz>
References: <4631EC14.2060802@btinternet.com> <s5h4pn2yovg.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 0C43F2417E
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Apr 2007 15:00:23 +0200 (CEST)
In-Reply-To: <s5h4pn2yovg.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>, Gordon Miller <gordonamiller@btinternet.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 27 Apr 2007, Takashi Iwai wrote:

> At Fri, 27 Apr 2007 13:27:00 +0100,
> Gordon Miller wrote:
> > 
> > Hi
> > 
> > All my snd_pcm_readi calls return too few frames. Also when I switch to 
> > stereo, the sound is muted. I cannot change this by adjusting period & 
> > buffer sizes. dsnoop is enabled by default. The documentation for 
> > snd_pcm_readi says that the only way that the frame count can be short 
> > is because of a signal or xrun. Well this clearly isn't the case.
> 
> Actually, the documentation is wrong, IMO.  The typical behavior of
> read syscall is that it returns a value actually read by that call.
> It doesn't guarantee whether the requested size is filled, and can be
> shorter than requested.  As snd_pcm_readi() emulates the read syscall,
> it should behave in that way.

I don't think so completely. For blocking mode (!O_NONBLOCK), all possible 
data should be read. Only signal or an error should break this.

The read logic for dsnoop is in snd_pcm_read_areas() in pcm/pcm.c 
(alsa-lib).

> The blocking mode means that the function waits until the threshold
> (watermark) condition is fulfilled.

I don't think so. The snd_pcm_read_areas() does only xfer_align alignment 
for wrong user input. If less frames are returned, then it is an error 
IMO.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
