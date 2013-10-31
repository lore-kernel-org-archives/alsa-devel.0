From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Audinst HUD-mx2 covertly muting itself
Date: Thu, 31 Oct 2013 16:53:57 +0100
Message-ID: <52727D15.90907@ladisch.de>
References: <20131031101137.GA75354@skade.schwarzvogel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id E06CC261A3C
 for <alsa-devel@alsa-project.org>; Thu, 31 Oct 2013 16:54:27 +0100 (CET)
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
To: Tobias Klausmann <klausman-alsa@schwarzvogel.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Tobias Klausmann wrote:
> While the device works right in principle, every time an app
> closes the device, it mutes itself (or crash, this may be a Hw
> problem). There is no indication of the broken state in the mixer
> displays of alsamixer or alsamixer-gui, and amixer output does
> not indicate any change, either (see below).

The USB Audio Specification defines a mechanism with which a device
could notify the PC of changes in mixer controls.  However, this device
does not have such a mechanism, so this looks like a firmware bug.

Does this happen for both the analog and digital outputs?

> The vendor does not officially support anything but Windows

Does it work correctly in Windows without any vendor-supplied driver?


Regards,
Clemens
