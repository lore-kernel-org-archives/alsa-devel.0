From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: Unable to open plughw:0,0 from user program.
Date: Thu, 23 Aug 2007 17:29:45 -0400
Message-ID: <75b66ecd0708231429p41ede740q73d34461d00fa130@mail.gmail.com>
References: <46CDD5A8.3000006@cox.net> <s5hlkc2yrax.wl%tiwai@suse.de>
	<46CDF600.6030509@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.245])
	by alsa0.perex.cz (Postfix) with ESMTP id 35B7C243B2
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Aug 2007 23:29:47 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c36so73848ana
	for <alsa-devel@alsa-project.org>; Thu, 23 Aug 2007 14:29:45 -0700 (PDT)
In-Reply-To: <46CDF600.6030509@cox.net>
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
To: stan <stanl@cox.net>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 8/23/07, stan <stanl@cox.net> wrote:
> I don't think so.  Here is the output of fuser /dev/snd/*
> /dev/snd/pcmC0D0p:    3069m
> /dev/snd/timer:       3069

Looks like it's in use by process 3069?  What is that?

Lee
