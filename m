From: "Rui Nuno Capela" <rncbc@rncbc.org>
Subject: Re: Re: Tascam US-224/428 MMC?
Date: Wed, 21 Jul 2004 10:37:41 +0100 (WEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1861.195.245.190.93.1090402661.squirrel@195.245.190.93>
References: <33466.195.245.190.93.1089901175.squirrel@195.245.190.93>
    <7444.195.245.190.93.1090312112.squirrel@195.245.190.93>
    <20040720180512.GA527@tuba.home>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040720180512.GA527@tuba.home>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Martin Langer <martin-langer@gmx.de>
Cc: alsa-devel@lists.sourceforge.net, annabellesgarden@yahoo.de, ws@seh.de
List-Id: alsa-devel@alsa-project.org

Martin, everybody,

>> I remember some time ago, while fighting to get some LEDs lighten up
>> on my us224 from linux, it was then referred that us428control would
>> possibly act as a MMC proxy or something like to it.
>>
>> Then I was wondering if I could get my us224 to act like a "real"
>> control surface with some linux DAW (i.e. ardour :), being able to
>> effectively use the transport buttons, the jog wheeel, etc.
>>
>> Are you guys having any luck with this issue? I'm assuming that us224
>> is the lil'sister of us428, and I'm guessing that the command control
>> protocol is quite the same. Am I right?
>
> comparing some log-files of usbsnoopy (or any similar program) should
> solveit. But I, too, believe that 224/428 are nearly the same on a high
> level.
>

My idea is all about having a modified us428control that would filter and
translate the us224 control protocol into and from standard MMC. My doubts
goes if this protocol is identical or at least compatible on the us428.

You may check it from the official manual:
http://www.tascam.com/products/US-224/pdf/us224_manual.pdf, Appendix B.

I've already confirmed that it's actually understood on current
us428control from alsa-tools. My proposal goes to extending it to:

- listen on alsa_seq input port, for MMC messages:
all incoming MMC messages are filtered and translated to equivalent
us224/us428 control protocol messages, which are handled internally as
usual.

- tap on alsa_seq output port, for us224/us428 control protocol messages:
outgoing us224/us428 control protocol messages are mapped to equivalent
MMC messages, whenever applicable, which are queued out as appropriate.

>> So, all I want is about having my us224 to respond and react to MMC, and
>> see some transport control LEDs blinking all the way up :)
>>
>> Are there any efforts already being thought in this direction? If it's
>> only a question of man-power I wouldn't mind to step in and go for it.
>> I'd rather love to hear from you in the first place, nevertheless.
>
> Well, my us122 has no controller stuff. I guess it's even impossible to
> fix this with a more advanced firmware;-) But, go ahead and improve
> things. Your code is always welcome, except Karsten has already solved
> it;-)
>

That's the purpose of my postings, to ask if someone has already
implemented something like this, willing to help or even step in and
advance some ideas.

I guess everybody's busy on holidays, I'll be too, in a few weeks :)

Cheers,
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
