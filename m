From: Daniel Pouzzner <douzzer@mega.nu>
Subject: Re: RME96 patch broke
Date: Tue, 28 Jan 2003 16:24:30 -0500 (EST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301282124.h0SLOU690158@mail.mega.nu>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: torger@ludd.luth.se
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>> >so you have
>> >tested with an old ALSA and the new driver (rme96.c) and that does
>> > not work?
>>
>> Yuppers.  Pinned it down pretty carefully.
>>
>> >Is it double speed capture from analog, or from digital input you
>> > are having problems with?
>>
>> Analog.  Haven't tested digital for the bug yet.
>
>Uhm... I have some problems. It was ages ago I used the analog input, 
>and now when I test it, I can't get it to work at all... All I get is 
>noise. Could you confirm what does work with the analog input, even 
>with the new driver? I suspect that my hardware is broken...

Oh no!

Alright, I carefully ran the gamut to pin down what was broken.
Single and double speed analog playback works fine.  Single speed
analog capture works fine.  (Double speed playback fed back into
single speed capture, works fine.)  Double speed capture is messed up,
fed by either single or double speed playback.  If you need more, I
could post some spectrum displays of the breakage.


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
