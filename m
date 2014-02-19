From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: About 'SNDRV_PCM_CLASS_MULTI' for devices with
	multi-channels
Date: Wed, 19 Feb 2014 20:40:43 +0100
Message-ID: <530508BB.6060802@canonical.com>
References: <5304C64D.3090400@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 1175E265D09
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 20:40:46 +0100 (CET)
In-Reply-To: <5304C64D.3090400@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 02/19/2014 03:57 PM, Takashi Sakamoto wrote:
> Hi all,
> 
> I have two questions about the usage of this macro.
> 
> Should I use this macro for new drivers which I'm working for?'
> http://mailman.alsa-project.org/pipermail/alsa-devel/2014-January/071820.html
> 
> 
> My drivers support some firewire devices, which is desinged for
> studio-use and have many channels. Its combination of channels are not
> designed for surround sound like 5.1ch.
> 
> Just judging from its name, 'SNDRV_PCM_CLASS_MULTI', I should use this.
> But there are no drivers which use this macro in current tree, against
> my expectation that some drivers (ICE1712-pro, RME9652, 6fire usb and so
> on) should use this macro.
> 
> Are there any reasons?

I've never heard of it before. I had a quick look in alsa-lib and
couldn't find any difference in handling between CLASS_GENERIC and
CLASS_MULTI.

It's probably something historic that nobody uses any more. Maybe people
who have been along longer knows what it is.

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
