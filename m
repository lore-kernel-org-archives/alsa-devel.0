From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: I/O Error in mmapping ES 1969
Date: Fri, 10 Oct 2003 08:55:56 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200310101255.h9ACturd017106@oud>
References: <200310101427.43458.Safari.Doktor@addcom.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Fri, 10 Oct 2003 14:29:48 +0200."
             <200310101427.43458.Safari.Doktor@addcom.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Dr. med. =?iso-8859-15?q?G=FCnther?= Montag" <Safari.Doktor@addcom.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>I mentioned my ham radio realtime program with mmap
>in a posting on 3. Oct and before.
>It works now with ALSA 0.9.7 with AC97 and maybe some other cards, thanks!!!
>With ESS ES1969 mmap(ibuf, isize, PROT_READ, MAP_FILE | MAP_SHARED | 
>MAP_FIXED, fd_audio, 0)
>(and I tried also all other MAP_ options) it breaks with I / O error.
>Do You know some help about mmap besides man,

IIRC, mmap with OSS doesn't work unless you use the LD_PRELOAD
hack. this loads a library that intercepts all standard system calls
and routes them through alsa-lib. your app will not run without
this. why? mmap provides direct access to the DMA buffer of the
hardware, and thus bypasses most of what alsa-lib does. ALSA does
support such direct access, but not in the simplistic way that OSS
provides.

or can I do something with "Scatter Gather" in ALSA API,
>or does it help if i work myself into JACK for this problem?
>hints welcome, tnx!!!

either use ALSA natively, or use JACK, or use the LD_PRELOAD hack.


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
