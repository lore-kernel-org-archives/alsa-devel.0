From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd_usb_audio - siberia elite prism soundcard
	issues
Date: Sun, 08 Mar 2015 20:02:08 +0100
Message-ID: <54FC9CB0.2030003@ladisch.de>
References: <CAHti5NHPMjxAtg_XLHD1kL4rUCAPaNGa_2ZAZwvv_Kc4u43uAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 307C82604FC
 for <alsa-devel@alsa-project.org>; Sun,  8 Mar 2015 20:02:42 +0100 (CET)
In-Reply-To: <CAHti5NHPMjxAtg_XLHD1kL4rUCAPaNGa_2ZAZwvv_Kc4u43uAw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel <dferradal@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Daniel wrote:
> numid=1,iface=PCM,name='Capture Channel Map'
>   ; type=INTEGER,access=r----R--,values=2,min=0,max=36,step=0
>   : values=0,0
>   |     | chmap-fixed=FL,FR
> numid=2,iface=PCM,name='Playback Channel Map'
>   ; type=INTEGER,access=r----R--,values=2,min=0,max=36,step=0
>   : values=0,0
>   |     | chmap-fixed=FL,FR

This device reports that it supports two channels.
What makes you think that you can play eight channels?

> amixer: Control hw:2 element read error: Invalid argument
> usb 1-1.3: 10:0: cannot get min/max values for control 3 (id 10)
> usb 1-1.3: 2:1: cannot get freq at ep 0x1

These are bugs in the device firmware.  However, the driver could
handle them better.


Regards,
Clemens
