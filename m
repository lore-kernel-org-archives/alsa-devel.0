From: "Karsten Wiese" <annabellesgarden@yahoo.de>
Subject: AW: Major Bug in Alsa 0.9  for over 1 year
Date: Fri, 25 Oct 2002 14:02:24 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <DAELIEGDPLDDCIJPAICBGEBACEAA.annabellesgarden@yahoo.de>
References: <22050.1035518578@www52.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <22050.1035518578@www52.gmx.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: kreuzritter2000@gmx.de
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> -----Ursprüngliche Nachricht-----
> Von: alsa-devel-admin@lists.sourceforge.net
> [mailto:alsa-devel-admin@lists.sourceforge.net]Im Auftrag von
> kreuzritter2000@gmx.de
> Gesendet: Freitag, 25. Oktober 2002 06:03
> An: alsa-devel@lists.sourceforge.net
> Betreff: [Alsa-devel] Major Bug in Alsa 0.9 for over 1 year
>
> ........
> insmod snd-cs4232
> Using /lib/modules/2.4.19/kernel/sound/isa/cs423x/snd-cs4232.o
> /lib/modules/2.4.19/kernel/sound/isa/cs423x/snd-cs4232.o:
> unresolved symbol
> snd_card_new_R506deba1

the "_R506deba1" makes me think snd-cs4232.o is compiled with module
versionnumbers
and the module, snd_card_new lives in, haS been made without module version
numbers.

maybe recompiling & installing everything (kernel, alsa) without
moduleversionnumbers helps.

karsten


__________________________________________________________________

Gesendet von Yahoo! Mail - http://mail.yahoo.de
Möchten Sie mit einem Gruß antworten? http://grusskarten.yahoo.de


-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0004en
