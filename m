From: =?iso-8859-1?Q?J=F6rn?= Nettingsmeier <nettings@folkwang-hochschule.de>
Subject: unresolved symbol udelay with ALSA on PPC
Date: Mon, 13 May 2002 11:25:19 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CDF867F.44DA2DAD@folkwang-hochschule.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net, "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
List-Id: alsa-devel@alsa-project.org

hi !

sorry for crossposting, this one is probably inappropriate for either
the alsa or the ppc list. the problem is, i don't know which ;)

this is after successfully compiling 2.4.19-pre8-ben0 for PPC on a
powerbook g3 (pismo) and installing the alsa drivers from
alsa-driver-0.9.0rc1.tar.bz2:

ephraim:/usr/src/alsa-driver-0.9.0rc1 # depmod -ae -F
/boot/System.map-2.4.19-pre8-ben0
depmod: *** Unresolved symbols in
/lib/modules/2.4.19-pre8-ben0/kernel/sound/ppc/snd-powermac.o
depmod:         udelay

can anyone clue me in on this ? i grepped for udelay, but it seems it's
a very popular string in the source tree, so i gave up :( it seems to be
defined alright for other kernel modules. afaics, snd-powermac is the
only one that has problems.

thanks in advance,

j=F6rn



--
Watch out where the huskies go and don't you eat
the yellow snow !
	- Frank Zappa

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
