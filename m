From: Fabio Estevam <festevam@gmail.com>
Subject: Re: aplay lists both Playback and Capture devices
Date: Sat, 1 Jun 2013 15:02:32 -0300
Message-ID: <CAOMZO5C3eDi_wicdJLab5Dg1yqexkJ6Ffhwwft_2XnO5KHPD+Q@mail.gmail.com>
References: <CAOMZO5Cq8xSj3fGoZEO+K5xxJNfHotC2PiuX62q+p+yw1-i9Ng@mail.gmail.com>
 <51A736C6.2060500@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ve0-f177.google.com (mail-ve0-f177.google.com
 [209.85.128.177])
 by alsa0.perex.cz (Postfix) with ESMTP id B93E5260851
 for <alsa-devel@alsa-project.org>; Sat,  1 Jun 2013 20:02:33 +0200 (CEST)
Received: by mail-ve0-f177.google.com with SMTP id cz10so1928639veb.8
 for <alsa-devel@alsa-project.org>; Sat, 01 Jun 2013 11:02:32 -0700 (PDT)
In-Reply-To: <51A736C6.2060500@ladisch.de>
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

Hi Clemens,

On Thu, May 30, 2013 at 8:23 AM, Clemens Ladisch <clemens@ladisch.de> wrote:

>> I would expect to see only the Playback entry in aplay and only the
>> Record entry in arecord.
>
> Please show the contents of /proc/asound/devices.

Here it goes:

root@freescale /$ cat /proc/asound/devices
  0: [ 0]   : control
 16: [ 0- 0]: digital audio playback
 17: [ 0- 1]: digital audio playback
 24: [ 0- 0]: digital audio capture
 25: [ 0- 1]: digital audio capture
 33:        : timer

Thanks,

Fabio Estevam
