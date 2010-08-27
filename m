From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: alsactl adds volume controls?
Date: Fri, 27 Aug 2010 20:36:11 +0200
Message-ID: <4C78059B.50801@canonical.com>
References: <4C77CE1D.2070501@canonical.com> <4C77DD09.3060909@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 8BBCD2469B
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Aug 2010 20:36:16 +0200 (CEST)
In-Reply-To: <4C77DD09.3060909@ladisch.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010-08-27 17:43, Clemens Ladisch skrev:
> David Henningsson wrote:
>> So I've discovered that my sound card has a "PCM Playback Volume"
>> control, but changing that control does not alter the volume.
>>
>> Interestingly enough, this control does not come from the HDA parser, it
>> is added by alsactl at boot time...!
> 
> This control was created by the software volume plugin.  When not using
> this plugin, the control does not have any effect.
> 
> To get rid of it, delete its entry from /etc/asound.state.

Hmm, I wonder if this is an Ubuntu-specific bug then? Because when I run
Maverick (the upcoming Ubuntu release) from a Live-CD, the "PCM Playback
Volume" control is still there (and there is no asound.state, neither in
/etc or in /var/lib/alsa).
When I use the plughw interface, the "PCM Playback Volume" does not
affect volume output. Should I use another device string to test the
softvol plugin, to see if it's there or not?

Btw, I still think it's strange that a userspace plugin, with controls
that only effects userspace, still can create controls in kernel-space.
Am I missing something?

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
