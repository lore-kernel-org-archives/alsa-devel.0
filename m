From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Build-in mixer
Date: Wed, 15 Oct 2003 08:40:47 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200310151240.h9FCeluU021976@oud>
References: <3F8D3936.2080106@kky.zcu.cz>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Wed, 15 Oct 2003 14:10:30 +0200."
             <3F8D3936.2080106@kky.zcu.cz>
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

>Well, i am not author of this program actually. It is xmms plugin 
>allowing  to use ALSA for sound output (alsa-xmms-0.9). I only wanted to 
>modify it, to be able to use dmix. I see, that it is out of my abilities 
>:-(  and, so i will have to conctact the author of it and ask him to 
>correct it. It is pitty, because it will take time (if they ever do it). 
>I thought, that ALSA interface is not dependent on way, how it is opened 
>(because the same code with "hw:0:0" instead of "default" worked 
>perfectly) or did not i comprehend anything?. I would like to 
>understant, why opening "hw:0:0" works and only replacing it by 
>"default" does not. It seems to mee very dificult for developpers....

it would have helped enormously if you had stated that you were
talking about alsa-xmms up front. its a known and important piece of
code, and one that someone here is much more likely to fix than (sorry
to say) your own pet project.

takashi or jaroslav - does using dmix involve any threads? could the
alsa-xmms plugin be making calls to some xmms error code from a
non-GUI thread?


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
