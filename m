From: komputes <komputes@gmail.com>
Subject: Requesting opinions and experiences concerning laptops
 and external microphones
Date: Wed, 03 Jun 2009 17:53:29 -0400
Message-ID: <4A26F0D9.8020506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f171.google.com (mail-qy0-f171.google.com
	[209.85.221.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 0EE2C1038CF
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Jun 2009 23:53:41 +0200 (CEST)
Received: by qyk1 with SMTP id 1so522594qyk.16
	for <alsa-devel@alsa-project.org>; Wed, 03 Jun 2009 14:53:41 -0700 (PDT)
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

I am trying to gather opinions and experiences from the ALSA developer
community to understand what they expect to happen when they plug in an
analog microphone into their laptops (which already has a built in mic).

I am looking for more of an official ALSA document which states how
capture should change when an analogue microphone is plugged in; should
it takeover from the internal microphone or not? Is there specification,
standard, or "correct" behavior which is applied to this process?

If I am not mistaking, the computer can detect a signal/message when the
jack goes in, right? The expected behavior when plugging in headphones
is that the headphones are detected, the speakers are muted and the
audio is channeled to the headphones. Is this not applicable to external
microphone and the internal microphone as well?

-komputes
