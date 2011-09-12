From: Raymond Toy <rtoy@google.com>
Subject: Re: Getting the actual HW sample rate
Date: Mon, 12 Sep 2011 10:54:55 -0700
Message-ID: <CAE3TgXFj7i=H-0Z9wn5uOnhUOHnXe3wPD1MS9qZnUhjP32-0MA@mail.gmail.com>
References: <CAE3TgXHC+C6xBxD_A_qZUm8TtN0V3GBo7kKLxDkasOZ50WDH=Q@mail.gmail.com>
	<4E68788D.8040306@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out.google.com (smtp-out.google.com [74.125.121.67])
	by alsa0.perex.cz (Postfix) with ESMTP id 59656244D7
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Sep 2011 19:55:03 +0200 (CEST)
Received: from wpaz13.hot.corp.google.com (wpaz13.hot.corp.google.com
	[172.24.198.77]) by smtp-out.google.com with ESMTP id p8CHt1Yg004203
	for <alsa-devel@alsa-project.org>; Mon, 12 Sep 2011 10:55:01 -0700
Received: from gxk23 (gxk23.prod.google.com [10.202.11.23])
	by wpaz13.hot.corp.google.com with ESMTP id p8CHrmA9004948
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <alsa-devel@alsa-project.org>; Mon, 12 Sep 2011 10:54:59 -0700
Received: by gxk23 with SMTP id 23so201977gxk.8
	for <alsa-devel@alsa-project.org>; Mon, 12 Sep 2011 10:54:55 -0700 (PDT)
In-Reply-To: <4E68788D.8040306@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 8, 2011 at 1:10 AM, Clemens Ladisch <clemens@ladisch.de> wrote:

> Raymond Toy wrote:
> > In my application, we want ... to avoid yet another sample rate
> > conversion when playing out the audio.
>
> Add the SND_PCM_NO_AUTO_RESAMPLE flag when calling snd_pcm_open, or use
> snd_pcm_hw_params_set_rate_resample.
>
>
Some further experimentation with this has confused me.  I changed the
sample code to call snd_pcm_hw_params_set_rate_resample with resample = 0.

When I run the code without an .asoundrc (defaulting to pulse audio, I
think), I get sample rrates : 1-192000.

Is that right?

Ray
