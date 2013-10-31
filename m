From: Tobias Klausmann <klausman-alsa@schwarzvogel.de>
Subject: Re: Audinst HUD-mx2 covertly muting itself
Date: Thu, 31 Oct 2013 11:28:30 +0100
Message-ID: <20131031102830.GA81849@skade.schwarzvogel.de>
References: <20131031101137.GA75354@skade.schwarzvogel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.schwarzvogel.de (skade.schwarzvogel.de [144.76.18.87])
 by alsa0.perex.cz (Postfix) with ESMTP id E17AA2608E9
 for <alsa-devel@alsa-project.org>; Thu, 31 Oct 2013 11:28:30 +0100 (CET)
Received: from klausman by mail.schwarzvogel.de with local (Exim 4.82)
 (envelope-from <klausman@schwarzvogel.de>) id 1VbpUM-000LVE-IJ
 for alsa-devel@alsa-project.org; Thu, 31 Oct 2013 11:28:30 +0100
Content-Disposition: inline
In-Reply-To: <20131031101137.GA75354@skade.schwarzvogel.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi! 

On Thu, 31 Oct 2013, Tobias Klausmann wrote:
> $ aplay -l
> **** List of PLAYBACK Hardware Devices ****
> card 0: HUDmx2 [Audinst HUD-mx2], device 0: USB Audio [USB Audio]
>   Subdevices: 0/1
>   Subdevice #0: subdevice #0
> card 0: HUDmx2 [Audinst HUD-mx2], device 1: USB Audio [USB Audio #1]
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
> 
> While the device works right in principle, every time an app
> closes the device, it mutes itself (or crash, this may be a Hw
> problem). There is no indication of the broken state in the mixer
> displays of alsamixer or alsamixer-gui, and amixer output does
> not indicate any change, either (see below). 

Oh, and to fix it, I can just mute-unmute ("cycle") the device
"PCM 1" (no levels, just a switch).

Regards,
Tobias

-- 
Aussen Stop-Bits, innen gepackt!
