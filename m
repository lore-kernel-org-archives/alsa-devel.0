From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Mono to stereo ?
Date: Thu, 27 Mar 2003 21:46:20 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18yjnp-0000ZA-00@sc8-sf-list1.sourceforge.net>
References: <3E83BE0E.4070406@embedded.cl>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Thu, 27 Mar 2003 23:14:22 -0400."
             <3E83BE0E.4070406@embedded.cl>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Manuel Jander <mjander@embedded.cl>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>>>When an application opens a mono substream, the sound has to
>>>be sent to one channel only or must the low level driver
>>>transparently convert it to stereo ?
>>>    
>>>
>>
>>one channel only.
>>
>>in ALSA, low level drivers do not do any kind of format
>>conversion. that is accomplished (if necessary) by code running in
>>user-space, typically part of alsa-lib. the low level driver simply
>>advertises the capabilities of the hardware, provides ways to use
>>those capabilities, and lets the midlevel code and alsa-lib do the rest.
>>  
>>
>
>...but, if you are doing mono playback, your sound driver has to setup
>your soundcard to playback on both channels the same mono channel. The 
>Vortex
>driver (still not in the main branch) for example splits the mono signal 
>on its internal
>mixer into 2 identical signals which are feed one into each CODEC channels.

that's a driver author's design decision. if the "hw" PCM device is
opened with a single channel, it would be equally valid to play on one
channel only. if the h/w can't handle that, it should not
advertise itself to be capable of mono operation. IMHO.

--p



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
