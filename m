From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: amixer shows capability "penum" on every Simple
 mixer control
Date: Thu, 15 Mar 2012 08:23:47 +0800
Message-ID: <CAN8cciaxOewqG1pNBphi9SLAhMQOiKMo0NFxabNuONCuWYc1rw@mail.gmail.com>
References: <2e03711055eba5b923f1983b3e7d6f1a@barbarenland.de>
	<s5h1uown7ze.wl%tiwai@suse.de> <s5h1uow39ul.wl%tiwai@suse.de>
	<CAN8cciaC2vGjs0Ain4Pa1E54YDj31xdhk0JHZwKS1xFPr87WkQ@mail.gmail.com>
	<s5hpqcfz4b3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
	[209.85.212.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 7226924404
	for <alsa-devel@alsa-project.org>; Thu, 15 Mar 2012 01:23:47 +0100 (CET)
Received: by wibhn6 with SMTP id hn6so2785209wib.2
	for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2012 17:23:47 -0700 (PDT)
In-Reply-To: <s5hpqcfz4b3.wl%tiwai@suse.de>
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
Cc: "Christian Esken (KDE)" <esken@kde.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2012/3/14, Takashi Iwai <tiwai@suse.de>:
>>
>> The patch changed some penum to enum
>>
>> (e.g. "Independent HP"  or "Channel Mode" )
>>
>>
>> Simple mixer control 'Independent HP',0
>>   Capabilities: enum
>>   Items: 'OFF' 'ON'
>>   Item0: 'ON'
>>
>
> Yes, and it's the right fix.  The enum is not specific to playback,
> at least, judging from the name string.
>
>

on hda ad198x , "input source" are cenum

Simple mixer control 'Input Source',0
  Capabilities: cenum
  Items: 'Front Mic' 'Rear Mic' 'Line' 'CD' 'Mix'
  Item0: 'Front Mic'
Simple mixer control 'Input Source',1
  Capabilities: cenum
  Items: 'Front Mic' 'Rear Mic' 'Line' 'CD' 'Mix'
  Item0: 'Front Mic'
Simple mixer control 'Input Source',2
  Capabilities: cenum
  Items: 'Front Mic' 'Rear Mic' 'Line' 'CD' 'Mix'
  Item0: 'Line'

but those "Universal Jack" input source are enum

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5548



Simple mixer control 'Line Input Source',0
  Capabilities: enum
  Items: 'Mic2 Jack' 'Mic1 Jack' 'Line In Jack' 'Front Jack' 'Rear
Jack' 'Center/LFE Jack' 'Mute'
  Item0: 'Line In Jack'


Simple mixer control 'Mic Input Source',0
  Capabilities: enum
  Items: 'Mic2 Jack' 'Mic1 Jack' 'Line In Jack' 'Front Jack' 'Rear
Jack' 'Center/LFE Jack' 'Mute'
  Item0: 'Mic1 Jack'
Simple mixer control 'Mic Select',0
  Capabilities: enum
  Items: 'Mic1' 'Mic2'
  Item0: 'Mic1'


Do the user of 3 jack motherboard need to run a script to retask the
Universal Audio Jack for surround51 in Ubuntu 11.10 ?


Simple mixer control 'Front Jack',0
  Capabilities: enum
  Items: 'Input/Disabled' 'Front Output' 'Rear Output' 'Center/LFE
Output' 'Mixer Output'
  Item0: 'Mixer Output'

Simple mixer control 'Center/LFE Jack',0
  Capabilities: enum
  Items: 'Input/Disabled' 'Front Output' 'Rear Output' 'Center/LFE
Output' 'Mixer Output'
  Item0: 'Center/LFE Output'

Simple mixer control 'LineIn Jack',0
  Capabilities: enum
  Items: 'Input/Disabled' 'Front Output' 'Rear Output' 'Center/LFE
Output' 'Mixer Output'
  Item0: 'Input/Disabled'

Simple mixer control 'Mic1 Jack',0
  Capabilities: enum
  Items: 'Input/Disabled' 'Front Output' 'Rear Output' 'Center/LFE
Output' 'Mixer Output'
  Item0: 'Input/Disabled'


Simple mixer control 'Rear Jack',0
  Capabilities: enum
  Items: 'Input/Disabled' 'Front Output' 'Rear Output' 'Center/LFE
Output' 'Mixer Output'
  Item0: 'Rear Output'
