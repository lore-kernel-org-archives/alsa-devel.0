From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] cmi8330: add OPL3 support
Date: Wed, 21 Jan 2009 12:14:55 +0100
Message-ID: <497703AF.7000703@ladisch.de>
References: <20090121081816.b3d1246b.krzysztof.h1@poczta.fm>	<4976D3A2.70608@ladisch.de>	<s5hljt52iqo.wl%tiwai@suse.de>
	<20090121104320.4bfe9db6.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 765E924334
	for <alsa-devel@alsa-project.org>; Wed, 21 Jan 2009 12:15:01 +0100 (CET)
In-Reply-To: <20090121104320.4bfe9db6.krzysztof.h1@poczta.fm>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Takashi Iwai <tiwai@suse.de>, Alsa-devel <alsa-devel@alsa-project.org>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

Krzysztof Helt wrote:
> The test returns: "Timer time out!!". However, it returns the same
> for the SC-6000 board which has the Yamaha YMF 262-M chip which is
> supposed to have the Adlib timers.

Then that chip does not forward the timer interrupt to the computer,
and its driver should not create a timer device either.


Best regards,
Clemens
