From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [usb-audio] VIA/Audinst HUD-mx2: One of two PCM
 device is available for playback
Date: Thu, 04 Jul 2013 13:22:41 +0200
Message-ID: <51D55B01.2090705@ladisch.de>
References: <51D3662A.9010708@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id BDCC6264F0B
 for <alsa-devel@alsa-project.org>; Thu,  4 Jul 2013 13:22:48 +0200 (CEST)
In-Reply-To: <51D3662A.9010708@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> This sound card has two PCM devices. If the sound card is realized "card
> 0", there are "hw:0,0" and "hw:0,1". But former seems not to generate
> sound and latter seems to generate.

This device has multiple alternate settings for PCM and AC-3 playback.
The driver creates multiple devices for those because it has no other
mechanism to distinguish them.

The AC-3 setting happens to be listed first in the descriptors.

> 2. are there some ways to use hw:0,1 as a default?

Entires like these in ~/.asoundrc or /etc/asound.conf:

  defaults.pcm.card 0
  defaults.pcm.device 1


I'd guess the driver could be changed to enumerate alternate settings in
two steps, first for PCM formats, then for others.


Regards,
Clemens
