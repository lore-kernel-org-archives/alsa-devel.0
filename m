From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Does ALSA offer built-in PLUG for JACK and non-interleaved cards?
Date: Tue, 20 Apr 2004 10:18:56 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200404201418.i3KEIuXW013746@dhin.linuxaudiosystems.com>
References: <20040420133839.RTOO4748.smtp1.fuse.net@smtp.fuse.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Tue, 20 Apr 2004 13:38:38 -0000."
             <20040420133839.RTOO4748.smtp1.fuse.net@smtp.fuse.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ico@fuse.net
Cc: linux-audio-dev@music.columbia.edu, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Does this mean that now one can channel ALSA-only aware apps directly to JACK 

Yes.

>and if so, are there any penalties of doing it this way as oposed to using JAC
>K-aware apps (i.e. Sample-sync?)?

Yes, you lose sample-synchronous guarantees. Also, there *might* be glitches
in the audio output of the ALSA apps using this technique, though its
unlikely to happen more frequently than if they were JACK apps.

>2) Is there also a plug in ALSA that allows for non-interleaved cards (i.e. hd
>sp) to be directly talked to (i.e. using aplay) since by default aplay complai
>ns how the soundcard is not interleaved and hence it fails.

the plughw:N device should take care of this. if not, alsa-devel needs
to know. i can use aplay to play stuff on my hdsp using plughw.

--p


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
