From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Jack-Alsa plugin - problems
Date: Mon, 05 Jan 2004 09:02:05 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200401051402.i05E259r020637@dhin.linuxaudiosystems.com>
References: <04de01c3d37f$20a3aa10$5d40a8c0@FRiskMan.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Mon, 05 Jan 2004 11:29:04 GMT."
             <04de01c3d37f$20a3aa10$5d40a8c0@FRiskMan.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ed Wildgoose <Ed@Wildgooses.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>However, trying to use either xmms, mplayer or mythtv with the same alsa
>device just seems to leave the app "hanging" and not doing anything, and
>attempts to fastforward in mplayer and mythtv (which presumably causes the
>alsa layer in each app to try and pause then reopen the sound layer) causes
>the error:
>
>"You cannot set callbacks on an active client
>cannot connect alsaP:out_000
> to alsa_pcm:playback_1"

if these clients really do call snd_pcm_close() when ffwd'ing, then
there must be some mistake in the ALSA JACK plug, because it should
close the client down. if they do not call snd_pcm_close() then i am
not sure what the ALSA JACK plug might be doing.

in short, its a problem with the interaction between the design of
these apps and the ALSA JACK plug. JACK clients are supposed to run
continuously. these apps don't do that, it appears, and they are
triggering some problem with the JACK plug. 

--p




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
