From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: s/pdif controls
Date: Tue, 11 Mar 2003 08:54:44 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18skA4-0000l5-00@sc8-sf-list1.sourceforge.net>
References: <s5hel5f5pda.wl@alsa2.suse.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Mon, 10 Mar 2003 14:21:21 +0100."
             <s5hel5f5pda.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>> how are users supposed to set various s/pdif bits?
>> 
>> the existing control formats involve massive bitfields that are
>> totally impenetrenable to almost everyone.
>> 
>> what is the strategy here? if someone wants to turn the pro/consumer
>> bit on/off, what are they supposed to do?
>
>a good question - there has not been much discussions there.
>the iec958 status bits are passed usually through AESx arguments of
>iec958 (aka spdif) pcm interface.  and i think it's a good way,
>because it's general and applicable to different cards in a uniform
>way.

true, but its totally impenetrable. i wrote a few drivers and even i
have absolutely no idea what those bitfields mean. 

>well, we'll need a kind of iec958-status-bit-composer, which is
>implemented on envy24control.  but i believe it should be a user-land
>solution, anyway.

i agree. but why are the status bit fields so long? is this following
IEC958 specs?



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
