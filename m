From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: hdsp problem
Date: Thu, 15 Jan 2004 15:02:09 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200401152002.i0FK29cm014929@dhin.linuxaudiosystems.com>
References: <20040115213042.5011ee58.TimBlechmann@gmx.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Thu, 15 Jan 2004 21:30:42 +0100."
             <20040115213042.5011ee58.TimBlechmann@gmx.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Tim Blechmann <TimBlechmann@gmx.net>
Cc: Jesse Chappell <jesse@essej.net>, alsa list <alsa-devel@lists.sourceforge.net>, alsa-user@lists.sourceforge.net, linux-audio-user@music.columbia.edu
List-Id: alsa-devel@alsa-project.org

>it's not working on my system (i tried 64, 128, 256) ... but playing

then i guess there is more than one problem. i would also recommend
checking into whatever is sharing the interrupt that the hdsp is
on. on my laptop, way too many things are on IRQ10 (USB, CardBus,
Wifi, HDSP). this seems hard to change, but it might have some effect.

>with the different settings, i figured out, that i can't change the
>number of periods in the hardware buffer ... it's always 2 times the
>number of frames per period ...

thats the hardware design of all the hammerfall series devices. RME
calls its "ASIO in hardware". snicker.

>jack returns as error message:
>ALSA: cannot set number of periods to 1 for capture 

that would make no sense whatsoever. 

>nearly giving up the hope ...

never give up. there are lots of people using the h/w you have with
100% success. i have to pack up and run off to NAMM now. sorry i can't
be more helpful for now.

--p


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
