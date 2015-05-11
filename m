From: Arijit De <arijit.de@geosemi.com>
Subject: Re: stereo uac device control over mixer
Date: Mon, 11 May 2015 15:28:52 +0000
Message-ID: <1431358131671.36088@geosemi.com>
References: <1430728456157.40941@geosemi.com>,	<55476E36.4090105@ladisch.de>
 <1430800272738.13266@geosemi.com>,<5548C97B.90908@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay05.mycloudmailbox.com (relay05.mycloudmailbox.com
 [199.244.76.204])
 by alsa0.perex.cz (Postfix) with ESMTP id 806AC2615F7
 for <alsa-devel@alsa-project.org>; Mon, 11 May 2015 17:28:57 +0200 (CEST)
In-Reply-To: <5548C97B.90908@ladisch.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Clemens,

I want to do Left/Right Mic mute independently,
but I dont see that kind of control is provided in alsamixer(GUI) for capture devices.

Is Left/Right Mic mute is supported ?

because I can see a api for the same
snd_mixer_selem_set_capture_switch (snd_mixer_elem_t *elem, snd_mixer_selem_channel_id_t channel, int value);

Thanks
Arijit
________________________________________
From: Clemens Ladisch <clemens@ladisch.de>
Sent: Tuesday, May 5, 2015 7:15 PM
To: Arijit De; alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] stereo uac device control over mixer

Arijit De wrote:
>       AudioControl Interface Descriptor:
>         bLength                 9
>         bDescriptorType        36
>         bDescriptorSubtype      6 (FEATURE_UNIT)
>         bUnitID                 2
>         bSourceID               1
>         bControlSize            1
>         bmaControls( 0)      0x03
>           Mute Control
>           Volume Control

These are the controls for the master channel.

>         bmaControls( 1)      0x03
>           Mute Control
>           Volume Control

These are the controls for the mic's left channel.

>         iFeature                0

The controls for the mic's right channel are missing.


There are no descriptors for playback, but this does not matter for the
mixer.


Regards,
Clemens
