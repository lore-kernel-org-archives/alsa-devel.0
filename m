From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: Unable to open plughw:0,0 from user program.
Date: Thu, 23 Aug 2007 18:13:59 -0400
Message-ID: <75b66ecd0708231513r2e416d09rff2bacd860761fec@mail.gmail.com>
References: <46CDD5A8.3000006@cox.net> <s5hlkc2yrax.wl%tiwai@suse.de>
	<46CDF600.6030509@cox.net>
	<75b66ecd0708231429p41ede740q73d34461d00fa130@mail.gmail.com>
	<46CE0123.2030707@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.240])
	by alsa0.perex.cz (Postfix) with ESMTP id 7EA7810380B
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Aug 2007 00:14:00 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c36so75329ana
	for <alsa-devel@alsa-project.org>; Thu, 23 Aug 2007 15:13:59 -0700 (PDT)
In-Reply-To: <46CE0123.2030707@cox.net>
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
> And it must be my problem.  It must have been started by default because
> I didn't start it.  I'll see if I can configure it to share the sound
> card or disable it.

I would disable it, as you have seen, sound server is not necessary to
share the soundcard anymore - alsa-lib/dmix handles it.

Lee
