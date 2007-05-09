From: "Nobin Mathew" <nobin.mathew@gmail.com>
Subject: Fwd: ALSA problems with simultaneous Capture and
	playback
Date: Wed, 9 May 2007 23:57:54 +0530
Message-ID: <8d6898730705091127s5be65749u5cdeb4f0cec0de17@mail.gmail.com>
References: <8d6898730705091106l5ad0acl772b3dc4fd0d5fbb@mail.gmail.com>
	<75b66ecd0705091115n6f3a4665j27dca22be3ed0251@mail.gmail.com>
	<8d6898730705091127o400c5a97kad360ef51d262aa2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.235])
	by alsa0.perex.cz (Postfix) with ESMTP id F016D24498
	for <alsa-devel@alsa-project.org>;
	Wed,  9 May 2007 20:27:55 +0200 (CEST)
Received: by wr-out-0506.google.com with SMTP id 58so280436wri
	for <alsa-devel@alsa-project.org>; Wed, 09 May 2007 11:27:54 -0700 (PDT)
In-Reply-To: <8d6898730705091127o400c5a97kad360ef51d262aa2@mail.gmail.com>
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

---------- Forwarded message ----------
From: Nobin Mathew <nobin.mathew@gmail.com>
Date: May 9, 2007 11:57 PM
Subject: Re: [alsa-devel] ALSA problems with simultaneous Capture and playback
To: Lee Revell <rlrevell@joe-job.com>


when I do capture and Playback independently for any channel
configurations and any sampling rate configuration it works perfectly.

Following configuration of simutaneous playback and capture work.
loop "line out" and "line in" externaly using stereo jack.
start arecord and then start aplay.
Then it records properly.


The application which is giving erorr is custom application which sets
params properly.

if i run "aplay" and "arecord" first (after boot) and then i run my
application then it works properly.

reverse is not working (i.e. running my app first destroys whole ALSA,
then even arecord and aplay is not working).



On 5/9/07, Lee Revell <rlrevell@joe-job.com> wrote:
> On 5/9/07, Nobin Mathew <nobin.mathew@gmail.com> wrote:
> > One read and write handle 256 frames.
> >
> > Write seems to be OK, but read fails
> >
> > State 4 is SND_PCM_STATE_XRUN
> >
> > why this XRUN is happening?
>
> If your hardware buffer is small you may need to run your application
> with realtime priority (SCHED_FIFO) to avoid xruns.
>
> I guess this is a custom driver?  Please post a link to the source code.
>
> Lee
>
