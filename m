From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] USB-Audio: Disable "Logitech USB Headset"
 iec958 device
Date: Thu, 08 Mar 2012 06:35:42 +0100
Message-ID: <4F58452E.5070008@canonical.com>
References: <1331115784-3541-1-git-send-email-david.henningsson@canonical.com>
	<CAN8cciYGRzRf9dx=_Tuzx=n+TxZ=-HxB7CE51aYyLZy3W+OTcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by alsa0.perex.cz (Postfix) with ESMTP id CC04C10B9E0
	for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2012 06:35:44 +0100 (CET)
In-Reply-To: <CAN8cciYGRzRf9dx=_Tuzx=n+TxZ=-HxB7CE51aYyLZy3W+OTcA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On 03/08/2012 01:57 AM, Raymond Yau wrote:
> 2012/3/7, David Henningsson<david.henningsson@canonical.com>:
>> Because Logitech USB Headsets do not have any digital devices,
>> prevent them from being opened. This simplifies probing the
>> device in PulseAudio.
>>
>> BugLink: https://bugs.launchpad.net/bugs/940145
>> Signed-off-by: David Henningsson<david.henningsson@canonical.com>
>> ---
>>
>> I did not get any responses to my "digital profile" mail sent to alsa-devel
>> Feb 24th, but it seems the easiest workaround is the below patch for
>> alsa-lib.
>> Alsa-info at:
>> https://bugs.launchpad.net/ubuntu/+source/pulseaudio/+bug/940145/+attachment/2778111/+files/alsa-info.txt.xWdouSRV4Z
>>
>>   src/conf/cards/USB-Audio.conf |    2 ++
>>   1 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/src/conf/cards/USB-Audio.conf b/src/conf/cards/USB-Audio.conf
>> index 0726c34..f488284 100644
>> --- a/src/conf/cards/USB-Audio.conf
>> +++ b/src/conf/cards/USB-Audio.conf
>> @@ -36,6 +36,8 @@ USB-Audio.pcm.surround40_type {
>>   # number for the iec958 device can be changed here.
>>   USB-Audio.pcm.iec958_device {
>>   	# "NoiseBlaster 3000" 42
>> +	# Make sure we can't open this device digitally, because it does not exist
>> +	"Logitech USB Headset" 999
>>   }
>>
>>
>
> your patch does not fix the "IEC958" at device 0 for "Logitech Web Camera"

Sure, we can add "Logitech Web Camera" there as well - I'm more 
interested in knowing from Takashi/Clemens/Jaroslav/etc if it is the 
right way to solve the problem?

> arecord -L
>
> iec958:CARD=U0x46d0x992,DEV=0
>      USB Device 0x46d:0x992, USB Audio
>      IEC958 (S/PDIF) Digital Audio Output

I believe the name to use is what shows up in "/proc/asound/cards" 
(first line after the dash).

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
