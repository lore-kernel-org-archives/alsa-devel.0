From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] USB-Audio: Disable "Logitech USB Headset"
 iec958 device
Date: Thu, 8 Mar 2012 08:57:09 +0800
Message-ID: <CAN8cciYGRzRf9dx=_Tuzx=n+TxZ=-HxB7CE51aYyLZy3W+OTcA@mail.gmail.com>
References: <1331115784-3541-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
	[209.85.212.179])
	by alsa0.perex.cz (Postfix) with ESMTP id DC74B2437A
	for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2012 01:57:09 +0100 (CET)
Received: by wiax18 with SMTP id x18so3494751wia.38
	for <alsa-devel@alsa-project.org>; Wed, 07 Mar 2012 16:57:09 -0800 (PST)
In-Reply-To: <1331115784-3541-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: clemens@ladish.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2012/3/7, David Henningsson <david.henningsson@canonical.com>:
> Because Logitech USB Headsets do not have any digital devices,
> prevent them from being opened. This simplifies probing the
> device in PulseAudio.
>
> BugLink: https://bugs.launchpad.net/bugs/940145
> Signed-off-by: David Henningsson <david.henningsson@canonical.com>
> ---
>
> I did not get any responses to my "digital profile" mail sent to alsa-devel
> Feb 24th, but it seems the easiest workaround is the below patch for
> alsa-lib.
> Alsa-info at:
> https://bugs.launchpad.net/ubuntu/+source/pulseaudio/+bug/940145/+attachment/2778111/+files/alsa-info.txt.xWdouSRV4Z
>
>  src/conf/cards/USB-Audio.conf |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/src/conf/cards/USB-Audio.conf b/src/conf/cards/USB-Audio.conf
> index 0726c34..f488284 100644
> --- a/src/conf/cards/USB-Audio.conf
> +++ b/src/conf/cards/USB-Audio.conf
> @@ -36,6 +36,8 @@ USB-Audio.pcm.surround40_type {
>  # number for the iec958 device can be changed here.
>  USB-Audio.pcm.iec958_device {
>  	# "NoiseBlaster 3000" 42
> +	# Make sure we can't open this device digitally, because it does not exist
> +	"Logitech USB Headset" 999
>  }
>
>

your patch does not fix the "IEC958" at device 0 for "Logitech Web Camera"

arecord -L

iec958:CARD=U0x46d0x992,DEV=0
    USB Device 0x46d:0x992, USB Audio
    IEC958 (S/PDIF) Digital Audio Output
