From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: alsactl adds volume controls?
Date: Fri, 27 Aug 2010 17:43:05 +0200
Message-ID: <4C77DD09.3060909@ladisch.de>
References: <4C77CE1D.2070501@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 854922463E
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Aug 2010 17:43:09 +0200 (CEST)
In-Reply-To: <4C77CE1D.2070501@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

David Henningsson wrote:
> So I've discovered that my sound card has a "PCM Playback Volume"
> control, but changing that control does not alter the volume.
> 
> Interestingly enough, this control does not come from the HDA parser, it
> is added by alsactl at boot time...!

This control was created by the software volume plugin.  When not using
this plugin, the control does not have any effect.

To get rid of it, delete its entry from /etc/asound.state.


Regards,
Clemens
