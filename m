From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ALSA Fireworks driver
Date: Fri, 17 Jun 2011 09:15:48 +0200
Message-ID: <4DFAFF24.9000401@ladisch.de>
References: <4DFAF3AC.3030506@nostar.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 35F4B2442D
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Jun 2011 09:12:48 +0200 (CEST)
In-Reply-To: <4DFAF3AC.3030506@nostar.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Doug McLain <doug@nostar.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Doug McLain wrote:
> I came across your fireworks driver the other day, and would like to get
> involved.  Has there been any discussion on this anywhere or have you
> been completely on your own?  I did a search of alsa-devel and didn't
> find anything, suprisingly.

You should've searched ffado-devel and linux1394-devel.

> It seems like native alsa support of what
> seems to me to be the first FW device would be the talk of the town. :)

*cough*
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;hb=HEAD;f=sound/firewire/Kconfig

> I built the driver as a module on F15 and loaded it on my AF12, and 
> found it in /proc/asound/cards, and tried to start jack on it and it 
> failed to start for duplex, capture, or playback, just FYI.

In theory, this should have worked.  What exactly does "failed" mean?


Regards,
Clemens
