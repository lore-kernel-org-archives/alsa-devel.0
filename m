From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: HDSP 9652 - a couple of small (?) issues
Date: Wed, 11 Dec 2002 17:00:26 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18MErg-0003G8-00@sc8-sf-list1.sourceforge.net>
References: <1039637351.1652.1.camel@Godzilla>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "11 Dec 2002 12:09:09 PST."
             <1039637351.1652.1.camel@Godzilla>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <markknecht@attbi.com>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>, PlanetCCRMA <planetccrma@ccrma.stanford.edu>
List-Id: alsa-devel@alsa-project.org

>   I notice I get a message "IO box is a DigiFace" in dmesg. Is the
>mixer in DigiFace working, or is there some possibility that there's a
>clue there?

the mixer is disabled by the firmware on the 9652 because the
registers used to access it are different than on the hdsp. so yes,
the hdsp mixer works, but i am still waiting for all the information i
need from RME. they sent me some stuff this morning, but not how to
re-enable the mixer.

that message, btw, is the kind of thing i want to eliminate with a
"better" patch than just the revnumber one.

--p


-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
