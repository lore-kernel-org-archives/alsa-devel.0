From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Re: [PATCH] Fix Jack plugin
Date: Thu, 04 Aug 2011 16:11:45 +0200
Message-ID: <4E3AA8A1.7090808@drcomp.erfurt.thur.de>
References: <4E3A2FB4.5000502@familyross.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [85.14.220.160])
	by alsa0.perex.cz (Postfix) with ESMTP id A1E9824466
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Aug 2011 16:11:52 +0200 (CEST)
Received: from localhost (ltw.loris.tv [127.0.0.1])
	by ltw.loris.tv (Postfix) with ESMTP id B33A05001A7
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Aug 2011 16:11:51 +0200 (CEST)
Received: from ltw.loris.tv ([127.0.0.1])
	by localhost (ltw.loris.tv [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 3mYa0vgzd4dI for <alsa-devel@alsa-project.org>;
	Thu,  4 Aug 2011 16:11:46 +0200 (CEST)
Received: from [IPv6:2001:638:906:2:216:17ff:fe47:deab] (hex.inf-ra.uni-jena.de
	[IPv6:2001:638:906:2:216:17ff:fe47:deab])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by ltw.loris.tv (Postfix) with ESMTPSA id 0E5BA5001A2
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Aug 2011 16:11:46 +0200 (CEST)
In-Reply-To: <4E3A2FB4.5000502@familyross.net>
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

On 08/04/2011 07:35 AM, Kevin Ross wrote:

> I've uploaded a patch to ticket 2727, at 
> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2727
> 
> The symptom:  Using the Jack plugin causes whatever program is 
> outputting audio to hang after about 10-20 seconds.
> 
> The cause: The plugin creates a pipe, so that the fd's could be polled 
> to indicate completion of a transfer.  However, the call to write() 
> blocks when playing audio, as nothing actually reads from the pipe, and 
> it fills up until it blocks.
> 
> The patch:
> 
> --- alsa-plugins-1.0.23/jack/pcm_jack.c 2010-04-16 04:11:10.000000000 -0700
> +++ alsa-plugins-1.0.23.new/jack/pcm_jack.c     2011-08-03 
> 21:54:51.795378947 -0700
> @@ -307,6 +308,18 @@
>          return 0;
>   }
> 
> +static int make_nonblock(int fd) {
> +       int fl;
> +
> +       if ((fl = fcntl(fd, F_GETFL)) < 0)
> +               return fl;
> +
> +       if (fl & O_NONBLOCK)
> +               return 0;
> +
> +       return fcntl(fd, F_SETFL, fl | O_NONBLOCK);
> +}
> +
>   static int snd_pcm_jack_open(snd_pcm_t **pcmp, const char *name,
>                               snd_config_t *playback_conf,
>                               snd_config_t *capture_conf,
> @@ -363,6 +376,9 @@
> 
>          socketpair(AF_LOCAL, SOCK_STREAM, 0, fd);
> 
> +       make_nonblock(fd[0]);
> +       make_nonblock(fd[1]);
> +
>          jack->fd = fd[0];
> 
>          jack->io.version = SND_PCM_IOPLUG_VERSION;

Confirmed to be working. I'm going to send a git patch ASAP.



Cheers
