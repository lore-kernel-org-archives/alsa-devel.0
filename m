From: "Nathanael D. Noblet" <nathanael@gnat.ca>
Subject: Re: Internal Mic Boost channel is unused
Date: Mon, 16 Sep 2013 09:14:18 -0600
Message-ID: <5237204A.7040602@gnat.ca>
References: <5231E348.8020204@gnat.ca> <52333782.9070402@gnat.ca>
 <5233AEFC.8000907@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050502020300020107050409"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from titanium.nobletdesign.com (titanium.nobletdesign.com
 [64.34.172.148])
 by alsa0.perex.cz (Postfix) with ESMTP id 31047261A9A
 for <alsa-devel@alsa-project.org>; Mon, 16 Sep 2013 17:14:22 +0200 (CEST)
In-Reply-To: <5233AEFC.8000907@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050502020300020107050409
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 09/13/2013 06:34 PM, David Henningsson wrote:
>>>  >  2) The internal microphone requires that the mic boost channel be
>>> something other than 0 to function properly.
>>>
>>> You have to find out whether node 0x1a or 0x1b can be used as the
>>> headset
>>> jack (headphone with Mic using TRRS connector)
>>
>> So basically I need to plug a microphone into each port and figure out
>> if both of them work as microphone. A couple things.
>>
>> 1) What if both can be a microphone?
>> 2) If only one can be a microphone, I have no idea how to tell you if
>> its 0x1a or 0x1b.. hda-analyzer/alsa low level stuff is completely new
>> to me.
>
> When you plug something in, you can look at the output of "amixer -D
> hw:<cardname> contents" to see what, if anything switched to "values=on"
> instead of "values=off".
>
> We would like you to plug a mic into the mic jack and see in what way
> the output of "amixer -D hw:<cardname> contents" changes.
> Then we would like you to plug a headset (with both headphone and mic,
> like most smartphones have), and again see if there's a difference in
> amixer.
> You can also try this with a headphone only in the headphone jack, if
> you like.
>

So here's what I did. I didn't have a combo headphone/mic thing handy.

1) nothing.out is the netbook with nothing external plugged in.
2) mic.out is when I plugged in a microphone into the mic jack
3) head.out is when there were headphones plugged into the headphone jack
4) both.out is when something was plugged into both (mic into mic and 
headphone into headphones...

A quick diff shows that amixer is seeing differences.
--- nothing.out	2013-09-16 09:11:54.678168182 -0600
+++ mic.out	2013-09-16 09:11:54.675168245 -0600
@@ -6,7 +6,7 @@
    : values=on
  numid=18,iface=CARD,name='Mic Jack'
    ; type=BOOLEAN,access=r-------,values=1
-  : values=off
+  : values=on
  numid=20,iface=CARD,name='Mic Jack',index=1
    ; type=BOOLEAN,access=r-------,values=1
    : values=off


Given this information... what's the next step?


-- 
Nathanael d. Noblet
t 403.875.4613

--------------050502020300020107050409
Content-Type: text/plain; charset=UTF-8;
 name="both.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="both.out"

numid=21,iface=CARD,name='Headphone Jack'
  ; type=BOOLEAN,access=r-------,values=1
  : values=on
numid=19,iface=CARD,name='Internal Mic Phantom Jack'
  ; type=BOOLEAN,access=r-------,values=1
  : values=on
numid=18,iface=CARD,name='Mic Jack'
  ; type=BOOLEAN,access=r-------,values=1
  : values=on
numid=20,iface=CARD,name='Mic Jack',index=1
  ; type=BOOLEAN,access=r-------,values=1
  : values=off
numid=22,iface=CARD,name='Speaker Phantom Jack'
  ; type=BOOLEAN,access=r-------,values=1
  : values=on
numid=17,iface=MIXER,name='Master Playback Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
numid=16,iface=MIXER,name='Master Playback Volume'
  ; type=INTEGER,access=rw---R--,values=1,min=0,max=74,step=0
  : values=74
  | dBscale-min=-74.00dB,step=1.00dB,mute=0
numid=2,iface=MIXER,name='Headphone Playback Switch'
  ; type=BOOLEAN,access=rw------,values=2
  : values=on,on
numid=1,iface=MIXER,name='Headphone Playback Volume'
  ; type=INTEGER,access=rw---R--,values=2,min=0,max=74,step=0
  : values=74,74
  | dBscale-min=-74.00dB,step=1.00dB,mute=0
numid=29,iface=MIXER,name='PCM Playback Volume'
  ; type=INTEGER,access=rw---RW-,values=2,min=0,max=255,step=0
  : values=255,255
  | dBscale-min=-51.00dB,step=0.20dB,mute=0
numid=15,iface=MIXER,name='Mic Boost Volume'
  ; type=INTEGER,access=rw---R--,values=2,min=0,max=4,step=0
  : values=4,4
  | dBscale-min=0.00dB,step=10.00dB,mute=0
numid=10,iface=MIXER,name='Capture Switch'
  ; type=BOOLEAN,access=rw------,values=2
  : values=on,on
numid=12,iface=MIXER,name='Capture Switch',index=1
  ; type=BOOLEAN,access=rw------,values=2
  : values=off,off
numid=14,iface=MIXER,name='Capture Switch',index=2
  ; type=BOOLEAN,access=rw------,values=2
  : values=off,off
numid=9,iface=MIXER,name='Capture Volume'
  ; type=INTEGER,access=rw---R--,values=2,min=0,max=80,step=0
  : values=80,80
  | dBscale-min=-74.00dB,step=1.00dB,mute=0
numid=11,iface=MIXER,name='Capture Volume',index=1
  ; type=INTEGER,access=rw---R--,values=2,min=0,max=80,step=0
  : values=70,70
  | dBscale-min=-74.00dB,step=1.00dB,mute=0
numid=13,iface=MIXER,name='Capture Volume',index=2
  ; type=INTEGER,access=rw---R--,values=2,min=0,max=80,step=0
  : values=71,71
  | dBscale-min=-74.00dB,step=1.00dB,mute=0
numid=5,iface=MIXER,name='Auto-Mute Mode'
  ; type=ENUMERATED,access=rw------,values=1,items=2
  ; Item #0 'Disabled'
  ; Item #1 'Enabled'
  : values=0
numid=24,iface=MIXER,name='Beep Playback Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
numid=23,iface=MIXER,name='Beep Playback Volume'
  ; type=INTEGER,access=rw---R--,values=1,min=0,max=7,step=0
  : values=6
  | dBscale-min=-28.00dB,step=4.00dB,mute=0
numid=6,iface=MIXER,name='Input Source'
  ; type=ENUMERATED,access=rw------,values=1,items=3
  ; Item #0 'Mic'
  ; Item #1 'Internal Mic'
  ; Item #2 'Mic 1'
  : values=0
numid=7,iface=MIXER,name='Input Source',index=1
  ; type=ENUMERATED,access=rw------,values=1,items=3
  ; Item #0 'Mic'
  ; Item #1 'Internal Mic'
  ; Item #2 'Mic 1'
  : values=1
numid=8,iface=MIXER,name='Input Source',index=2
  ; type=ENUMERATED,access=rw------,values=1,items=3
  ; Item #0 'Mic'
  ; Item #1 'Internal Mic'
  ; Item #2 'Mic 1'
  : values=1
numid=4,iface=MIXER,name='Speaker Playback Switch'
  ; type=BOOLEAN,access=rw------,values=2
  : values=off,off
numid=3,iface=MIXER,name='Speaker Playback Volume'
  ; type=INTEGER,access=rw---R--,values=2,min=0,max=74,step=0
  : values=0,0
  | dBscale-min=-74.00dB,step=1.00dB,mute=0
numid=26,iface=PCM,name='Capture Channel Map'
  ; type=INTEGER,access=r----R--,values=2,min=0,max=36,step=0
  : values=3,4
  |     | chmap-fixed=FL,FR

numid=25,iface=PCM,name='Playback Channel Map'
  ; type=INTEGER,access=r----R--,values=2,min=0,max=36,step=0
  : values=0,0
  |     | chmap-fixed=FL,FR

numid=27,iface=PCM,name='Capture Channel Map',device=2
  ; type=INTEGER,access=r----R--,values=2,min=0,max=36,step=0
  : values=0,0
  |     | chmap-fixed=FL,FR

numid=28,iface=PCM,name='Capture Channel Map',index=1,device=2
  ; type=INTEGER,access=r----R--,values=2,min=0,max=36,step=0
  : values=0,0
  |     | chmap-fixed=FL,FR


--------------050502020300020107050409
Content-Type: text/plain; charset=UTF-8;
 name="head.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="head.out"

numid=21,iface=CARD,name='Headphone Jack'
  ; type=BOOLEAN,access=r-------,values=1
  : values=on
numid=19,iface=CARD,name='Internal Mic Phantom Jack'
  ; type=BOOLEAN,access=r-------,values=1
  : values=on
numid=18,iface=CARD,name='Mic Jack'
  ; type=BOOLEAN,access=r-------,values=1
  : values=off
numid=20,iface=CARD,name='Mic Jack',index=1
  ; type=BOOLEAN,access=r-------,values=1
  : values=off
numid=22,iface=CARD,name='Speaker Phantom Jack'
  ; type=BOOLEAN,access=r-------,values=1
  : values=on
numid=17,iface=MIXER,name='Master Playback Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
numid=16,iface=MIXER,name='Master Playback Volume'
  ; type=INTEGER,access=rw---R--,values=1,min=0,max=74,step=0
  : values=74
  | dBscale-min=-74.00dB,step=1.00dB,mute=0
numid=2,iface=MIXER,name='Headphone Playback Switch'
  ; type=BOOLEAN,access=rw------,values=2
  : values=on,on
numid=1,iface=MIXER,name='Headphone Playback Volume'
  ; type=INTEGER,access=rw---R--,values=2,min=0,max=74,step=0
  : values=74,74
  | dBscale-min=-74.00dB,step=1.00dB,mute=0
numid=29,iface=MIXER,name='PCM Playback Volume'
  ; type=INTEGER,access=rw---RW-,values=2,min=0,max=255,step=0
  : values=255,255
  | dBscale-min=-51.00dB,step=0.20dB,mute=0
numid=15,iface=MIXER,name='Mic Boost Volume'
  ; type=INTEGER,access=rw---R--,values=2,min=0,max=4,step=0
  : values=4,4
  | dBscale-min=0.00dB,step=10.00dB,mute=0
numid=10,iface=MIXER,name='Capture Switch'
  ; type=BOOLEAN,access=rw------,values=2
  : values=on,on
numid=12,iface=MIXER,name='Capture Switch',index=1
  ; type=BOOLEAN,access=rw------,values=2
  : values=off,off
numid=14,iface=MIXER,name='Capture Switch',index=2
  ; type=BOOLEAN,access=rw------,values=2
  : values=off,off
numid=9,iface=MIXER,name='Capture Volume'
  ; type=INTEGER,access=rw---R--,values=2,min=0,max=80,step=0
  : values=80,80
  | dBscale-min=-74.00dB,step=1.00dB,mute=0
numid=11,iface=MIXER,name='Capture Volume',index=1
  ; type=INTEGER,access=rw---R--,values=2,min=0,max=80,step=0
  : values=70,70
  | dBscale-min=-74.00dB,step=1.00dB,mute=0
numid=13,iface=MIXER,name='Capture Volume',index=2
  ; type=INTEGER,access=rw---R--,values=2,min=0,max=80,step=0
  : values=71,71
  | dBscale-min=-74.00dB,step=1.00dB,mute=0
numid=5,iface=MIXER,name='Auto-Mute Mode'
  ; type=ENUMERATED,access=rw------,values=1,items=2
  ; Item #0 'Disabled'
  ; Item #1 'Enabled'
  : values=0
numid=24,iface=MIXER,name='Beep Playback Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
numid=23,iface=MIXER,name='Beep Playback Volume'
  ; type=INTEGER,access=rw---R--,values=1,min=0,max=7,step=0
  : values=6
  | dBscale-min=-28.00dB,step=4.00dB,mute=0
numid=6,iface=MIXER,name='Input Source'
  ; type=ENUMERATED,access=rw------,values=1,items=3
  ; Item #0 'Mic'
  ; Item #1 'Internal Mic'
  ; Item #2 'Mic 1'
  : values=0
numid=7,iface=MIXER,name='Input Source',index=1
  ; type=ENUMERATED,access=rw------,values=1,items=3
  ; Item #0 'Mic'
  ; Item #1 'Internal Mic'
  ; Item #2 'Mic 1'
  : values=1
numid=8,iface=MIXER,name='Input Source',index=2
  ; type=ENUMERATED,access=rw------,values=1,items=3
  ; Item #0 'Mic'
  ; Item #1 'Internal Mic'
  ; Item #2 'Mic 1'
  : values=1
numid=4,iface=MIXER,name='Speaker Playback Switch'
  ; type=BOOLEAN,access=rw------,values=2
  : values=off,off
numid=3,iface=MIXER,name='Speaker Playback Volume'
  ; type=INTEGER,access=rw---R--,values=2,min=0,max=74,step=0
  : values=0,0
  | dBscale-min=-74.00dB,step=1.00dB,mute=0
numid=26,iface=PCM,name='Capture Channel Map'
  ; type=INTEGER,access=r----R--,values=2,min=0,max=36,step=0
  : values=3,4
  |     | chmap-fixed=FL,FR

numid=25,iface=PCM,name='Playback Channel Map'
  ; type=INTEGER,access=r----R--,values=2,min=0,max=36,step=0
  : values=0,0
  |     | chmap-fixed=FL,FR

numid=27,iface=PCM,name='Capture Channel Map',device=2
  ; type=INTEGER,access=r----R--,values=2,min=0,max=36,step=0
  : values=0,0
  |     | chmap-fixed=FL,FR

numid=28,iface=PCM,name='Capture Channel Map',index=1,device=2
  ; type=INTEGER,access=r----R--,values=2,min=0,max=36,step=0
  : values=0,0
  |     | chmap-fixed=FL,FR


--------------050502020300020107050409
Content-Type: text/plain; charset=UTF-8;
 name="mic.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="mic.out"

numid=21,iface=CARD,name='Headphone Jack'
  ; type=BOOLEAN,access=r-------,values=1
  : values=off
numid=19,iface=CARD,name='Internal Mic Phantom Jack'
  ; type=BOOLEAN,access=r-------,values=1
  : values=on
numid=18,iface=CARD,name='Mic Jack'
  ; type=BOOLEAN,access=r-------,values=1
  : values=on
numid=20,iface=CARD,name='Mic Jack',index=1
  ; type=BOOLEAN,access=r-------,values=1
  : values=off
numid=22,iface=CARD,name='Speaker Phantom Jack'
  ; type=BOOLEAN,access=r-------,values=1
  : values=on
numid=17,iface=MIXER,name='Master Playback Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
numid=16,iface=MIXER,name='Master Playback Volume'
  ; type=INTEGER,access=rw---R--,values=1,min=0,max=74,step=0
  : values=74
  | dBscale-min=-74.00dB,step=1.00dB,mute=0
numid=2,iface=MIXER,name='Headphone Playback Switch'
  ; type=BOOLEAN,access=rw------,values=2
  : values=on,on
numid=1,iface=MIXER,name='Headphone Playback Volume'
  ; type=INTEGER,access=rw---R--,values=2,min=0,max=74,step=0
  : values=74,74
  | dBscale-min=-74.00dB,step=1.00dB,mute=0
numid=29,iface=MIXER,name='PCM Playback Volume'
  ; type=INTEGER,access=rw---RW-,values=2,min=0,max=255,step=0
  : values=255,255
  | dBscale-min=-51.00dB,step=0.20dB,mute=0
numid=15,iface=MIXER,name='Mic Boost Volume'
  ; type=INTEGER,access=rw---R--,values=2,min=0,max=4,step=0
  : values=4,4
  | dBscale-min=0.00dB,step=10.00dB,mute=0
numid=10,iface=MIXER,name='Capture Switch'
  ; type=BOOLEAN,access=rw------,values=2
  : values=on,on
numid=12,iface=MIXER,name='Capture Switch',index=1
  ; type=BOOLEAN,access=rw------,values=2
  : values=off,off
numid=14,iface=MIXER,name='Capture Switch',index=2
  ; type=BOOLEAN,access=rw------,values=2
  : values=off,off
numid=9,iface=MIXER,name='Capture Volume'
  ; type=INTEGER,access=rw---R--,values=2,min=0,max=80,step=0
  : values=80,80
  | dBscale-min=-74.00dB,step=1.00dB,mute=0
numid=11,iface=MIXER,name='Capture Volume',index=1
  ; type=INTEGER,access=rw---R--,values=2,min=0,max=80,step=0
  : values=70,70
  | dBscale-min=-74.00dB,step=1.00dB,mute=0
numid=13,iface=MIXER,name='Capture Volume',index=2
  ; type=INTEGER,access=rw---R--,values=2,min=0,max=80,step=0
  : values=71,71
  | dBscale-min=-74.00dB,step=1.00dB,mute=0
numid=5,iface=MIXER,name='Auto-Mute Mode'
  ; type=ENUMERATED,access=rw------,values=1,items=2
  ; Item #0 'Disabled'
  ; Item #1 'Enabled'
  : values=0
numid=24,iface=MIXER,name='Beep Playback Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
numid=23,iface=MIXER,name='Beep Playback Volume'
  ; type=INTEGER,access=rw---R--,values=1,min=0,max=7,step=0
  : values=6
  | dBscale-min=-28.00dB,step=4.00dB,mute=0
numid=6,iface=MIXER,name='Input Source'
  ; type=ENUMERATED,access=rw------,values=1,items=3
  ; Item #0 'Mic'
  ; Item #1 'Internal Mic'
  ; Item #2 'Mic 1'
  : values=0
numid=7,iface=MIXER,name='Input Source',index=1
  ; type=ENUMERATED,access=rw------,values=1,items=3
  ; Item #0 'Mic'
  ; Item #1 'Internal Mic'
  ; Item #2 'Mic 1'
  : values=1
numid=8,iface=MIXER,name='Input Source',index=2
  ; type=ENUMERATED,access=rw------,values=1,items=3
  ; Item #0 'Mic'
  ; Item #1 'Internal Mic'
  ; Item #2 'Mic 1'
  : values=1
numid=4,iface=MIXER,name='Speaker Playback Switch'
  ; type=BOOLEAN,access=rw------,values=2
  : values=on,on
numid=3,iface=MIXER,name='Speaker Playback Volume'
  ; type=INTEGER,access=rw---R--,values=2,min=0,max=74,step=0
  : values=74,74
  | dBscale-min=-74.00dB,step=1.00dB,mute=0
numid=26,iface=PCM,name='Capture Channel Map'
  ; type=INTEGER,access=r----R--,values=2,min=0,max=36,step=0
  : values=3,4
  |     | chmap-fixed=FL,FR

numid=25,iface=PCM,name='Playback Channel Map'
  ; type=INTEGER,access=r----R--,values=2,min=0,max=36,step=0
  : values=0,0
  |     | chmap-fixed=FL,FR

numid=27,iface=PCM,name='Capture Channel Map',device=2
  ; type=INTEGER,access=r----R--,values=2,min=0,max=36,step=0
  : values=0,0
  |     | chmap-fixed=FL,FR

numid=28,iface=PCM,name='Capture Channel Map',index=1,device=2
  ; type=INTEGER,access=r----R--,values=2,min=0,max=36,step=0
  : values=0,0
  |     | chmap-fixed=FL,FR


--------------050502020300020107050409
Content-Type: text/plain; charset=UTF-8;
 name="nothing.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="nothing.out"

numid=21,iface=CARD,name='Headphone Jack'
  ; type=BOOLEAN,access=r-------,values=1
  : values=off
numid=19,iface=CARD,name='Internal Mic Phantom Jack'
  ; type=BOOLEAN,access=r-------,values=1
  : values=on
numid=18,iface=CARD,name='Mic Jack'
  ; type=BOOLEAN,access=r-------,values=1
  : values=off
numid=20,iface=CARD,name='Mic Jack',index=1
  ; type=BOOLEAN,access=r-------,values=1
  : values=off
numid=22,iface=CARD,name='Speaker Phantom Jack'
  ; type=BOOLEAN,access=r-------,values=1
  : values=on
numid=17,iface=MIXER,name='Master Playback Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
numid=16,iface=MIXER,name='Master Playback Volume'
  ; type=INTEGER,access=rw---R--,values=1,min=0,max=74,step=0
  : values=74
  | dBscale-min=-74.00dB,step=1.00dB,mute=0
numid=2,iface=MIXER,name='Headphone Playback Switch'
  ; type=BOOLEAN,access=rw------,values=2
  : values=on,on
numid=1,iface=MIXER,name='Headphone Playback Volume'
  ; type=INTEGER,access=rw---R--,values=2,min=0,max=74,step=0
  : values=74,74
  | dBscale-min=-74.00dB,step=1.00dB,mute=0
numid=29,iface=MIXER,name='PCM Playback Volume'
  ; type=INTEGER,access=rw---RW-,values=2,min=0,max=255,step=0
  : values=255,255
  | dBscale-min=-51.00dB,step=0.20dB,mute=0
numid=15,iface=MIXER,name='Mic Boost Volume'
  ; type=INTEGER,access=rw---R--,values=2,min=0,max=4,step=0
  : values=4,4
  | dBscale-min=0.00dB,step=10.00dB,mute=0
numid=10,iface=MIXER,name='Capture Switch'
  ; type=BOOLEAN,access=rw------,values=2
  : values=on,on
numid=12,iface=MIXER,name='Capture Switch',index=1
  ; type=BOOLEAN,access=rw------,values=2
  : values=off,off
numid=14,iface=MIXER,name='Capture Switch',index=2
  ; type=BOOLEAN,access=rw------,values=2
  : values=off,off
numid=9,iface=MIXER,name='Capture Volume'
  ; type=INTEGER,access=rw---R--,values=2,min=0,max=80,step=0
  : values=80,80
  | dBscale-min=-74.00dB,step=1.00dB,mute=0
numid=11,iface=MIXER,name='Capture Volume',index=1
  ; type=INTEGER,access=rw---R--,values=2,min=0,max=80,step=0
  : values=70,70
  | dBscale-min=-74.00dB,step=1.00dB,mute=0
numid=13,iface=MIXER,name='Capture Volume',index=2
  ; type=INTEGER,access=rw---R--,values=2,min=0,max=80,step=0
  : values=71,71
  | dBscale-min=-74.00dB,step=1.00dB,mute=0
numid=5,iface=MIXER,name='Auto-Mute Mode'
  ; type=ENUMERATED,access=rw------,values=1,items=2
  ; Item #0 'Disabled'
  ; Item #1 'Enabled'
  : values=0
numid=24,iface=MIXER,name='Beep Playback Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
numid=23,iface=MIXER,name='Beep Playback Volume'
  ; type=INTEGER,access=rw---R--,values=1,min=0,max=7,step=0
  : values=6
  | dBscale-min=-28.00dB,step=4.00dB,mute=0
numid=6,iface=MIXER,name='Input Source'
  ; type=ENUMERATED,access=rw------,values=1,items=3
  ; Item #0 'Mic'
  ; Item #1 'Internal Mic'
  ; Item #2 'Mic 1'
  : values=0
numid=7,iface=MIXER,name='Input Source',index=1
  ; type=ENUMERATED,access=rw------,values=1,items=3
  ; Item #0 'Mic'
  ; Item #1 'Internal Mic'
  ; Item #2 'Mic 1'
  : values=1
numid=8,iface=MIXER,name='Input Source',index=2
  ; type=ENUMERATED,access=rw------,values=1,items=3
  ; Item #0 'Mic'
  ; Item #1 'Internal Mic'
  ; Item #2 'Mic 1'
  : values=1
numid=4,iface=MIXER,name='Speaker Playback Switch'
  ; type=BOOLEAN,access=rw------,values=2
  : values=on,on
numid=3,iface=MIXER,name='Speaker Playback Volume'
  ; type=INTEGER,access=rw---R--,values=2,min=0,max=74,step=0
  : values=74,74
  | dBscale-min=-74.00dB,step=1.00dB,mute=0
numid=26,iface=PCM,name='Capture Channel Map'
  ; type=INTEGER,access=r----R--,values=2,min=0,max=36,step=0
  : values=3,4
  |     | chmap-fixed=FL,FR

numid=25,iface=PCM,name='Playback Channel Map'
  ; type=INTEGER,access=r----R--,values=2,min=0,max=36,step=0
  : values=0,0
  |     | chmap-fixed=FL,FR

numid=27,iface=PCM,name='Capture Channel Map',device=2
  ; type=INTEGER,access=r----R--,values=2,min=0,max=36,step=0
  : values=0,0
  |     | chmap-fixed=FL,FR

numid=28,iface=PCM,name='Capture Channel Map',index=1,device=2
  ; type=INTEGER,access=r----R--,values=2,min=0,max=36,step=0
  : values=0,0
  |     | chmap-fixed=FL,FR


--------------050502020300020107050409
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------050502020300020107050409--
