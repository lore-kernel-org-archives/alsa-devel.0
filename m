From: Petr Gladkikh <batyi@mail.ru>
Subject: Re2: Wrong creation of emulated volume control.
Date: Wed, 16 Feb 2005 11:18:28 +0600
Message-ID: <4212D7A4.5080705@mail.ru>
References: <Pine.HPX.4.33n.0502141356140.10867-100000@studcom.urz.uni-halle.de>
Reply-To: batyi@mail.ru
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.HPX.4.33n.0502141356140.10867-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Hello.

Clemens Ladisch wrote:
>>> I have sound card with PCM having only mute switch (no volume
>>> control). I have installed alsa-lib-1.8.0 (release). My control list
>>> now have following PCM control (following is part of amixer output):
>>>
>>>  >>>
>>> Simple mixer control 'PCM',0
>>>    Capabilities: pvolume pswitch pswitch-joined
>>>    Playback channels: Front Left - Front Right - Front Center - Rear
>>> Left - Rear Right - Woofer - ? - ? - ? - ? - ? - ? - ? - ? - ? - ? - ?
>>> - ? - ? - ? - ? - ? - ? - ? - ? - ? - ? - ? - ? - ? - ? - ?
>>>    Limits: Playback 0 - 0
>>>    Front Left: Playback 0 [0%] [on]
>>>    Front Right: Playback 0 [0%] [on]
>>>    Front Center: Playback 0 [0%] [on]
>>>    Rear Left: Playback 0 [0%] [on]
>>>    Rear Right: Playback 0 [0%] [on]
>>>    Woofer: Playback 0 [0%] [on]
>>>    ?: Playback 0 [0%] [on]
>>>    ?: Playback 0 [0%] [on]
>>>    ?: Playback 0 [0%] [on]
>>>    ...
> 
> 
> How do these controls look in /etc/asound.state after running "alsactl
> store"?

It's my fault but the subject is not correct, I did not mentioned that 
I had not configured any plugins yet (including svol). But the problem 
exists anyway.

My environment (if it helps)
Linux 2.6.9 (Gentoo)
alsa-lib 1.0.8, alsa-utils 1.0.8 (release)
Hardware: AC97 in ICH5 chipset, 6-channel C-Media 9739A (everything is 
on-board)
Driver: intel-8x0

	Reproduction:

=[1]= Boot, everything is OK. Both 'alsactl store' and amixer produce 
sensible results (alsamixer screen looks messy anyway). The part of 
'alsactl store' result in /etc/asound.state related to PCM is as 
follows (no other PCM controls present):

state.ICH5 {

	. . . . .

	control.26 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'PCM Playback Switch'
		value false
	}

	. . . . .
}

=[2]= aplay
^C

And now magig happens :) amixer produce the output which has been in 
my previous post, and 'alsactl store' fails with error message:

alsactl: control.c:2234: snd_ctl_elem_value_get_integer: Assertion 
`idx < sizeof(obj->value.integer.value) / 
sizeof(obj->value.integer.value[0])' failed.
Aborted.

--
Petr


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
