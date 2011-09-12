From: Raymond Toy <rtoy@google.com>
Subject: Re: Getting the actual HW sample rate
Date: Mon, 12 Sep 2011 13:59:33 -0700
Message-ID: <CAE3TgXGJLaAyv8KU-esg2QpSobSYRoNW6YKr22w245mLX3bWQQ@mail.gmail.com>
References: <CAE3TgXHC+C6xBxD_A_qZUm8TtN0V3GBo7kKLxDkasOZ50WDH=Q@mail.gmail.com>
	<4E68788D.8040306@ladisch.de>
	<CAE3TgXFj7i=H-0Z9wn5uOnhUOHnXe3wPD1MS9qZnUhjP32-0MA@mail.gmail.com>
	<4E6E6BBA.3020904@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out.google.com (smtp-out.google.com [74.125.121.67])
	by alsa0.perex.cz (Postfix) with ESMTP id 4D2AD2438A
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Sep 2011 22:59:41 +0200 (CEST)
Received: from wpaz37.hot.corp.google.com (wpaz37.hot.corp.google.com
	[172.24.198.101]) by smtp-out.google.com with ESMTP id p8CKxeoL031186
	for <alsa-devel@alsa-project.org>; Mon, 12 Sep 2011 13:59:40 -0700
Received: from yie16 (yie16.prod.google.com [10.243.66.16])
	by wpaz37.hot.corp.google.com with ESMTP id p8CKwNJo011397
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <alsa-devel@alsa-project.org>; Mon, 12 Sep 2011 13:59:39 -0700
Received: by yie16 with SMTP id 16so2863208yie.15
	for <alsa-devel@alsa-project.org>; Mon, 12 Sep 2011 13:59:34 -0700 (PDT)
In-Reply-To: <4E6E6BBA.3020904@ladisch.de>
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

On Mon, Sep 12, 2011 at 1:29 PM, Clemens Ladisch <clemens@ladisch.de> wrote:

> Raymond Toy wrote:
> > On Thu, Sep 8, 2011 at 1:10 AM, Clemens Ladisch <clemens@ladisch.de
> > <mailto:clemens@ladisch.de>> wrote:
> >
> >     Add the SND_PCM_NO_AUTO_RESAMPLE flag when calling snd_pcm_open, or
> use
> >     snd_pcm_hw_params_set_rate_resample.
> >
> > Some further experimentation with this has confused me.  I changed the
> > sample code to call snd_pcm_hw_params_set_rate_resample with resample =
> 0.
> >
> > When I run the code without an .asoundrc (defaulting to pulse audio, I
> > think), I get sample rrates : 1-192000.
>
> The pulse plugin does not support this flag.
>

Well, that explains it of course.  Thanks for your help!

Ray
