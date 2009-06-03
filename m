From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Requesting opinions and experiences concerning
 laptops and external microphones
Date: Wed, 03 Jun 2009 17:57:25 -0600
Message-ID: <4A270DE5.5040309@gmail.com>
References: <4A26F0D9.8020506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f206.google.com (mail-gx0-f206.google.com
	[209.85.217.206])
	by alsa0.perex.cz (Postfix) with ESMTP id 0DB6E103801
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Jun 2009 01:57:28 +0200 (CEST)
Received: by gxk2 with SMTP id 2so586071gxk.8
	for <alsa-devel@alsa-project.org>; Wed, 03 Jun 2009 16:57:27 -0700 (PDT)
In-Reply-To: <4A26F0D9.8020506@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: komputes <komputes@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

komputes wrote:
> I am trying to gather opinions and experiences from the ALSA developer
> community to understand what they expect to happen when they plug in an
> analog microphone into their laptops (which already has a built in mic).
> 
> I am looking for more of an official ALSA document which states how
> capture should change when an analogue microphone is plugged in; should
> it takeover from the internal microphone or not? Is there specification,
> standard, or "correct" behavior which is applied to this process?
> 
> If I am not mistaking, the computer can detect a signal/message when the
> jack goes in, right? The expected behavior when plugging in headphones
> is that the headphones are detected, the speakers are muted and the
> audio is channeled to the headphones. Is this not applicable to external
> microphone and the internal microphone as well?
> 
> -komputes

That rather depends on the how the audio controller works and the 
hardware capabilities. In some cases this might happen in hardware 
without the driver needing to do anything. Or it's possible the two 
inputs have separate ADCs, etc.
