From: Paul Davis <pbd@op.net>
Subject: Re: Example app source code or docs needed to help me do mmap.
Date: Sat, 27 Apr 2002 12:59:31 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200204271659.g3RGx7f11351@post2.fast.net>
References: <3CC9F106.8020806@superbug.demon.co.uk>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Sat, 27 Apr 2002 01:29:58 BST."
             <3CC9F106.8020806@superbug.demon.co.uk>
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

>Can someone point me to an example alsa app doing mmap ?
>
>I want to convert my application from plain pcm_write  to mmap mode.
>I would also like to understand how you detect if a sound card can do 
>mmap or not.
>
>I help develope a multimedia application, and 6 audio channels (5.1 
>sound) starts to require mmap mode on very slow PCs.

either

	aplay.c (simple, confusing)
	latency.c (simple, limited)
	{JACK}/alsa_driver.c (complete, confusing)

might help. I think that the Jack case is the only one that handles
what I would call "synchronous full duplex" (i.e. capture and playback
running in sync). the others don't tend to worry about that detail,
and it affects the inner loops of the code quite a bit.

to find out if mmap is support, you ask use

   snd_pcm_hw_params_set_access (handle, params,
			         SND_PCM_ACCESS_MMAP_NONINTERLEAVED);

or

   snd_pcm_hw_params_set_access (handle, params,
			         SND_PCM_ACCESS_MMAP_INTERLEAVED);

if it works, then it works :) BTW, any "plug" device supports mmap
mode regardless or not of the corresponding "hw" device(s) do. that's
partly why JACK uses mmap mode without checking for this - if a user
tries it on h/w that doesn't support it, they can just use
"plughw:D,S" instead of "hw:D,S" when naming it.

--p
