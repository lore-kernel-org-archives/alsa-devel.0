From: Paul Davis <pbd@op.net>
Subject: Re: .asoundrc file
Date: Fri, 16 Aug 2002 07:05:50 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E17fetV-0008Nd-00@usw-sf-list1.sourceforge.net>
References: <3D5C77E9.1040807@boosthardware.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Fri, 16 Aug 2002 12:56:25 +0900."
             <3D5C77E9.1040807@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: u9514439@anu.edu.au, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>> What is the purpose of the ctl.rme9652 declaration? My plugin devices
>> seem to work without it.
>> 
>
>It is a configuration for the onboard mixer. Very little is known about 
>why we use it. Some programs (JACK) won't work without it.

not really.

the control device for a card is the way that programs modify various,
suprise, "controls" on the card. for many cards, this includes the
mixer, though in the example above, the rme9652 has no mixer. it does
still have a number of controls, however, and JACK needs to be able to
access them. Examples include the digital i/o sync indicators, sample
clock source switch and so on.

as for why the name itself is required: JACK was written to open both
the PCM and control devices using a single name. I felt this was nicer
and less confusing than asking the user to specify two different
names.

--p


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
