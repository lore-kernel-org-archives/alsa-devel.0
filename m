From: Daniel Mack <zonque@gmail.com>
Subject: Re: snd-usb-audio: Substream status not set with new
	streaming logic
Date: Mon, 21 May 2012 12:42:39 +0200
Message-ID: <4FBA1C1F.2040802@gmail.com>
References: <CAFz=ag5u7Ks3e=9R_A5Scwk361Hw1fFLyr+StWU2hjxD40JMQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 61D60243C8
	for <alsa-devel@alsa-project.org>;
	Mon, 21 May 2012 12:42:46 +0200 (CEST)
Received: by bkcjg15 with SMTP id jg15so3943754bkc.38
	for <alsa-devel@alsa-project.org>; Mon, 21 May 2012 03:42:46 -0700 (PDT)
In-Reply-To: <CAFz=ag5u7Ks3e=9R_A5Scwk361Hw1fFLyr+StWU2hjxD40JMQw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Felix Homann <linuxaudio@showlabor.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On 11.05.2012 12:53, Felix Homann wrote:
> With the new streaming logic subs->running will never be set to 1. So
> /proc/... will never show the streams as running. Formerly the status
> was set in endpoint.c.
> 
> Daniel?

Well spotted. I'll submit a fix for that.


Thanks,
Daniel
