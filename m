From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Build-in mixer
Date: Wed, 15 Oct 2003 07:24:56 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200310151124.h9FBOunu021717@oud>
References: <3F8D1037.8060701@kky.zcu.cz>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Wed, 15 Oct 2003 11:15:35 +0200."
             <3F8D1037.8060701@kky.zcu.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Dan Tihelka <dtihelka@kky.zcu.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>	Starting to open device ....
>	Opening user device: --default--
>	Xlib: unexpected async reply (sequence 0x963)!

your program uses threads, right? or it forks at some point? and your
alsa_error() function involves calls to GUI functions? this error is from
Xlib, it has nothing to do with ALSA. its caused by having multiple
threads/processes making GUI calls without user-space
synchronization. most toolkits recommend that you do not do this, and
instead use a single thread for all GUI calls. you also cannot share a
connection to an X server between two processes.

--p




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
