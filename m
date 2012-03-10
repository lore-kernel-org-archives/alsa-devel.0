From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] USB-Audio: Fixup card name for Logitech
	web camera
Date: Sat, 10 Mar 2012 08:47:14 +0800
Message-ID: <CAN8ccibdhRiAZ5Lzb06Nv_RYvO-hn3zcmm6xL2KvWmJAVUzkQw@mail.gmail.com>
References: <1331298364-12791-1-git-send-email-david.henningsson@canonical.com>
	<s5hboo5yl2m.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
	[209.85.212.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 6A2EB2447C
	for <alsa-devel@alsa-project.org>; Sat, 10 Mar 2012 01:47:16 +0100 (CET)
Received: by wibhn6 with SMTP id hn6so941333wib.2
	for <alsa-devel@alsa-project.org>; Fri, 09 Mar 2012 16:47:14 -0800 (PST)
In-Reply-To: <s5hboo5yl2m.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

2012/3/9, Takashi Iwai <tiwai@suse.de>:
> At Fri,  9 Mar 2012 14:06:04 +0100,
> David Henningsson wrote:
>>
>> Reported-by: Raymond Yau <superquad.vortex2@gmail.com>
>> Signed-off-by: David Henningsson <david.henningsson@canonical.com>
>
> OK, applied.
>
>
> Takashi
>
>> ---
>>  src/conf/cards/USB-Audio.conf |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/src/conf/cards/USB-Audio.conf b/src/conf/cards/USB-Audio.conf
>> index d7c121e..966172f 100644
>> --- a/src/conf/cards/USB-Audio.conf
>> +++ b/src/conf/cards/USB-Audio.conf
>> @@ -39,7 +39,7 @@ USB-Audio.pcm.iec958_device {
>>
>>  	# The below don't have digital in/out, so prevent them from being
>> opened.
>>  	"Logitech USB Headset" 999
>> -	"Logitech Web Camera" 999
>> +	"USB Device 0x46d:0x992" 999
>>  	"Blue Snowball" 999
>>  }
>>
>> --
>> 1.7.9
>>
>

I have already replied that the black list does not work since arecord
can still open iec958
and David expect the patch will make pulseaudio cannot open ice958


arecord -L

iec958:CARD=U0x46d0x992,DEV=0
    USB Device 0x46d:0x992, USB Audio
    IEC958 (S/PDIF) Digital Audio Output



$ arecord -D iec958:2 -f dat /dev/null
Recording WAVE '/dev/null' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
arecord: set_params:1101: Channels count non available

$ arecord -D iec958:CARD=U0x46d0x992 -f dat /dev/null
Recording WAVE '/dev/null' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
arecord: set_params:1101: Channels count non available
