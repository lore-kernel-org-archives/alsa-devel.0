From: <rs@ednet.at>
Subject: Re: problem with 8233 -- please help!
Date: Mon, 6 May 2002 18:24:10 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.04.10205061806350.5944-100000@pc51.ednet.at>
References: <20020505235958.B72C9A9F@byblos.ierne.eu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20020505235958.B72C9A9F@byblos.ierne.eu.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Sundance <sundance@ierne.eu.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hallo !

On Mon, 6 May 2002, Sundance wrote:

> The ALC650 (which is what you meant, right?) is indeed not recognized by 
> ALSA's AC97 code, if I understood that part of the sources of 0.9.0rc1 
> correctly. That can be relatively easily fixed by adding:
> { 0x414C4720, 0xfffffff0, "ALC650",            NULL },
> to snd_ac97_codec_ids[] in ac97_codec.c
> With that little change the ALC650 is apparently detected alright.

There are many changes in ac97.c (0.5.11 from realtek.com) and 0.9.0rc1 -
and without learning the acl650-documentation (also available from
realtek) it seems to be impossible to make the required changes to
0.9.0rc1. Maybe anyone here (on this list) which is able update ac97.c ???

I have tried it, but there are too much unknown hex-values, flags, bits...
and 'special-hacks' ... 

After reinstalling (once again and again... :-) my Win98se, i can play 
at least UnrealTounament again and see & hear my dvd's :-)

> If I try to use the via8233 module, I get the same result as you when playing 
> (no sound, I/O error). But even with the ALC650 added to ac97_codec.c, 
> modprobing snd-intel8x0 doesn't work:
> root@byblos:~# modprobe snd-intel8x0
> /lib/modules/2.4.18/kernel/sound/pci/snd-intel8x0.o: init_module: No such 
> device
> And the syslog reports that the ICH device wasn't found or is busy.
> So I guess it's not just a problem of AC97 not recognizing the ALC650. Argh.

I still think, the via8233 is the right driver. Win98 also reports a 'VIA
AC97 with RealTek 3D enhancement' and /proc/asund/card0/... also detects
'RealTek 3D enhancement' after loading via8233.o

Maybe the ALC is somehow connectet to the via-ac97 ?

> I'l keep you informed, should I somehow manage to get it to work (unlikely, 
> but eh). :)
thanks very much!

Liebe Gruesse, Schroettner Robert

|   Schroettner Robert
|   IT-Services
|   Eurodata Datenverarbeitungsdienst Ges.m.b.H.
|   Tel:  +43-1-7747076-51 +43-664-4345798    __   _
|         +43-664-4345798                    / /  (_)__  __ ____  __ 
|   Fax:  +43-1-7747076-12                  / /__/ / _ \/ // /\ \/ /
|   WWW:  http://www.ednet.at              /____/_/_//_/\_,_/ /_/\_\
|                                                    TUX for President
|   EURODATA - WIEN - PRAG - BRUENN - BUDAPEST


_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
