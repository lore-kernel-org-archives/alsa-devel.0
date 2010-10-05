From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: asihpi: Control naming
Date: Tue, 05 Oct 2010 09:07:27 +0200
Message-ID: <4CAACEAF.2070208@ladisch.de>
References: <4CA4078E.6010601@audioscience.com>
	<s5h62xng4wm.wl%tiwai@suse.de>	<4CA4F1D8.50800@audioscience.com>
	<s5haamz9che.wl%tiwai@suse.de> <4CAAB343.9040603@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 719BB1038F7
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Oct 2010 09:07:00 +0200 (CEST)
In-Reply-To: <4CAAB343.9040603@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eliot Blennerhassett <linux@audioscience.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Eliot Blennerhassett wrote:
> Further on the subject of playback vs capture vs other...
> Of course we do have controls that are obviously "Playback" or "Capture",
> however we also have controls that connect PCM out to PCM in i.e. both
> Playback and Capture are involved,
> 
> "PCM0 to PCM1 Playback Capture Volume"  .. nooo!
> "PCM0 to PCM1 Loop Volume"  ???

Capture controls affect audio data that is recorded by the computer.
Playback controls affect audio data that comes out of the sound card.

With this definition, these controls are clearly capture controls,
e.g., "PCM0 to PCM1 Loopback Capture Volume".

> and others that connect linein to lineout ie. neither Capture or
> Playback involved.
> 
> "LineIn2 to LineOut3 Volume"
> maybe "LineIn2 to LineOut3 Loop Volume" ?

Monitoring controls like these are playback controls:
"LineIn2 to LineOut3 Monitor Playback Volume"


If your card has so many controls that you need a special mixer
application, the exact control names don't matter anyway.


Regards,
Clemens
