From: Paul Davis <pbd@op.net>
Subject: Re: Pause and Resume testing needed
Date: Sat, 13 Apr 2002 12:19:36 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200204131618.g3DGIUX01135@post2.fast.net>
References: <3CB83E44.10402@superbug.demon.co.uk>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Sat, 13 Apr 2002 15:18:44 BST."
             <3CB83E44.10402@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: James@superbug.demon.co.uk
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Are there any test applications which test the pause/resume functionallity.
>
>I have an app which is calling pause, then resume, but after resume, the 
>sound is very choppy.

there are quite a lot of audio interfaces that don't support
pause/resume. its of questionable worth to use it in an application,
since it will not work on cards without support for it. i generally
just stop the audio and restart it again (prepare/start) when i need
this type of thing. the difference is marginal.

--p
