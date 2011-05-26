From: Tanu Kaskinen <tanuk@iki.fi>
Subject: Re: Negative volume steps?
Date: Thu, 26 May 2011 15:45:32 +0300
Message-ID: <1306413932.4306.83.camel@jarl>
References: <1306408004.4306.53.camel@jarl>  <4DDE46C3.5000006@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gw1.cc.tut.fi (mail-gw1.cc.tut.fi [130.230.160.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 14BA11038AD
	for <alsa-devel@alsa-project.org>;
	Thu, 26 May 2011 14:45:37 +0200 (CEST)
In-Reply-To: <4DDE46C3.5000006@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-05-26 at 14:25 +0200, Clemens Ladisch wrote:
> Tanu Kaskinen wrote:
> > If a driver claims that the lowest volume step (integer step, not dB) of
> > a volume element is -126 and the highest step is 0, is the driver
> > broken?
> 
> No.
> 
> > I'm asking, because apparently there are such drivers, but Pulseaudio
> > currently assumes that the volume steps are never negative.
> 
> The maximum is higher than the minimum, so how would a step be negative?

By "step" I mean the step index, ie. the volume value, not the
difference between two volumes.

> What exactly is the problem with PulseAudio?

Too many assumptions. Thanks for your answer, Pulseaudio needs fixing.

-- 
Tanu
