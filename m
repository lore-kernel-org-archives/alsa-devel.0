From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: Record stereo from one input on the soundcard
Date: Mon, 28 Jan 2019 09:44:29 +0100
Message-ID: <cc994e64-2d5e-f785-fd9f-6b2c7db2f85b@ivitera.com>
References: <87muo6uhww.fsf@fliptop.i-did-not-set--mail-host-address--so-tickle-me>
 <87sgxgxy9l.fsf@fliptop.i-did-not-set--mail-host-address--so-tickle-me>
 <e285bd85-2f7b-b7f8-5b1d-83bf50eb42ec@ivitera.com>
 <87h8dux81g.fsf@fliptop.i-did-not-set--mail-host-address--so-tickle-me>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (cable.insite.cz [84.242.75.189])
 by alsa0.perex.cz (Postfix) with ESMTP id D415C267456
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2019 09:44:30 +0100 (CET)
In-Reply-To: <87h8dux81g.fsf@fliptop.i-did-not-set--mail-host-address--so-tickle-me>
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
To: Tomas Nordin <tomasn@posteo.net>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dne 27. 01. 19 v 19:35 Tomas Nordin napsal(a):
> Here is the output of that:
> 
> $ amixer -c 1 contents
> numid=2,iface=PCM,name='Capture Channel Map'
>    ; type=INTEGER,access=r----R--,values=2,min=0,max=36,step=0
>    : values=0,0
>    | container
>      | chmap-fixed=FL,FR
> 
> numid=1,iface=PCM,name='Playback Channel Map'
>    ; type=INTEGER,access=r----R--,values=2,min=0,max=36,step=0
>    : values=0,0
>    | container
>      | chmap-fixed=FL,FR
> 
> And I didn't mention that in my original post but, alsamixer has been
> informing me that "This soundcard does not have any controls." when I
> select the AudioBox via F6.

That usb audio device seems to offer no feature controls:

https://forums.freebsd.org/threads/presonus-audiobox-usb-not-recognized.61395/#post-353537

Alsamixer lists only controls of type MIXER, while amixer lists all - 
incl. those of type PCM added by alsa-lib for your soundcard.

https://android.googlesource.com/kernel/common/+/android-trusty-3.10/Documentation/sound/alsa/Channel-Mapping-API.txt

Regards,

Pavel.
