From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: ALSA problems with simultaneous Capture and
	playback
Date: Wed, 9 May 2007 14:15:20 -0400
Message-ID: <75b66ecd0705091115n6f3a4665j27dca22be3ed0251@mail.gmail.com>
References: <8d6898730705091106l5ad0acl772b3dc4fd0d5fbb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.226])
	by alsa0.perex.cz (Postfix) with ESMTP id AEC772448F
	for <alsa-devel@alsa-project.org>;
	Wed,  9 May 2007 20:15:22 +0200 (CEST)
Received: by wr-out-0506.google.com with SMTP id 58so276344wri
	for <alsa-devel@alsa-project.org>; Wed, 09 May 2007 11:15:21 -0700 (PDT)
In-Reply-To: <8d6898730705091106l5ad0acl772b3dc4fd0d5fbb@mail.gmail.com>
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
To: Nobin Mathew <nobin.mathew@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 5/9/07, Nobin Mathew <nobin.mathew@gmail.com> wrote:
> One read and write handle 256 frames.
>
> Write seems to be OK, but read fails
>
> State 4 is SND_PCM_STATE_XRUN
>
> why this XRUN is happening?

If your hardware buffer is small you may need to run your application
with realtime priority (SCHED_FIFO) to avoid xruns.

I guess this is a custom driver?  Please post a link to the source code.

Lee
