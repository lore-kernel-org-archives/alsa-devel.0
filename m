From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [alsa-devel] Metallic recording in cs46xx
 on	Thinkpad T22
Date: Wed, 12 Mar 2008 18:17:43 +0100
Message-ID: <47D81037.7030901@keyaccess.nl>
References: <3948f0730803110024k1e7b90ecr31b745e333913c1d@mail.gmail.com>	<47D70143.3010705@keyaccess.nl>	<s5hk5k89f52.wl%tiwai@suse.de>	<47D80754.1020400@keyaccess.nl>
	<s5h8x0nanew.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050609060602090103030406"
Return-path: <alsa-user-bounces@lists.sourceforge.net>
In-Reply-To: <s5h8x0nanew.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=alsa-user>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-user-bounces@lists.sourceforge.net
Errors-To: alsa-user-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-user@lists.sourceforge.net, ALSA devel <alsa-devel@alsa-project.org>, Gadi Oron <gadior@gmail.com>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050609060602090103030406
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

On 12-03-08 17:59, Takashi Iwai wrote:

> At Wed, 12 Mar 2008 17:39:48 +0100,
> Rene Herman wrote:
>> On 12-03-08 15:43, Takashi Iwai wrote:
>>
>>> At Tue, 11 Mar 2008 23:01:39 +0100,
>>> Rene Herman wrote:
>>>> On 11-03-08 08:24, Gadi Oron wrote:
>>>>
>>>>> I am trying to record sound on an old Thinkpad T22 that uses the cs46xx 
>>>>> sound driver.
>>>>>
>>>>> Each time you start to record you have a 10% chance of having the 
>>>>> recording completely distorted and having a metallic sound. When you 
>>>>> look at the waveform it looks as though there are small segments with 
>>>>> sharp transitions between them, a little like if these segments were 
>>>>> moved a little from their correct place.
>>>> No insights, but I confirm the bug with a TerraTec DMX XFire 1024 (CS4624).
>>> Hm, cs46xx driver hasn't been much changes since long time ago (around
>>> year 2005).  The only big change was about some PM fixes, and I don't
>>> think it's relevant...  Could you run als-info.sh to get the status?
>> At:
>>
>> http://pastebin.ca/939784
> 
> The output seems truncated.  Could you give the generated file via
> "alsactl -f somefile store", just to be sure ?

Hmm, alsa-info.sh freshly downloaded from current hg. Anyways:

Rene.

--------------050609060602090103030406
Content-Type: text/plain;
 name="cs4624.state"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cs4624.state"

state.CS46xx {
	control.1 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Master Playback Switch'
		value true
	}
	control.2 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 63'
		iface MIXER
		name 'Master Playback Volume'
		value.0 63
		value.1 63
	}
	control.3 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Headphone Playback Switch'
		value true
	}
	control.4 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 63'
		iface MIXER
		name 'Headphone Playback Volume'
		value.0 0
		value.1 0
	}
	control.5 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Mic Playback Switch'
		value false
	}
	control.6 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 31'
		iface MIXER
		name 'Mic Playback Volume'
		value 0
	}
	control.7 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Mic Boost (+20dB)'
		value false
	}
	control.8 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Line Playback Switch'
		value false
	}
	control.9 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		iface MIXER
		name 'Line Playback Volume'
		value.0 23
		value.1 23
	}
	control.10 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'CD Playback Switch'
		value false
	}
	control.11 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		iface MIXER
		name 'CD Playback Volume'
		value.0 0
		value.1 0
	}
	control.12 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Aux Playback Switch'
		value false
	}
	control.13 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		iface MIXER
		name 'Aux Playback Volume'
		value.0 0
		value.1 0
	}
	control.14 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'PCM Playback Switch'
		value true
	}
	control.15 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		iface MIXER
		name 'PCM Playback Volume'
		value.0 23
		value.1 23
	}
	control.16 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 2
		comment.item.0 Mic
		comment.item.1 CD
		comment.item.2 Video
		comment.item.3 Aux
		comment.item.4 Line
		comment.item.5 Mix
		comment.item.6 'Mix Mono'
		comment.item.7 Phone
		iface MIXER
		name 'Capture Source'
		value.0 Line
		value.1 Line
	}
	control.17 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Capture Switch'
		value true
	}
	control.18 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 15'
		iface MIXER
		name 'Capture Volume'
		value.0 0
		value.1 0
	}
	control.19 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 'pre 3D'
		comment.item.1 'post 3D'
		iface MIXER
		name 'PCM Out Path & Mute'
		value 'pre 3D'
	}
	control.20 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name '3D Control - Switch'
		value false
	}
	control.21 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 15'
		iface MIXER
		name '3D Control - Center'
		value 0
	}
	control.22 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 15'
		iface MIXER
		name '3D Control - Depth'
		value 0
	}
	control.23 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Off-hook Switch'
		value false
	}
	control.24 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Caller ID Switch'
		value false
	}
	control.25 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 32767'
		iface MIXER
		name 'DAC Volume'
		value.0 29493
		value.1 29493
	}
	control.26 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 32767'
		iface MIXER
		name 'ADC Volume'
		value.0 29492
		value.1 29492
	}
	control.27 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'ADC Capture Switch'
		value true
	}
	control.28 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'DAC Capture Switch'
		value false
	}
	control.29 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Output Switch'
		value false
	}
	control.30 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Input Switch'
		value false
	}
	control.31 {
		comment.access 'read write'
		comment.type IEC958
		comment.count 1
		iface PCM
		device 2
		name 'IEC958 Playback Default'
		value '0082000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.32 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface PCM
		device 2
		name 'IEC958 Playback Mask'
		value ffff00ff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
	}
	control.33 {
		comment.access 'read write'
		comment.type IEC958
		comment.count 1
		iface PCM
		device 2
		name 'IEC958 Playback PCM Stream'
		value '0082000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.34 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Duplicate Front'
		value false
	}
}

--------------050609060602090103030406
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--------------050609060602090103030406
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-user mailing list
Alsa-user@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-user

--------------050609060602090103030406--
