From: Paul Davis <pbd@op.net>
Subject: Re: Help with LATENCY FULL DUPLEX AUDIO
Date: Thu, 25 Apr 2002 18:31:59 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E170riv-00050z-00@usw-sf-list1.sourceforge.net>
References: <8d9365b00c929cc7d563e23ef033fea7@www1.mail.volny.cz>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Fri, 26 Apr 2002 00:04:20 +0200."
             <8d9365b00c929cc7d563e23ef033fea7@www1.mail.volny.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: pavelni@volny.cz
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>I am just working (finishing) on modular realtime effect procesor. It
>is my thesis project. I would like to ask three questions:
>
>1.
>How can I calculate the latency in ms with OSS driver?

this is alsa-devel. there is nobody here who is interested in
supporting this archaic and limiting API. we would encourage you to
convert your application to ALSA or ... (see below)

>2.
>My program do the effects on audio in realtime.
>So I added recording the sound to hard disk.

This is called creaping featuritis :)

>This work ok. But when I play back the recorded sound (from HD), it
>changes me buffer length that latency is very big. My solution to
>this problem was to close device and
>initalize same device one more time after playing the sound.
>Is there better solution for me?

Use JACK (http://jackit.sf.net) and forget about this stuff in your
program, which can then focus on what it does best.

Its also hard to understand what you've described, since the act of
playing or capturing data does nothing to the h/w or s/w settings of
the drivers, even under OSS AFAIK (and certainly not under ALSA).

>3.
>Is there some advices how to set the lowest latency?

No 2.4-series kernel can go below about 128 frames per interrupt right
now. For general advice on setting latency, see the somewhat
incomplete docs at www.alsa-project.org. You might also read up on low
latency issues at http://www.linuxdj.com/lad/

--p
