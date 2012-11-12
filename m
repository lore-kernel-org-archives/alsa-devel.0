From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd_pcm_wait function
Date: Mon, 12 Nov 2012 08:36:41 +0100
Message-ID: <50A0A709.1050307@ladisch.de>
References: <50A0A3FE.4090901@tele2.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 892D426163E
 for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2012 08:36:43 +0100 (CET)
In-Reply-To: <50A0A3FE.4090901@tele2.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Enno Fennema <ennofennema@tele2.nl>
Cc: alsa-devel@alsa-project.org, daniellsanz2@gmail.com
List-Id: alsa-devel@alsa-project.org

Enno Fennema wrote:
> I want to close the pcm AFTER the sound finished.

Then close it after snd_pcm_drain() has returned.

> The docs say calling drain() puts the pcm in the DRAINING state.

It also waits until the device has drained (unless the device is in
non-blocking mode).

> When I obtain the state immediately after drain() it is already SETUP.
> I hoped a state change from DRAINING to SETUP  would be the right time
> to close the pcm but there appears to be no such state change.

That change happens immediately before snd_pcm_drain() returns.


Regards,
Clemens
