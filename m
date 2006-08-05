From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0002337]: Compilation problem ...
	previous advice here didn't work for me ...
Date: Sat, 5 Aug 2006 15:24:47 +0200
Message-ID: <4a1dc483d2ee89a4b743ab81abaa454c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 90C3B16B
	for <alsa-devel@alsa-project.org>;
	Sat,  5 Aug 2006 15:24:47 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2337> 
======================================================================
Reported By:                Mikey84
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   2337
Category:                   alsactl
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     feedback
======================================================================
Date Submitted:             08-05-2006 09:46 CEST
Last Modified:              08-05-2006 15:24 CEST
======================================================================
Summary:                    Compilation problem ... previous advice here didn't
work for me ...
Description: 
I have also a compilation problem. Almost similar as cimmo had, and I tried
to do the same tricks as he was told to do, but they didn't work ... I
have alsa-driver and alsa-lib correctly installed, but this alsa-utils
doesn't compile ...

'Make' gives me this kind of error message:

_______________________________________________________________________________

Making all in amixer
make[1]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Linux/ALSA/alsa-utils-1.0.12rc2/amixer'
gcc  -g -O2   -o amixer  amixer.o -lm -lasound -lm -ldl -lpthread
amixer.o: In function `control_access':
/home/Mikey_A/Asennus_LINUX/Linux/ALSA/alsa-utils-1.0.12rc2/amixer/amixer.c:157:
undefined reference to `snd_ctl_elem_info_is_tlv_readable'
/home/Mikey_A/Asennus_LINUX/Linux/ALSA/alsa-utils-1.0.12rc2/amixer/amixer.c:158:
undefined reference to `snd_ctl_elem_info_is_tlv_writable'
/home/Mikey_A/Asennus_LINUX/Linux/ALSA/alsa-utils-1.0.12rc2/amixer/amixer.c:159:
undefined reference to `snd_ctl_elem_info_is_tlv_commandable'
amixer.o: In function `show_control':
/home/Mikey_A/Asennus_LINUX/Linux/ALSA/alsa-utils-1.0.12rc2/amixer/amixer.c:539:
undefined reference to `snd_ctl_elem_info_is_tlv_readable'
/home/Mikey_A/Asennus_LINUX/Linux/ALSA/alsa-utils-1.0.12rc2/amixer/amixer.c:542:
undefined reference to `snd_hctl_elem_tlv_read'
collect2: ld returned 1 exit status
make[1]: *** [amixer] Error 1
make[1]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Linux/ALSA/alsa-utils-1.0.12rc2/amixer'
make: *** [all-recursive] Error 1
[root@a-55-58 alsa-utils-1.0.12rc2]#

_______________________________________________________________________________
                                      
======================================================================

----------------------------------------------------------------------
 Mikey84 - 08-05-06 14:44 
----------------------------------------------------------------------
I did, but still it doesn't work ...

And yes, my system is a x86_64 thing ...

This is what I get from "make":
_______________________________________________________________________________

Making all in include
make[1]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Linux/ALSA/alsa-utils-1.0.12rc2/include'
make  all-am
make[2]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Linux/ALSA/alsa-utils-1.0.12rc2/include'
make[2]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Linux/ALSA/alsa-utils-1.0.12rc2/include'
make[1]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Linux/ALSA/alsa-utils-1.0.12rc2/include'
Making all in alsactl
make[1]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Linux/ALSA/alsa-utils-1.0.12rc2/alsactl'
if gcc -DHAVE_CONFIG_H -I. -I. -I../include     -g -O2 -MT alsactl.o -MD
-MP -MF ".deps/alsactl.Tpo" -c -o alsactl.o alsactl.c; \
then mv -f ".deps/alsactl.Tpo" ".deps/alsactl.Po"; else rm -f
".deps/alsactl.Tpo"; exit 1; fi
if gcc -DHAVE_CONFIG_H -I. -I. -I../include     -g -O2 -MT state.o -MD -MP
-MF ".deps/state.Tpo" -c -o state.o state.c; \
then mv -f ".deps/state.Tpo" ".deps/state.Po"; else rm -f
".deps/state.Tpo"; exit 1; fi
if gcc -DHAVE_CONFIG_H -I. -I. -I../include     -g -O2 -MT names.o -MD -MP
-MF ".deps/names.Tpo" -c -o names.o names.c; \
then mv -f ".deps/names.Tpo" ".deps/names.Po"; else rm -f
".deps/names.Tpo"; exit 1; fi
gcc  -g -O2   -o alsactl  alsactl.o state.o names.o  -lasound -lm -ldl
-lpthread
make[1]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Linux/ALSA/alsa-utils-1.0.12rc2/alsactl'
Making all in alsaconf
make[1]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Linux/ALSA/alsa-utils-1.0.12rc2/alsaconf'
Making all in po
make[2]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Linux/ALSA/alsa-utils-1.0.12rc2/alsaconf/po'
make[2]: Nothing to be done for `all'.
make[2]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Linux/ALSA/alsa-utils-1.0.12rc2/alsaconf/po'
make[2]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Linux/ALSA/alsa-utils-1.0.12rc2/alsaconf'
make[2]: Nothing to be done for `all-am'.
make[2]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Linux/ALSA/alsa-utils-1.0.12rc2/alsaconf'
make[1]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Linux/ALSA/alsa-utils-1.0.12rc2/alsaconf'
Making all in alsamixer
make[1]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Linux/ALSA/alsa-utils-1.0.12rc2/alsamixer'
if gcc -DHAVE_CONFIG_H -I. -I. -I../include     -g -O2 -MT alsamixer.o -MD
-MP -MF ".deps/alsamixer.Tpo" -c -o alsamixer.o alsamixer.c; \
then mv -f ".deps/alsamixer.Tpo" ".deps/alsamixer.Po"; else rm -f
".deps/alsamixer.Tpo"; exit 1; fi
gcc  -g -O2   -o alsamixer  alsamixer.o -lncurses -lasound -lm -ldl
-lpthread
make[1]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Linux/ALSA/alsa-utils-1.0.12rc2/alsamixer'
Making all in amidi
make[1]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Linux/ALSA/alsa-utils-1.0.12rc2/amidi'
if gcc -DHAVE_CONFIG_H -I. -I. -I../include -I../include    -g -O2 -MT
amidi.o -MD -MP -MF ".deps/amidi.Tpo" -c -o amidi.o amidi.c; \
then mv -f ".deps/amidi.Tpo" ".deps/amidi.Po"; else rm -f
".deps/amidi.Tpo"; exit 1; fi
gcc  -g -O2   -o amidi  amidi.o  -lasound -lm -ldl -lpthread
make[1]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Linux/ALSA/alsa-utils-1.0.12rc2/amidi'
Making all in amixer
make[1]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Linux/ALSA/alsa-utils-1.0.12rc2/amixer'
if gcc -DHAVE_CONFIG_H -I. -I. -I../include -I../include    -g -O2 -MT
amixer.o -MD -MP -MF ".deps/amixer.Tpo" -c -o amixer.o amixer.c; \
then mv -f ".deps/amixer.Tpo" ".deps/amixer.Po"; else rm -f
".deps/amixer.Tpo"; exit 1; fi
gcc  -g -O2   -o amixer  amixer.o -lm -lasound -lm -ldl -lpthread
amixer.o
:
 
In
 
function
 
`
control_access
'
:

/
home
/
Mikey_A
/
Asennus_LINUX
/
Linux
/
ALSA
/
alsa
-
utils
-
1.0.12rc2
/
amixer
/
amixer.c
:
157
:
 
undefined
 
reference
 
to
 
`
snd_ctl_elem_info_is_tlv_readable
'

/
home
/
Mikey_A
/
Asennus_LINUX
/
Linux
/
ALSA
/
alsa
-
utils
-
1.0.12rc2
/
amixer
/
amixer.c
:
158
:
 
undefined
 
reference
 
to
 
`
snd_ctl_elem_info_is_tlv_writable
'

/
home
/
Mikey_A
/
Asennus_LINUX
/
Linux
/
ALSA
/
alsa
-
utils
-
1.0.12rc2
/
amixer
/
amixer.c
:
159
:
 
undefined
 
reference
 
to
 
`
snd_ctl_elem_info_is_tlv_commandable
'

amixer.o
:
 
In
 
function
 
`
show_control
'
:

/
home
/
Mikey_A
/
Asennus_LINUX
/
Linux
/
ALSA
/
alsa
-
utils
-
1.0.12rc2
/
amixer
/
amixer.c
:
539
:
 
undefined
 
reference
 
to
 
`
snd_ctl_elem_info_is_tlv_readable
'

/
home
/
Mikey_A
/
Asennus_LINUX
/
Linux
/
ALSA
/
alsa
-
utils
-
1.0.12rc2
/
amixer
/
amixer.c
:
542
:
 
undefined
 
reference
 
to
 
`
snd_hctl_elem_tlv_read
'

collect2: 
ld returned 1 exit status

make[1]: 
*** [amixer] Error 1

make[1]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Linux/ALSA/alsa-utils-1.0.12rc2/amixer'
make: 
*** [all-recursive] Error 1

Making install in include
make[1]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Linux/ALSA/alsa-utils-1.0.12rc2/include'
make[2]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Linux/ALSA/alsa-utils-1.0.12rc2/include'
make[2]: Nothing to be done for `install-exec-am'.
make[2]: Nothing to be done for `install-data-am'.
make[2]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Linux/ALSA/alsa-utils-1.0.12rc2/include'
make[1]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Linux/ALSA/alsa-utils-1.0.12rc2/include'
Making install in alsactl
make[1]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Linux/ALSA/alsa-utils-1.0.12rc2/alsactl'
make[2]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Linux/ALSA/alsa-utils-1.0.12rc2/alsactl'
test -z "/usr/sbin" || mkdir -p -- "/usr/sbin"
  /usr/bin/install -c 'alsactl' '/usr/sbin/alsactl'
test -z "/usr/man/man1" || mkdir -p -- "/usr/man/man1"
 /usr/bin/install -c -m 644 './alsactl.1' '/usr/man/man1/alsactl.1'
make[2]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Linux/ALSA/alsa-utils-1.0.12rc2/alsactl'
make[1]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Linux/ALSA/alsa-utils-1.0.12rc2/alsactl'
Making install in alsaconf
make[1]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Linux/ALSA/alsa-utils-1.0.12rc2/alsaconf'
Making install in po
make[2]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Linux/ALSA/alsa-utils-1.0.12rc2/alsaconf/po'
mkdir -p -- /usr/share
make[2]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Linux/ALSA/alsa-utils-1.0.12rc2/alsaconf/po'
make[2]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Linux/ALSA/alsa-utils-1.0.12rc2/alsaconf'
make[3]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Linux/ALSA/alsa-utils-1.0.12rc2/alsaconf'
test -z "/usr/sbin" || mkdir -p -- "/usr/sbin"
 /usr/bin/install -c 'alsaconf' '/usr/sbin/alsaconf'
 /usr/bin/install -c -m 644 alsaconf.8 /usr/man/man8/alsaconf.8
 /usr/bin/install -c -m 644 alsaconf.fr.8 /usr/man/fr/man8/alsaconf.8
make[3]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Linux/ALSA/alsa-utils-1.0.12rc2/alsaconf'
make[2]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Linux/ALSA/alsa-utils-1.0.12rc2/alsaconf'
make[1]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Linux/ALSA/alsa-utils-1.0.12rc2/alsaconf'
Making install in alsamixer
make[1]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Linux/ALSA/alsa-utils-1.0.12rc2/alsamixer'
make[2]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Linux/ALSA/alsa-utils-1.0.12rc2/alsamixer'
test -z "/usr/bin" || mkdir -p -- "/usr/bin"
  /usr/bin/install -c 'alsamixer' '/usr/bin/alsamixer'
test -z "/usr/man/man1" || mkdir -p -- "/usr/man/man1"
 /usr/bin/install -c -m 644 './alsamixer.1' '/usr/man/man1/alsamixer.1'
make[2]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Linux/ALSA/alsa-utils-1.0.12rc2/alsamixer'
make[1]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Linux/ALSA/alsa-utils-1.0.12rc2/alsamixer'
Making install in amidi
make[1]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Linux/ALSA/alsa-utils-1.0.12rc2/amidi'
make[2]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Linux/ALSA/alsa-utils-1.0.12rc2/amidi'
test -z "/usr/bin" || mkdir -p -- "/usr/bin"
  /usr/bin/install -c 'amidi' '/usr/bin/amidi'
test -z "/usr/man/man1" || mkdir -p -- "/usr/man/man1"
 /usr/bin/install -c -m 644 './amidi.1' '/usr/man/man1/amidi.1'
make[2]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Linux/ALSA/alsa-utils-1.0.12rc2/amidi'
make[1]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Linux/ALSA/alsa-utils-1.0.12rc2/amidi'
Making install in amixer
make[1]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Linux/ALSA/alsa-utils-1.0.12rc2/amixer'
gcc  -g -O2   -o amixer  amixer.o -lm -lasound -lm -ldl -lpthread
amixer.o
:
 
In
 
function
 
`
control_access
'
:

/
home
/
Mikey_A
/
Asennus_LINUX
/
Linux
/
ALSA
/
alsa
-
utils
-
1.0.12rc2
/
amixer
/
amixer.c
:
157
:
 
undefined
 
reference
 
to
 
`
snd_ctl_elem_info_is_tlv_readable
'

/
home
/
Mikey_A
/
Asennus_LINUX
/
Linux
/
ALSA
/
alsa
-
utils
-
1.0.12rc2
/
amixer
/
amixer.c
:
158
:
 
undefined
 
reference
 
to
 
`
snd_ctl_elem_info_is_tlv_writable
'

/
home
/
Mikey_A
/
Asennus_LINUX
/
Linux
/
ALSA
/
alsa
-
utils
-
1.0.12rc2
/
amixer
/
amixer.c
:
159
:
 
undefined
 
reference
 
to
 
`
snd_ctl_elem_info_is_tlv_commandable
'

amixer.o
:
 
In
 
function
 
`
show_control
'
:

/
home
/
Mikey_A
/
Asennus_LINUX
/
Linux
/
ALSA
/
alsa
-
utils
-
1.0.12rc2
/
amixer
/
amixer.c
:
539
:
 
undefined
 
reference
 
to
 
`
snd_ctl_elem_info_is_tlv_readable
'

/
home
/
Mikey_A
/
Asennus_LINUX
/
Linux
/
ALSA
/
alsa
-
utils
-
1.0.12rc2
/
amixer
/
amixer.c
:
542
:
 
undefined
 
reference
 
to
 
`
snd_hctl_elem_tlv_read
'

collect2: 
ld returned 1 exit status

make[1]: 
*** [amixer] Error 1

make[1]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Linux/ALSA/alsa-utils-1.0.12rc2/amixer'
make: 
*** [install-recursive] Error 1

----------------------------------------------------------------------
 Raymond - 08-05-06 15:24 
----------------------------------------------------------------------
TLV is a new feature in alsa-lib 1.0.12rc2.

This means the alsa-lib (1.0.12rc2) is installed to a wrong location, when
you compile alsa-utils-1.0.12rc2, it still find the old version of
alsa-lib

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-05-06 09:46 Mikey84        New Issue                                    
08-05-06 10:10 Raymond        Note Added: 0011423                          
08-05-06 14:04 Mikey84        Note Added: 0011430                          
08-05-06 14:33 jcdutton       Note Added: 0011433                          
08-05-06 14:33 jcdutton       Status                   new => feedback     
08-05-06 14:44 Mikey84        Note Added: 0011434                          
08-05-06 15:24 Raymond        Note Added: 0011437                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
