From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Negative volume steps?
Date: Thu, 26 May 2011 14:25:39 +0200
Message-ID: <4DDE46C3.5000006@ladisch.de>
References: <1306408004.4306.53.camel@jarl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 8116D103868
	for <alsa-devel@alsa-project.org>;
	Thu, 26 May 2011 14:23:28 +0200 (CEST)
In-Reply-To: <1306408004.4306.53.camel@jarl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tanu Kaskinen <tanuk@iki.fi>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Tanu Kaskinen wrote:
> If a driver claims that the lowest volume step (integer step, not dB) of
> a volume element is -126 and the highest step is 0, is the driver
> broken?

No.

> I'm asking, because apparently there are such drivers, but Pulseaudio
> currently assumes that the volume steps are never negative.

The maximum is higher than the minimum, so how would a step be negative?

What exactly is the problem with PulseAudio?


Regards,
Clemens
