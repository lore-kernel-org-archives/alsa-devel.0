From: "Paul Berry" <pnberry@gustavus.ak.us>
Subject: Re: configure error with alsa-driver-0.9.7a
Date: Fri, 10 Oct 2003 01:54:25 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <000501c38f14$beaafa60$7ff8e589@farnorth>
References: <000901c38e45$961d5c20$91f8e589@farnorth> <s5hu16i90cg.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thank you for the patch Takashi and here is what came of it.

I'm kinda green at this so this is what I did with the patch. I copied it to
the alsa-driver-0.9.7a/acore/ folder and ran:
patch -b --verbose memalloc.c <memalloc-nopci.dif

everything seemed to go fine so I restarted the make process and here is the
tail of what followed (the memalloc.o file was created as well):

<snip>----------------------------------------------------------------------
---------
/lib/modules/2.2.20alsa/build/include/linux/pci.h:1518:20: warning: pasting
would not give a valid preprocessing token
In file included from memory_wrapper.c:18:
pci_compat_22.c: In function `snd_pci_compat_match_device':
pci_compat_22.c:83: dereferencing pointer to incomplete type
pci_compat_22.c:83: dereferencing pointer to incomplete type
pci_compat_22.c:83: dereferencing pointer to incomplete type
pci_compat_22.c:84: dereferencing pointer to incomplete type
pci_compat_22.c:84: `PCI_ANY_ID' undeclared (first use in this function)
pci_compat_22.c:84: (Each undeclared identifier is reported only once
pci_compat_22.c:84: for each function it appears in.)
pci_compat_22.c:84: dereferencing pointer to incomplete type
pci_compat_22.c:85: dereferencing pointer to incomplete type
pci_compat_22.c:85: dereferencing pointer to incomplete type
pci_compat_22.c:86: dereferencing pointer to incomplete type
pci_compat_22.c:86: dereferencing pointer to incomplete type
pci_compat_22.c:87: dereferencing pointer to incomplete type
pci_compat_22.c:87: dereferencing pointer to incomplete type
pci_compat_22.c:88: dereferencing pointer to incomplete type
pci_compat_22.c:88: dereferencing pointer to incomplete type
pci_compat_22.c:90: increment of pointer to unknown structure
pci_compat_22.c:90: arithmetic on pointer to an incomplete type
pci_compat_22.c: In function `snd_pci_announce_device':
pci_compat_22.c:100: dereferencing pointer to incomplete type
pci_compat_22.c:101: dereferencing pointer to incomplete type
pci_compat_22.c:117: dereferencing pointer to incomplete type
pci_compat_22.c: In function `snd_pci_compat_register_driver':
pci_compat_22.c:129: dereferencing pointer to incomplete type
pci_compat_22.c:130: warning: implicit declaration of function
`pci_for_each_dev'
pci_compat_22.c:130: parse error before `{'
pci_compat_22.c:132: `map' undeclared (first use in this function)
pci_compat_22.c:126: warning: `dev' might be used uninitialized in this
function
pci_compat_22.c:134: warning: control reaches end of non-void function
pci_compat_22.c: At top level:
pci_compat_22.c:135: parse error before `return'
pci_compat_22.c: In function `snd_pci_compat_unregister_driver':
pci_compat_22.c:142: dereferencing pointer to incomplete type
pci_compat_22.c:143: parse error before `{'
pci_compat_22.c:145: `map' undeclared (first use in this function)
pci_compat_22.c:146: dereferencing pointer to incomplete type
pci_compat_22.c:147: dereferencing pointer to incomplete type
pci_compat_22.c: At top level:
pci_compat_22.c:152: parse error before `}'
pci_compat_22.c: In function `snd_pci_compat_set_power_state':
pci_compat_22.c:221: warning: implicit declaration of function
`snd_pci_compat_find_capability'
make[1]: *** [memory_wrapper.o] Error 1
make[1]: Leaving directory `/usr/local/src/alsa-driver-0.9.7a/acore'
make: *** [compile] Error 1
[root@FarNorth alsa-driver-0.9.7a]#

If this is an obscure bug that only occurs in my case then I don't want to
waste your time tracking it down as the old drivers do work, but if all this
is good for the cause then I'm game to see it through.

Thank you very much for your efforts.

Sincerely,
Paul

----- Original Message -----
From: "Takashi Iwai" <tiwai@suse.de>
To: "Paul Berry" <pnberry@gustavus.ak.us>
Cc: <alsa-devel@lists.sourceforge.net>
Sent: Thursday, October 09, 2003 2:22 AM
Subject: Re: [Alsa-devel] configure error with alsa-driver-0.9.7a


> please try the patch attached below.  (it's already on cvs.)
>
>
> ciao,
>
> Takashi
>



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
