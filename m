From: Petr Gladkikh <batyi@mail.ru>
Subject: Wrong creation of emulated volume control.
Date: Mon, 14 Feb 2005 15:55:29 +0600
Message-ID: <42107591.7090806@mail.ru>
Reply-To: batyi@mail.ru
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251; format=flowed
Content-Transfer-Encoding: 7bit
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello.

I did not managed to find anything appropriate in the list and seems 
this problem hasn't been reported yet.

I have sound card with PCM having only mute switch (no volume 
control). I have installed alsa-lib-1.8.0 (release). My control list 
now have following PCM control (following is part of amixer output):

 >>>
Simple mixer control 'PCM',0
   Capabilities: pvolume pswitch pswitch-joined
   Playback channels: Front Left - Front Right - Front Center - Rear 
Left - Rear Right - Woofer - ? - ? - ? - ? - ? - ? - ? - ? - ? - ? - ? 
- ? - ? - ? - ? - ? - ? - ? - ? - ? - ? - ? - ? - ? - ? - ?
   Limits: Playback 0 - 0
   Front Left: Playback 0 [0%] [on]
   Front Right: Playback 0 [0%] [on]
   Front Center: Playback 0 [0%] [on]
   Rear Left: Playback 0 [0%] [on]
   Rear Right: Playback 0 [0%] [on]
   Woofer: Playback 0 [0%] [on]
   ?: Playback 0 [0%] [on]
   ?: Playback 0 [0%] [on]
   ?: Playback 0 [0%] [on]
   ?: Playback 0 [0%] [on]
   ?: Playback 0 [0%] [on]
   ?: Playback 0 [0%] [on]
   ?: Playback 0 [0%] [on]
   ?: Playback 0 [0%] [on]
   ?: Playback 0 [0%] [on]
   ?: Playback 0 [0%] [on]
   ?: Playback 0 [0%] [on]
   ?: Playback 0 [0%] [on]
   ?: Playback 0 [0%] [on]
   ?: Playback 0 [0%] [on]
   ?: Playback 0 [0%] [on]
   ?: Playback 0 [0%] [on]
   ?: Playback 0 [0%] [on]
   ?: Playback 0 [0%] [on]
   ?: Playback 0 [0%] [on]
   ?: Playback 0 [0%] [on]
   ?: Playback 0 [0%] [on]
   ?: Playback 0 [0%] [on]
   ?: Playback 0 [0%] [on]
   ?: Playback 0 [0%] [on]
   ?: Playback 0 [0%] [on]
   ?: Playback 0 [0%] [on]
<<<

This incorrect registration of new control seems also the reason of 
crashes and messed display in alsamixer. I had not time to track the 
reason of this but maybe there is some one who can fix it with less 
effort than me.

Probably this needs some kind of simple registry in the filesystem so 
all alsa-lib applications can share information about new (software 
emulated) control.

--
Petr.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
