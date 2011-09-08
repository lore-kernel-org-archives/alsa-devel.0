From: Raymond Toy <rtoy@google.com>
Subject: Re: Getting the actual HW sample rate
Date: Thu, 8 Sep 2011 15:26:25 -0700
Message-ID: <CAE3TgXFBh7QVNcd_PwZhu4KYi6BdZEz1Nowkh3DYJwanP_XNpg@mail.gmail.com>
References: <CAE3TgXHC+C6xBxD_A_qZUm8TtN0V3GBo7kKLxDkasOZ50WDH=Q@mail.gmail.com>
	<4E68788D.8040306@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out.google.com (smtp-out.google.com [74.125.121.67])
	by alsa0.perex.cz (Postfix) with ESMTP id AAC1924DD1
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Sep 2011 00:26:28 +0200 (CEST)
Received: from hpaq1.eem.corp.google.com (hpaq1.eem.corp.google.com
	[172.25.149.1]) by smtp-out.google.com with ESMTP id p88MQSIA022222
	for <alsa-devel@alsa-project.org>; Thu, 8 Sep 2011 15:26:28 -0700
Received: from gyg13 (gyg13.prod.google.com [10.243.50.141])
	by hpaq1.eem.corp.google.com with ESMTP id p88MQQ4A003597
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <alsa-devel@alsa-project.org>; Thu, 8 Sep 2011 15:26:27 -0700
Received: by gyg13 with SMTP id 13so1226945gyg.8
	for <alsa-devel@alsa-project.org>; Thu, 08 Sep 2011 15:26:25 -0700 (PDT)
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
Thanks!  This works very nicely with the sample code from the link.

Ray
