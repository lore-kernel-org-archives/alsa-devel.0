From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: HD Audio with 'mute light'
Date: Mon, 24 Sep 2012 10:12:19 +0200
Message-ID: <506015E3.1080605@canonical.com>
References: <20120922185411.GE2822@bzzt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 72F93261630
 for <alsa-devel@alsa-project.org>; Mon, 24 Sep 2012 10:12:20 +0200 (CEST)
In-Reply-To: <20120922185411.GE2822@bzzt.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnout Engelen <alsalist@bzzt.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 09/22/2012 08:54 PM, Arnout Engelen wrote:
> Hi,
>
> I've got a laptop with a HD Audio onboard sound card: the CX20590.
>
> It seems like this card has a sort of 'hardware mute state': the 'mute button'
> has a light, and when this light is on, no sound is heard, regardless of
> whether or not the channel is muted in the ALSA mixer.
>
> The hardware mute button switches the 'hardware mute state', and also sends a
> keyboard event which I can use to also update the ALSA mixer mute.
>
> This doesn't, however, work the other way around: I haven't found any way yet
> to manipulate the 'hardware mute state' from software.
>
> Looking with hda_analyzer, I notice this card has a 'Vendor Defined Widget'.
> Might this be something that could be used to manipulate the hardware mute
> state? I can use hda-verb but I wouldn't know how to discover which verb to
> use. Anything else to try?
>
> Attached is the codec info.

We generally recommend people to submit the entire alsa-info, rather 
than just the codec info (which, btw, was an empty attachment). In 
particular; if you're having a thinkpad, the mute LED is controlled 
through thinkpad-acpi, and if you're having an HP, it's usually 
connected to the codec in a way hinted by BIOS. Given that you have a 
conexant codec, I'm guessing it's a thinkpad.


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
