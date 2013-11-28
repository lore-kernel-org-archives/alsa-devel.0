From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Intermittent cut out on the video
Date: Thu, 28 Nov 2013 09:29:45 +0100
Message-ID: <5296FEF9.2020604@ladisch.de>
References: <DUB122-W30D40465C0A432A2147375AAEC0@phx.gbl>
 <DUB122-W83C8D065397526DB034BAAAEE0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id F2BD32651DB
 for <alsa-devel@alsa-project.org>; Thu, 28 Nov 2013 09:29:47 +0100 (CET)
In-Reply-To: <DUB122-W83C8D065397526DB034BAAAEE0@phx.gbl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dolevo Jay <cmst@live.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dolevo Jay wrote:
> I have two sound cards on my system and I use the [multi plugin] to
> have audio from two jacks simultaneously.
>
> The audio coming from the jack on the pc is cutting out intermittently.
> It just cuts out for a fraction of a second and continues as normal
> and after some time it happens again.

The two cards use different sample clocks, so it is not possible to feed
them reliably from the same stream.

You would need software that measures that actual sample rate of both
devices and resamples its output appropriately.  Try using PulseAudio.


Regards,
Clemens
