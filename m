From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Avoiding xruns... was Re: smix plugin available?
Date: Wed, 27 Nov 2002 08:55:00 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18H2b5-0006JC-00@sc8-sf-list1.sourceforge.net>
References: <3DE4C38F.70302@superbug.demon.co.uk>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Thu, 28 Nov 2002 00:07:27 +1100."
             <3DE4C38F.70302@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: Jaroslav Kysela <perex@suse.cz>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>I am currently taking the following approach: -
>Always prepare 2 audio hardware periods of sample frames in advance 
>inside the user app.
>
>1) snd_pcm_wait()
>2) write()
>3) prepare new sample frames, then go back to (1).

for lower latency, you'd do:

 1) snd_pcm_wait()
 2) prepare new sample frames
 3) write(), then go back to (1).

but for the kinds of things you are describing, your original order
seems OK.

--p


-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
