From: Paul Davis <pbd@op.net>
Subject: Re: more info
Date: Wed, 24 Apr 2002 20:34:22 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200204250030.g3P0UnP04729@post2.fast.net>
References: <20020425000520.44054.qmail@web11503.mail.yahoo.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Wed, 24 Apr 2002 17:05:20 PDT."
             <20020425000520.44054.qmail@web11503.mail.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Guilhem Tardy <guilhem_tardy@yahoo.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Could anyone point to me a reference for the following (or explain to me
>directly what is the purpose of each of those functions) in the PCM module:
>
>	prepare:	snd_xxxx_capture_prepare,
>	trigger:	snd_xxxx_trigger,
>	pointer:	snd_xxxx_pointer,
>	copy:		snd_xxxx_capture_copy,
>	silence:	snd_xxxx_capture_silence,

search for "prepare" and "trigger" in the archives, and you should find
takashi's basic explanation of what the functions do. then come back
and ask more specific questions. 

>Plus, what is the fifo size (e.g. on the card)?

i'm not sure its relevant for cards with DMA. can't tell you more.

--p
