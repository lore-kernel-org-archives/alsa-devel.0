From: Paul Davis <pbd@Op.Net>
Subject: Re: Re: [Jackit-devel] Re: should i be able to abort in the middle of snd_pcm_mmap_{begin,commit} ?
Date: Thu, 14 Feb 2002 15:59:54 -0500
Message-ID: <200202142104.QAA18747@renoir.op.net>
In-reply-to: Your message of "Thu, 14 Feb 2002 19:39:39 +0200."
             <Pine.LNX.4.44.0202141930420.3739-100000@ecabase.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Cc: jackit-devel@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Normal 'snd_pcm_drop() -> snd_pcm_prepare() -> snd_pcm_start()' sequence 
>doesn't solve the problem. Audio is still garbled. I didn't try full 
>'close() -> ... -> open() -> ..' cycle yet, as that would involve quite a 
>lot of work (jackd's alsa_driver.c is a long piece of code).

its my feeling that the error is in JACK somewhere. as far as i can
tell, the drop/prepare/start sequence restores the hw and driver to
the correct condition, but apparently not JACK's internals.

--p

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
