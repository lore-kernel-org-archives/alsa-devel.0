From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Build-in mixer
Date: Tue, 14 Oct 2003 07:34:22 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200310141134.h9EBYMEM002694@oud>
References: <3F8BA81B.2070602@kky.zcu.cz>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Tue, 14 Oct 2003 09:39:07 +0200."
             <3F8BA81B.2070602@kky.zcu.cz>
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

>I experimented with xmms ALSA output plugin and i forced "default" 
>instead of "hw:0:0" to the audio opening command:
>
>snd_pcm_open ( &handle, "default", SND_PCM_STREAM_PLAYBACK, 
>SND_PCM_NONBLOCK );
>
>but a error occured. I would like to ask you, if it is sufficient to 

perhaps you know this, but 

	"an error occured"

is an extremely content-free way of describing a problem.

>change it only, or if there must be other changes when opening device? 

no other change is necessary. however, to do what you want, you have
to redefine the "default" device to be a dmix device. clemens
takashi posted within the last couple of days how to do this.


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
