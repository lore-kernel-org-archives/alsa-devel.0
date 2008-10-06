From: ext-jukka.hynninen@vaisala.com
Subject: Re: ASoC WM8510 Mic PGA problem
Date: Mon, 6 Oct 2008 13:53:34 +0300
Message-ID: <B9D3C48C98930741A166756A50C44A610F17B55A@helx1.corp.vaisala.com>
References: <B9D3C48C98930741A166756A50C44A610F17B555@helx1.corp.vaisala.com>
	<20081003133936.GD26035@sirena.org.uk>
	<B9D3C48C98930741A166756A50C44A610F17B556@helx1.corp.vaisala.com>
	<20081006100522.GB14087@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw.vaisala.com (mailgw.vaisala.com [192.81.123.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 5C6BE2441C
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Oct 2008 12:53:49 +0200 (CEST)
Received: from helsrv02.vaisala.com (helsrv02.vaisala.com [192.81.123.16])
	by mailgw.vaisala.com (8.13.6/8.13.6) with SMTP id m96ArZPQ020392
	for <alsa-devel@alsa-project.org>; Mon, 6 Oct 2008 13:53:35 +0300
Content-class: urn:content-classes:message
In-Reply-To: <20081006100522.GB14087@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@sirena.org.uk
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Quoting Mark Brown:


>> report that the mixer control state is [off] again. Looking at the
>> codec_reg on sysfs verifies that the PGA Mute bit (0x2d:6) is set.
> Could you confirm when the state of the control changes - looks like
> it's when the recording/playback start?

The control changes state when recording starts. Playback has no effect
on it.

> Ah, right.  I don't suppose I could persuade you to join the efforts
> testing Sedji Gaouaou's recent code to unify the AT91 and AVR32 ASoC
> platform support?  Geoffrey Wossum did offer to help out with that
> already.

I'm going to give it a try during this week anyway. I'll let you know
what it feels like. 


-Jukka
