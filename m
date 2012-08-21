From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [RFC] Channel mapping API
Date: Tue, 21 Aug 2012 13:37:58 +0200
Message-ID: <50337316.4080208@ladisch.de>
References: <s5hr4r0359e.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id B16A3265334
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2012 13:37:58 +0200 (CEST)
In-Reply-To: <s5hr4r0359e.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> this is a progress report of my longstanding TODO, the channel map API
> implementation.  I'm going to cover this at Plumbers audio uconf, so
> we can discuss details there, too.

I won't be there, so ...

> The channel mapping API provides a method for user-space to query, get
> and set the channel map of a PCM stream.  It's required for assigning
> channels properly for multi-channel streams.

This doesn't handle devices with simply numbered outputs (such as many
ICE1712-based devices), or cases where one PCM channel can be routed to
multiple outputs.  However, those devices typically have their own mixer
applets, and generic applications aren't interested in configuring them.

> snd_pcm_get_chmap() returns the currently assigned channel map for the
> given PCM stream.  If the PCM is before prepared, it fills UNKNOWN.

So channel maps are reset when a device is reopened?

> * WRITE OPERATION
>
> This operation is allowed only at PCM PREPARED state.  When called in
> other states, it shall return an error.

This sounds like an hda-intel HDMI restriction; other chips allow
rerouting at any time.  (And the route plugin could allow that, too.)


Regards,
Clemens
