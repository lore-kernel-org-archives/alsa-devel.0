From: Tobias Klausmann <klausman-alsa@schwarzvogel.de>
Subject: Re: Audinst HUD-mx2 covertly muting itself
Date: Thu, 31 Oct 2013 17:15:17 +0100
Message-ID: <20131031161517.GA53495@skade.schwarzvogel.de>
References: <20131031101137.GA75354@skade.schwarzvogel.de>
 <52727D15.90907@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.schwarzvogel.de (skade.schwarzvogel.de [144.76.18.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 67170265774
 for <alsa-devel@alsa-project.org>; Thu, 31 Oct 2013 17:15:19 +0100 (CET)
Received: from klausman by mail.schwarzvogel.de with local (Exim 4.82)
 (envelope-from <klausman@schwarzvogel.de>) id 1Vbutx-000HTs-68
 for alsa-devel@alsa-project.org; Thu, 31 Oct 2013 17:15:17 +0100
Content-Disposition: inline
In-Reply-To: <52727D15.90907@ladisch.de>
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

On Thu, 31 Oct 2013, Clemens Ladisch wrote:
> Tobias Klausmann wrote:
> > While the device works right in principle, every time an app
> > closes the device, it mutes itself (or crash, this may be a Hw
> > problem). There is no indication of the broken state in the mixer
> > displays of alsamixer or alsamixer-gui, and amixer output does
> > not indicate any change, either (see below).
> 
> The USB Audio Specification defines a mechanism with which a device
> could notify the PC of changes in mixer controls.  However, this device
> does not have such a mechanism, so this looks like a firmware bug.
> 
> Does this happen for both the analog and digital outputs?

The place the device is currently at doesn't have the Hw for me
to test digital output. I will test this (and the one below) as
after next week

> > The vendor does not officially support anything but Windows
> 
> Does it work correctly in Windows without any vendor-supplied driver?

See above.

I have gotten a temporary workaround: use the secondary PCM
device (hw:0,1) instead of the primary (hw:0,0), like this:

$ cat .asoundrc 
defaults.pcm.card 0
defaults.pcm.device 1
$

While this works, it's not eactly a discoverable way of doing it.
Obviously, this should go into the system-wide asoundrc so all
users benefit from it, but in this case, it works for me.

Maybe something along the lines of PCI device "quirks" would be
the right thing to do? I.e. swapping the two PCM devices from
ALSA's point of view.

Regards,
Tobias
