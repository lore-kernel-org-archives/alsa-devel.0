From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: Re: USB recording - repetitive peaks
Date: Wed, 03 Jul 2002 01:37:30 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D21D6CA.7000308@boosthardware.com>
References: <3D208C5C.36649172@ladisch.de>	<s5hhejibem0.wl@alsa2.suse.de>	<3D21B878.8090902@boosthardware.com>	<s5hy9curxdr.wl@alsa2.suse.de>	<3D21C827.2060602@boosthardware.com> <s5hwuseruac.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Hi Patrick,
> 
> i found out an obvious bug there.  i forgot to correct the offset
> value of capture destination after a minor modification.
> it's fixed on cvs.
> could you update the cvs and test whether it works?
> 

I get this in alsa-utils

----
/usr/local/src/music/alsa/alsa-utils# ./cvscompile 
--with-cards=intel8x0,cmipci,usb-audio,usb-midi 
--with-sequencer=yes;make;make install
aclocal: configure.in: 11: macro `AM_PATH_ALSA' not found in library
/usr//share/automake/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr//share/automake/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr//share/automake/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr//share/automake/am/lang-compile.am: AMDEP does not appear in 
AM_CONDITIONAL
/usr//share/automake/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr//share/automake/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr//share/automake/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr//share/automake/am/lang-compile.am: AMDEP does not appear in 
AM_CONDITIONAL
/usr//share/automake/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr//share/automake/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr//share/automake/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr//share/automake/am/lang-compile.am: AMDEP does not appear in 
AM_CONDITIONAL
/usr//share/automake/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr//share/automake/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr//share/automake/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr//share/automake/am/lang-compile.am: AMDEP does not appear in 
AM_CONDITIONAL
/usr//share/automake/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr//share/automake/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr//share/automake/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr//share/automake/am/lang-compile.am: AMDEP does not appear in 
AM_CONDITIONAL
/usr//share/automake/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr//share/automake/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr//share/automake/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr//share/automake/am/lang-compile.am: AMDEP does not appear in 
AM_CONDITIONAL
configure.in:4: error: possibly undefined macro: AM_INIT_AUTOMAKE
configure.in:11: error: possibly undefined macro: AM_PATH_ALSA
configure.in:28: error: possibly undefined macro: AM_CONFIG_HEADER
CFLAGS=-O2 -Wall -pipe -g
./configure --with-cards=intel8x0,cmipci,usb-audio,usb-midi 
--with-sequencer=yes
./configure: line 922: syntax error near unexpected token 
`AM_INIT_AUTOMAKE(alsa-utils,'
./configure: line 922: `AM_INIT_AUTOMAKE(alsa-utils, 0.9.0rc2)'
make: *** No targets specified and no makefile found.  Stop.
make: *** No rule to make target `install'.  Stop.

----

-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
========================================



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
