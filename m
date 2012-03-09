From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH v2] USB-Audio: Blacklist iec958 for some
	USB devices
Date: Fri, 9 Mar 2012 19:52:41 +0800
Message-ID: <CAN8cciZrbmH=9a=mMu5Kyv2ZWaasW-syBfpFQtqpkpLKZ6BtDA@mail.gmail.com>
References: <1331289966-3979-1-git-send-email-david.henningsson@canonical.com>
	<s5hlinaxaxe.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
	[209.85.212.173])
	by alsa0.perex.cz (Postfix) with ESMTP id 1EC84104274
	for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2012 12:52:42 +0100 (CET)
Received: by wibhq7 with SMTP id hq7so320564wib.2
	for <alsa-devel@alsa-project.org>; Fri, 09 Mar 2012 03:52:41 -0800 (PST)
In-Reply-To: <s5hlinaxaxe.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2012/3/9, Takashi Iwai <tiwai@suse.de>:
> At Fri,  9 Mar 2012 11:46:06 +0100,
> David Henningsson wrote:
>>
>> Some common USB devices are analog only, so prevent the digital
>> devices from being opened. This simplifies probing the device
>> in PulseAudio.
>>
>> I have a "Logitech USB Headset" myself, the "Logitech Web Camera"
>> was reported by Raymond Yau, and the "Blue Snowball" was reported by
>> Andy Whitcroft.
>>
>> Cc: Andy Whitcroft <andy.whitcroft@canonical.com>
>> Cc: Raymond Yau <superquad.vortex2@gmail.com>
>> BugLink: https://bugs.launchpad.net/bugs/940145
>> Signed-off-by: David Henningsson <david.henningsson@canonical.com>
>
> Thanks, applied now.
>
>
> Takashi
>
>> ---
>>  src/conf/cards/USB-Audio.conf |    5 +++++
>>  1 files changed, 5 insertions(+), 0 deletions(-)
>>
>> diff --git a/src/conf/cards/USB-Audio.conf b/src/conf/cards/USB-Audio.conf
>> index 0726c34..d7c121e 100644
>> --- a/src/conf/cards/USB-Audio.conf
>> +++ b/src/conf/cards/USB-Audio.conf
>> @@ -36,6 +36,11 @@ USB-Audio.pcm.surround40_type {
>>  # number for the iec958 device can be changed here.
>>  USB-Audio.pcm.iec958_device {
>>  	# "NoiseBlaster 3000" 42
>> +
>> +	# The below don't have digital in/out, so prevent them from being
>> opened.
>> +	"Logitech USB Headset" 999
>> +	"Logitech Web Camera" 999
>> +	"Blue Snowball" 999
>>  }
>>

How do the blacklist work ? since there is no "Logitect Web Camera" in
lsusb info

My  QuickCam Communicate Deluxe only support mono, so it is unlikely
for pulseaudio to open for digital capture
