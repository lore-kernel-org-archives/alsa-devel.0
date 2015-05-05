From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: stereo uac device control over mixer
Date: Tue, 05 May 2015 15:45:31 +0200
Message-ID: <5548C97B.90908@ladisch.de>
References: <1430728456157.40941@geosemi.com>,
 <55476E36.4090105@ladisch.de> <1430800272738.13266@geosemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 7DD4D261AF7
 for <alsa-devel@alsa-project.org>; Tue,  5 May 2015 15:45:34 +0200 (CEST)
In-Reply-To: <1430800272738.13266@geosemi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arijit De <arijit.de@geosemi.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

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
