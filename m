From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [RFC] Channel mapping API
Date: Tue, 21 Aug 2012 16:00:37 +0200
Message-ID: <50339485.30500@canonical.com>
References: <s5hr4r0359e.wl%tiwai@suse.de> <50337316.4080208@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 35F20265F5A
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2012 16:00:38 +0200 (CEST)
In-Reply-To: <50337316.4080208@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 08/21/2012 01:37 PM, Clemens Ladisch wrote:
> Takashi Iwai wrote:
>> this is a progress report of my longstanding TODO, the channel map API
>> implementation.  I'm going to cover this at Plumbers audio uconf, so
>> we can discuss details there, too.
>
> I won't be there, so ...
>
>> The channel mapping API provides a method for user-space to query, get
>> and set the channel map of a PCM stream.  It's required for assigning
>> channels properly for multi-channel streams.
>
> This doesn't handle devices with simply numbered outputs (such as many
> ICE1712-based devices), or cases where one PCM channel can be routed to
> multiple outputs.  However, those devices typically have their own mixer
> applets, and generic applications aren't interested in configuring them.

Good point! It would be nice if we had better support for devices that 
simply number their outputs, including standard mixer names for those 
devices, that would be good.

One of the long-standing bugs in PulseAudio is better support for such 
hardware, so if we had better possibilities to detect and use these 
outputs and inputs, it could be worth the effort.

As for routing more than one channel in the map from the same PCM, that 
seems a bit more complex. Maybe one could do a bitmap of channels 
instead of just one channel (with say, 32 room channel positions and 32 
just numbered positions, that would be 64 bits). But how common is that 
anyway?

Would it make sense to present a bitmap as the query result anyway? Then 
we could skip the _VAR and _PAIRED types, right?


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
