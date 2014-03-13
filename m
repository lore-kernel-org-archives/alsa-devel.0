From: sam chan <schan@cs.ucr.edu>
Subject: Re: Low volume ad1983
Date: Thu, 13 Mar 2014 10:48:08 -0700 (PDT)
Message-ID: <alpine.LFD.2.11.1403131025110.14918@theshire>
References: <CAN8ccibdwRr5q1yXsrt+4pBJkfd+=3p0Z6vmLGC97sUgBkmung@mail.gmail.com>
	<s5hiorixlk6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-bounces@lists.sourceforge.net>
In-Reply-To: <s5hiorixlk6.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=alsa-user>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
Errors-To: alsa-user-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: Raymond Yau <superquad.vortex2@gmail.com>, alsa-user@lists.sourceforge.net, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



On Thu, 13 Mar 2014, Takashi Iwai wrote:

> At Thu, 13 Mar 2014 21:20:46 +0800,
> Raymond Yau wrote:
>>
>>>> sam chan wrote:
>>>> i'm having a problem with sound volume being too low.
>>>> i **think** it's due to the levels of my channel map being
>>>> too low.....
>>
>>> The channel map specifies which channel goes to which
>>> physical output.
>>


ok.  i thought the values were a range, because the
controls makes it look like that.  maybe these ought
to be changed.




>>>> my alsa-info...
>>>> http://www.alsa-project.org/db/?f=3ba6278df3c6c4abe5196ad37f8015de7223ca8e
>>
>>>> Simple mixer control 'Master',0
>>>>   Mono: Playback 37 [59%] [-39.00dB] [on]
>>
>>> That is pretty low.
>>


i just use the Master switch as my main volume control.
i have PCM and other switches at 0 dB.

just to clarify the problem, it's not that i can't get
it loud enough.  it's that it's relatively quite low
compared to Windows.  in Windows, i barely have to up
the volume to get the same audible level.  the speakers'
physical nob is the same for both instances.





>>>> Simple mixer control 'Loopback Mixing',0
>>>>   Item0: 'Enabled'
>>
>>> Why is this enabled?
>>
>> seem driver bug
>
> Not really.
>

apparently, this is the only way i can get the Mic to
work for capture/recording.  but this a seperate issue.


thanks,
sam





>> 1) Should the volume control and playback switch of line out be named
>> as Front instead of PCM ?
>
> Depends.  For multi-channel setup, we take "Front", but in other
> cases, it may become "PCM".  It's suboptimal, indeed, and we need a
> better naming rule for the shared volume control.
>
>>
>>
>> Node 0x05 [Pin Complex] wcaps 0x400185: Stereo Amp-Out
>>   Control: name="PCM Playback Volume", index=0, device=0
>>     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
>>   Control: name="PCM Playback Switch", index=0, device=0
>>     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
>>   Control: name="Line Out Jack", index=0, device=0
>>   Amp-Out caps: ofs=0x3d, nsteps=0x3f, stepsize=0x05, mute=1
>>   Amp-Out vals:  [0x23 0x23]
>>   Pincap 0x00000017: OUT Detect Trigger ImpSense
>>   Pin Default 0x01014010: [Jack] Line Out at Ext Rear
>>     Conn = 1/8, Color = Green
>>     DefAssociation = 0x1, Sequence = 0x0
>>
>> 2) dB max of virtual master playback volume is different from the
>> slave when slave dbmax of slaves  > 0
>
> It's the designed behavior.  The Master volume is an offset applied to
> the slave value, thus it's always up to 0dB.  The lowest value is
> somewhat bogus, but it's anyway cut off under 0.
>
>
>
> Takashi
>
>>
>>
>> 	control.1 {
>> 		iface MIXER
>> 		name 'PCM Playback Volume'
>> 		value.0 61
>> 		value.1 61
>> 		comment {
>> 			access 'read write'
>> 			type INTEGER
>> 			count 2
>> 			range '0 - 63'
>> 			dbmin -9150
>> 			dbmax 300
>> 			dbvalue.0 0
>> 			dbvalue.1 0
>> 		}
>> 	}
>> 	control.3 {
>> 		iface MIXER
>> 		name 'Headphone Playback Volume'
>> 		value.0 61
>> 		value.1 61
>> 		comment {
>> 			access 'read write'
>> 			type INTEGER
>> 			count 2
>> 			range '0 - 63'
>> 			dbmin -9150
>> 			dbmax 300
>> 			dbvalue.0 0
>> 			dbvalue.1 0
>> 		}
>> 	}
>> 	control.5 {
>> 		iface MIXER
>> 		name 'Speaker Playback Volume'
>> 		value 61
>> 		comment {
>> 			access 'read write'
>> 			type INTEGER
>> 			count 1
>> 			range '0 - 63'
>> 			dbmin -9150
>> 			dbmax 300
>> 			dbvalue.0 0
>> 		}
>> 	}
>> 	control.17 {
>> 		iface MIXER
>> 		name 'Master Playback Volume'
>> 		value 37
>> 		comment {
>> 			access 'read write'
>> 			type INTEGER
>> 			count 1
>> 			range '0 - 63'
>> 			dbmin -9450
>> 			dbmax 0
>> 			dbvalue.0 -3900
>> 		}
>> 	}
>

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
