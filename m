From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [usb-audio] VIA/Audinst HUD-mx2: One of two PCM
 device is available for playback
Date: Sat, 06 Jul 2013 16:30:34 +0200
Message-ID: <51D82A0A.1010102@ladisch.de>
References: <51D3662A.9010708@sakamocchi.jp> <51D55B01.2090705@ladisch.de>
 <51D7FDA5.3080006@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id E511E265049
 for <alsa-devel@alsa-project.org>; Sat,  6 Jul 2013 16:29:48 +0200 (CEST)
In-Reply-To: <51D7FDA5.3080006@sakamocchi.jp>
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
>> This device has multiple alternate settings for PCM and AC-3 playback.
>> The driver creates multiple devices for those because it has no other
>> mechanism to distinguish them.
>
> Can we realize whether the PCM device for AC-3 stream (hw:0,0) works
> or not from the output of lsusb?

If the device declares that it supports AC-3, it'd assume that this will
work (if the data actually is AC-3).

>>    defaults.pcm.card 0
>>    defaults.pcm.device 1
>
> The card ID differs depending on the user's system.

defaults.pcm.card "HUDmx2"


Regards,
Clemens
