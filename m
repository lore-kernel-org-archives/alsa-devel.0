From: "Arve Knudsen" <arve.knudsen@gmail.com>
Subject: Re: snd_pcm_drain and lockups
Date: Wed, 5 Sep 2007 19:19:10 +0200
Message-ID: <a0d6258d0709051019q4f507148ndabea8f9077cda69@mail.gmail.com>
References: <a0d6258d0709041403s5e084541q203af02df22458eb@mail.gmail.com>
	<s5hzm016ycq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.232])
	by alsa0.perex.cz (Postfix) with ESMTP id CB47A24339
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Sep 2007 19:19:12 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id m22so1398890nzf
	for <alsa-devel@alsa-project.org>; Wed, 05 Sep 2007 10:19:11 -0700 (PDT)
In-Reply-To: <s5hzm016ycq.wl%tiwai@suse.de>
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi

On 9/5/07, Takashi Iwai <tiwai@suse.de> wrote:
>
> At Tue, 4 Sep 2007 23:03:27 +0200,
> Arve Knudsen wrote:
> >
> > Hello
> >
> > Users of the PortAudio library on top of ALSA-lib have reported that it
> may
> > hang in a call to snd_pcm_drain. I have also been able to confirm that
> this
> > can happen in conjunction with the dmix device at least. Can the ALSA
> > developers please tell me how, if at all, snd_pcm_drain may be safely
> used?
> > Is this function simply best avoided (snd_pcm_drop being the
> alternative)?
>
> Of course, it's supposed to be safe to use :)  But, it's hard to tell
> you more unless I get the details in your case...
>
> In which situation is it called?  Are they multi-threaded?


The lock-up happens in a background thread within PortAudio. What has been
known to cause lock-ups at least is that PA restarts the device after the
detection of an xrun. This procedure entails first draining the stream
(snd_pcm_drain), the dmix and front devices have been known to lock up here
(I've experienced it with dmix at least). I've googled a bit on the problem,
and I didn't find a whole lot of evidence of this problem, but I did find
this: http://www.ohloh.net/projects/5344/contributors/32264/commits/10293341
.

Arve
