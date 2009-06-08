From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: M-Audio Transit: alsamixer shows 100% and -0.5db
 at the same time !?
Date: Mon, 08 Jun 2009 13:39:57 +0200
Message-ID: <4A2CF88D.8050203@ladisch.de>
References: <d9690f190906080213g5103efd7mf2a9bdd7aeeb131@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 8DE511037F9
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Jun 2009 13:39:47 +0200 (CEST)
In-Reply-To: <d9690f190906080213g5103efd7mf2a9bdd7aeeb131@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Klaus Schulz <kls.schlz@googlemail.com>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Klaus Schulz wrote:
> My M-Audio Transit shows at 100% and 0.5db attentuation in alsamixer at the
> same time.

"100%" just means that the control has its maximum value.

> See below printout.

This is not a printout of alsamixer.

>   Front Left: Playback 254 [100%] [0.50dB] [on]
>   Front Right: Playback 254 [100%] [0.50dB] [on]

I can see neither "-0.5dB" nor "0.5dB attenuation" in there; it's 0.5 dB
gain.  (If you actually run alsamixer, it gets labeled with "gain".)


Best regards,
Clemens
