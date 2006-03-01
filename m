From: Rimas Kudelis <rq@akl.lt>
Subject: Re: Re: [PATCH] Add support for Acer TravelMate and
Date: Wed, 01 Mar 2006 09:32:25 +0200
Message-ID: <44054E09.7070901@akl.lt>
References: <200602282345.k1SNjPfu020504@auster.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200602282345.k1SNjPfu020504@auster.physics.adelaide.edu.au>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: Lee Revell <rlrevell@joe-job.com>, alsa-devel@lists.sourceforge.net, Paulo Matias <syscoder@gmail.com>
List-Id: alsa-devel@alsa-project.org

Jonathan Woithe wrote:
>>> The "CD" input on the ALC260 is an analog input.  It expects the CD drive to
>>> do all the audio decoding and present an ordinary stereo signal to this pin. 
>>> If when playing a CD and enabling the "CD" control you get no audio that
>>> strongly suggests that there is no audio signal running to that pin.
>>> However, if there is no analog connection to the ALC260 one does wonder
>>> precisely how these systems are expected to play CDs.  The only option 
>>> left would be for software to read the raw CD bitstream (which isn't a straight
>>> audio bitstream), decode it and then send the resulting audio bitstream to
>>> the DAC.  Given that CD drives are more than capable of doing all this it would
>>> surprise me if this were the case.
>>>
>>> One thing worth checking though - have you tested *all* ALC260 inputs with
>>> the CD playing?  Maybe Acer connect the CD audio to some other ALC260 pin. 
>>>       
To be honest, I haven't. I thought the CD pin is a bit different from
the others, so I didn't bother to test everything.

>> I would not be surprised if some vendors were leaving out the DAC from
>> their CD drives, and expect you to play audio CDs in digital mode.  I
>> believe this is how Windows Media Player works by default (it also
>> allows it to generate visual effects from the CD audio).
>>     
> Ah, right.  I wasn't aware of that.  If that's its default behaviour then
> perhaps the Acers do expect the OS to use digital mode for playing CDs. If
> this proves to be the case then we'll revise the "acer" model to omit the CD
> controls.
I believe the Gnome CD player and Sound Juicer applications do that too.
I think they, just like all other Gnome apps, use the Gstreamer
framework. And I can even see a reason for that - most soundcards only
have one set of pins for a CD (i.e. only one cd channel) meanwhile many
new desktops come with two CD drives. Add to this what Lee has
mentioned, and you get quite a set of reasons to use software to extract
audio.

Rimas



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
