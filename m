From: Stefan Schoenleitner <dev.c0debabe@gmail.com>
Subject: Re: "Resource temporarily unavailable" while reading
 although poll returns POLLIN event
Date: Wed, 21 Apr 2010 18:15:40 +0200
Message-ID: <4BCF24AC.3000301@gmail.com>
References: <4BCEE140.5060704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from keymachine.tbmn.org (mail.tbmn.org [87.118.84.39])
	by alsa0.perex.cz (Postfix) with ESMTP id 35B692451D
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Apr 2010 18:15:43 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by keymachine.tbmn.org (Postfix) with ESMTP id 7BE6D8AC5C7
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Apr 2010 18:15:41 +0200 (CEST)
Received: from keymachine.tbmn.org ([127.0.0.1])
	by localhost (keymachine.tbmn.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K1ktHZnN-uJM for <alsa-devel@alsa-project.org>;
	Wed, 21 Apr 2010 18:15:41 +0200 (CEST)
Received: from [192.168.1.5] (chello080108001212.35.11.tuwien.teleweb.at
	[80.108.1.212])
	(using SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: mne@tbmn.org)
	by keymachine.tbmn.org (Postfix) with ESMTPSA id 3C9AF8AC5C1
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Apr 2010 18:15:41 +0200 (CEST)
In-Reply-To: <4BCEE140.5060704@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Stefan Schoenleitner wrote:
> Since a POLLIN event only occurs after at least a full period is available for
> reading (as set up by snd_pcm_sw_params_set_avail_min() above)
> and I only read after a POLLIN event occured on the capture device fd,
> I really do not understand why I get the above error.

By using snd_pcm_avail_update() I found out that polling on the PCMs
*does not work at all*.

Although I verified that avail_min is 160 frames, polling on the
capture/playback PCMs returns a POLLIN/POLLOUT event even if the number
of frames for reading/writing *is less than avail_main*.

I also tried snd_pcm_wait() which should also wait until there are at
least avail_min frames available for reading/writing.
The result is the same: snd_pcm_avail_update() shows that it returns
even if there are far less than avail_min frames available for processing.

I suspect that this is a bug in ALSA ?


cheers,
stefan
