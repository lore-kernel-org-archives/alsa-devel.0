From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Re: bug tracking?
Date: Tue, 20 May 2003 12:46:02 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200305201649.SAA06156@alsa.alsa-project.org>
References: <Pine.LNX.4.50-xtra.0305201645001.6471-100000@yme.mo.himolde.no>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail09.voicenet.com (mail09.voicenet.com [207.103.0.43])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id SAA06156
	for <alsa-devel@alsa-project.org>; Tue, 20 May 2003 18:49:41 +0200
In-reply-to: Your message of "Tue, 20 May 2003 16:51:56 +0200."
             <Pine.LNX.4.50-xtra.0305201645001.6471-100000@yme.mo.himolde.no>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Erik Inge Bols <knan@mo.himolde.no>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>every bug, log any discussion on that mailing list as related to that
>bug... and add anyone seen in CC: to the same mailing list. Don't
>remember the bug system's name right now, sorry.
>
>But it strikes me as an elegant way of doing it.

the upcoming ardour bugzilla will be primarily controlled (for
submissions) by using a script that the user runs on their machine. it
collects a lot of information about their h/w and s/w configuration,
tars that all up with their report, and emails it to the bugzilla
database. the relevant info is extracted from the tarfile, entered
into the bug system, and associated with the tarfile so we can look at
it later it we need to. they don't login, but they do need to go
online at some point. thats all ...

--p


-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
