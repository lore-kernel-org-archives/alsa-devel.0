From: Fabio Estevam <festevam@gmail.com>
Subject: Re: aplay lists both Playback and Capture devices
Date: Sat, 1 Jun 2013 15:09:38 -0300
Message-ID: <CAOMZO5CfQUnRN8h5gSFV8qAu2YYw4B3hZRBfgkW5DzEmAb3-2A@mail.gmail.com>
References: <CAOMZO5Cq8xSj3fGoZEO+K5xxJNfHotC2PiuX62q+p+yw1-i9Ng@mail.gmail.com>
 <51A736C6.2060500@ladisch.de>
 <CAOMZO5C3eDi_wicdJLab5Dg1yqexkJ6Ffhwwft_2XnO5KHPD+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ve0-f180.google.com (mail-ve0-f180.google.com
 [209.85.128.180])
 by alsa0.perex.cz (Postfix) with ESMTP id B956126165E
 for <alsa-devel@alsa-project.org>; Sat,  1 Jun 2013 20:09:39 +0200 (CEST)
Received: by mail-ve0-f180.google.com with SMTP id pa12so1917945veb.25
 for <alsa-devel@alsa-project.org>; Sat, 01 Jun 2013 11:09:39 -0700 (PDT)
In-Reply-To: <CAOMZO5C3eDi_wicdJLab5Dg1yqexkJ6Ffhwwft_2XnO5KHPD+Q@mail.gmail.com>
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
Cc: =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Jun 1, 2013 at 3:02 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Clemens,
>
> On Thu, May 30, 2013 at 8:23 AM, Clemens Ladisch <clemens@ladisch.de> wrote:
>
>>> I would expect to see only the Playback entry in aplay and only the
>>> Record entry in arecord.
>>
>> Please show the contents of /proc/asound/devices.
>
> Here it goes:
>
> root@freescale /$ cat /proc/asound/devices
>   0: [ 0]   : control
>  16: [ 0- 0]: digital audio playback
>  17: [ 0- 1]: digital audio playback
>  24: [ 0- 0]: digital audio capture
>  25: [ 0- 1]: digital audio capture
>  33:        : timer

Also, in case it helps:

root@freescale /$ cat /proc/asound/pcm
00-00: HiFi Playback sgtl5000-0 :  : playback 1 : capture 1
00-01: HiFi Capture sgtl5000-1 :  : playback 1 : capture 1

root@freescale /$ cat /proc/asound/
card0/        devices       pcm           version
cards         mxssgtl5000/  timers

root@freescale /$ cat /proc/asound/cards
 0 [mxssgtl5000    ]: mxs_sgtl5000 - mxs_sgtl5000
                      mxs_sgtl5000

root@freescale /$ cat /proc/asound/card0/
id      pcm0c/  pcm0p/  pcm1c/  pcm1p/

root@freescale /$ cat /proc/asound/card0/pcm0c/info
card: 0
device: 0
subdevice: 0
stream: CAPTURE
id: HiFi Playback sgtl5000-0
name:
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1

root@freescale /$ cat /proc/asound/card0/pcm0p/info
card: 0
device: 0
subdevice: 0
stream: PLAYBACK
id: HiFi Playback sgtl5000-0
name:
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1
root@freescale /$

Regards,

Fabio Estevam
