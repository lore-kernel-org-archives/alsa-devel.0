From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd_pcm_delay, hw buffers and driver api (v2)
Date: Fri, 14 Aug 2009 14:13:00 +0200
Message-ID: <4A8554CC.2060009@ladisch.de>
References: <alpine.DEB.1.10.0908140023240.3417@ecabase.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 28A7E24721
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Aug 2009 14:13:08 +0200 (CEST)
In-Reply-To: <alpine.DEB.1.10.0908140023240.3417@ecabase.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kai Vehmanen <kvehmanen@eca.cx>
Cc: alsa-devel@alsa-project.org, Ujfalusi Peter <peter.ujfalusi@nokia.com>, ext-eero.nurkkala@nokia.com
List-Id: alsa-devel@alsa-project.org

Kai Vehmanen wrote:
> ...
> In both cases, this value (hw_ptr) shows the status of sending data to an 
> separate entity, and one that has its own buffer (multiple ms) before the 
> actual DAC/ADC.
> 
> So when application developer uses snd_pcm_delay(), the result is not 
> quite what the ALSA API says: ...

snd_pcm_avail() returns the free part of the buffer.
snd_pcm_delay() returns the filled part of the buffer plus
the additional delay imposed by the device.

The additional delay can be set by the driver in
pcm_substream->runtime->delay.  (Currently, only
the USB audio driver bothers to set this.)


HTH
Clemens
