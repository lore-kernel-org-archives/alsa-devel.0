From: Joachim Falk <joachim.falk@gmx.de>
Subject: Some Patches for emu10k1
Date: Mon, 07 Jun 2004 23:14:20 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40C4DAAC.9040202@jfalk.easynet.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0491A05CB53FFF01B8F42144"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0491A05CB53FFF01B8F42144
Content-Type: multipart/mixed;
 boundary="------------080209040507060904060302"

This is a multi-part message in MIME format.
--------------080209040507060904060302
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Alsa-Devel List,

This are copies from 2 E-Mail messages I sent directly to
Jaroslav Kysela <perex@suse.cz>perex@suse.cz . I Have gotten
no reply so I assume I have been filtered out or have been
ignored because this is not the approved method of sending
patches. I hope sending patches to alsa-devel list is ok.
Following now the 2 patches for emu10k1.

-------- Original Message --------
Subject: Kernel OOPS in EMU10K1 Driver
Date: Mon, 31 May 2004 16:01:22 +0200
From: Joachim Falk <joachim@jfalk.easynet.de>
To: Jaroslav Kysela <perex@suse.cz>

Hey Jaroslav,

attached is patch to fix an kernel oops in "emusfx.c". The oops is
triggerable by executing following command:

#> lo10k1 --ctrl t-delta:1,t-cosx:1 -a sine.emu10k1.

Reason for the kernel oops is an out of bound condition on min/max of
the control value with regard to the size of the translation tables.

Additionally I have noticed that snd_emu10k1_verify_controls is used to
verify the controls passed from user mode. But the copy from user space
is discarded and later another copy from user space is done. This can
lead to race conditions where the user process changes the control after
the kernel has done a verify.

PS.: I have discroverd the oops while trying to get a better mixer for
my Soundblaster 5.1 . Any and all tips how to use your ld10k1 and lo10k1
tools will be greatly appreciated. At the moment I try to verify my
input and optput ports by outputing the sine.emu10k1 to various outputs
of the card.

MfG
Joachim Falk
------ End Original Message ------

-------- Original Message --------
Subject: And another fix this time for ld10k1
Date: Mon, 31 May 2004 20:15:44 +0200
From: Joachim Falk <joachim@jfalk.easynet.de>
To: Jaroslav Kysela <perex@suse.cz>

Hey Jaroslav,

attached is patch to fix accept_comm function for ld10k1.
Third parameter of accept syscall is inout.

MfG
Joachim Falk
------ End Original Message ------

The following is a question I asked on IRC channel
#creative at freenode.net but got no answer. Maybe someone
here is better equipped to answer my questions.

18:22 < joachim> Good evening to you all
18:24 < joachim> Well i am searching for good documentation about the
emu10k1 chip, is there something like a datasheet for this chip ?
18:24 < joachim> I haven't found one with google and searching on
creative.com was negative too
18:25 < joachim> Im especially interested in how the FX Busses work and
what the pcm send routing in the alsa mixer does
18:26 < joachim> The datasheet for the STA9708 AC97 Codec I have found
and it explains a lot of the mixer controls.
18:28 < joachim> I have found
http://people.freenet.de/kxdev/docs/original/emu10k1-overview.pdf and
http://people.freenet.de/kxdev/docs/original/fx8010-arch.pdf
18:28 < joachim> But there is still so much info missing here :-(

I am especcially interested what this emu10k1 registers do.

#define CPF			0x00		/* Current pitch and fraction register			*/
#define CPF_CURRENTPITCH_MASK	0xffff0000	/* Current pitch (linear,
0x4000 == unity pitch shift) 	*/
#define CPF_CURRENTPITCH	0x10100000
#define CPF_STEREO_MASK		0x00008000	/* 1 = Even channel interleave, odd
channel locked	*/
#define CPF_STOP_MASK		0x00004000	/* 1 = Current pitch forced to 0			*/
#define CPF_FRACADDRESS_MASK	0x00003fff	/* Linear fractional address of
the current channel	*/

#define PTRX			0x01		/* Pitch target and send A/B amounts register		*/
#define PTRX_PITCHTARGET_MASK	0xffff0000	/* Pitch target of specified
channel			*/
#define PTRX_PITCHTARGET	0x10100001
#define PTRX_FXSENDAMOUNT_A_MASK 0x0000ff00	/* Linear level of channel
output sent to FX send bus A	*/
#define PTRX_FXSENDAMOUNT_A	0x08080001
#define PTRX_FXSENDAMOUNT_B_MASK 0x000000ff	/* Linear level of channel
output sent to FX send bus B	*/
#define PTRX_FXSENDAMOUNT_B	0x08000001

#define CVCF			0x02		/* Current volume and filter cutoff register		*/
#define CVCF_CURRENTVOL_MASK	0xffff0000	/* Current linear volume of
specified channel		*/
#define CVCF_CURRENTVOL		0x10100002
#define CVCF_CURRENTFILTER_MASK	0x0000ffff	/* Current filter cutoff
frequency of specified channel	*/
#define CVCF_CURRENTFILTER	0x10000002

#define VTFT			0x03		/* Volume target and filter cutoff target register	*/
#define VTFT_VOLUMETARGET_MASK	0xffff0000	/* Volume target of
specified channel			*/
#define VTFT_VOLUMETARGET	0x10100003
#define VTFT_FILTERTARGET_MASK	0x0000ffff	/* Filter cutoff target of
specified channel		*/
#define VTFT_FILTERTARGET	0x10000003

#define PSST			0x06		/* Send C amount and loop start address register	*/
#define PSST_FXSENDAMOUNT_C_MASK 0xff000000	/* Linear level of channel
output sent to FX send bus C	*/

#define PSST_FXSENDAMOUNT_C	0x08180006

#define PSST_LOOPSTARTADDR_MASK	0x00ffffff	/* Loop start address of the
specified channel		*/
#define PSST_LOOPSTARTADDR	0x18000006

#define DSL			0x07		/* Send D amount and loop start address register	*/
#define DSL_FXSENDAMOUNT_D_MASK	0xff000000	/* Linear level of channel
output sent to FX send bus D	*/

#define DSL_FXSENDAMOUNT_D	0x08180007

#define DSL_LOOPENDADDR_MASK	0x00ffffff	/* Loop end address of the
specified channel		*/
#define DSL_LOOPENDADDR		0x18000007
#define FXRT_CHANNELA		0x000f0000	/* Effects send bus number for
channel's effects send A	*/
#define FXRT_CHANNELB		0x00f00000	/* Effects send bus number for
channel's effects send B	*/
#define FXRT_CHANNELC		0x0f000000	/* Effects send bus number for
channel's effects send C	*/
#define FXRT_CHANNELD		0xf0000000	/* Effects send bus number for
channel's effects send D	*/

I assume they are per emu10k1 channel (there are 64 of them ?).
I think I have understood that for each PCM output stream one of this
channels is used (For mono 1 for stereo 2). This channels can also be
used for wavetable synthesis.

And than this magic send routing decides in which FX buses the processed
stream will be targeted. Maximal 4 FX buses chan be selected per channel
? Send bus A,B,C, and D. Is this sendbus the same for each channel or
can it be configured for each channel seperatly. Is it fixed or can for
all channels globally be configured what FX bus sendbus A,B,C and D is ?

In the emu10k1 dsp I can than read from this FX buses and do effects on
them, outputs can than be written to output registsers of the dsp.
But some FX buses seam to be connected to outputs even if there is no
code in the dsp. Is that hardcoded in hardware or configurable and if
yes where ?

-- 
Joachim Falk <Joachim.Falk@gmx.de>

You can always tell a really good idea by the enemies it makes.
    --programmers' axiom


--------------080209040507060904060302
Content-Type: text/x-patch;
 name="ld10k1-accept.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ld10k1-accept.patch"

diff -urN --exclude '*~' --exclude '*.o' --exclude '*.swp' --exclude 'config.*' --exclude .deps --exclude 'Makefile*' --exclude 'stamp*' --exclude tags --exclude dl10k1 --exclude ld10k1 --exclude lo10k1 ld10k1-0.1.3p1.orig/comm.c ld10k1-0.1.3p1/comm.c
--- ld10k1-0.1.3p1.orig/comm.c	2004-03-13 15:55:07.000000000 +0100
+++ ld10k1-0.1.3p1/comm.c	2004-05-31 18:09:25.000000000 +0200
@@ -127,7 +127,7 @@
 int accept_comm(int conn_num)
 {
 	struct sockaddr addr;
-	socklen_t addr_len;
+	socklen_t addr_len = sizeof(addr);
 	int sock;
 	
 	sock = accept(conn_num, &addr, &addr_len);


--------------080209040507060904060302
Content-Type: text/x-patch;
 name="emu10k1-oops.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="emu10k1-oops.patch"

diff -urN --exclude '*~' --exclude '*.o' --exclude '*.ko' --exclude tags sound/pci/emu10k1.orig/emufx.c sound/pci/emu10k1/emufx.c
--- sound/pci/emu10k1.orig/emufx.c	2004-05-29 22:04:44.000000000 +0200
+++ sound/pci/emu10k1/emufx.c	2004-05-30 18:27:11.000000000 +0200
@@ -980,9 +980,29 @@
 			nctl.value[j] = ~gctl.value[j];	/* inverted, we want to write new value in gpr_ctl_put() */
 			val->value.integer.value[j] = gctl.value[j];
 		}
-		nctl.min = gctl.min;
-		nctl.max = gctl.max;
 		nctl.translation = gctl.translation;
+		switch (nctl.translation) {
+		case EMU10K1_GPR_TRANSLATION_TABLE100:
+			nctl.min = max(gctl.min, (unsigned int) 0);
+			nctl.max = min(gctl.max,sizeof(db_table)/sizeof(db_table[0])-1);
+			break;
+		case EMU10K1_GPR_TRANSLATION_BASS:
+			nctl.min = max(gctl.min, (unsigned int) 0);
+			nctl.max = min(gctl.max,sizeof(bass_table)/sizeof(bass_table[0])-1);
+			break;
+		case EMU10K1_GPR_TRANSLATION_TREBLE:
+			nctl.min = max(gctl.min, (unsigned int) 0);
+			nctl.max = min(gctl.max,sizeof(treble_table)/sizeof(treble_table[0])-1);
+			break;
+		case EMU10K1_GPR_TRANSLATION_ONOFF:
+			nctl.min = max(gctl.min, (unsigned int) 0);
+			nctl.max = min(gctl.max,sizeof(onoff_table)/sizeof(onoff_table[0])-1);
+			break;
+		default:
+			nctl.min = gctl.min;
+			nctl.max = gctl.max;
+			break;
+		}
 		if (ctl == NULL) {
 			ctl = (snd_emu10k1_fx8010_ctl_t *)kmalloc(sizeof(*ctl), GFP_KERNEL);
 			if (ctl == NULL)


--------------080209040507060904060302
Content-Type: text/plain;
 name="oops.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops.txt"

Unable to handle kernel paging request at virtual address f09c0de4
 printing eip:
e1dcf947
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<e1dcf947>]    Not tainted
EFLAGS: 00010093   (2.6.6)
EIP is at snd_emu10k1_gpr_ctl_put+0xe7/0x1e0 [snd_emu10k1]
eax: 00000001   ebx: db82dc5c   ecx: 03afa691   edx: 00000000
esi: c6584460   edi: 00000001   ebp: d6dcbd04   esp: d6dcbcd4
ds: 007b   es: 007b   ss: 0068
Process ld10k1 (pid: 5544, threadinfo=d6dca000 task=d6acb1f0)
Stack: 00000000 00000000 00000000 00000000 00000000 00000001 00000000 00000286
       ddb8c000 dcd4e278 c6584460 db82dd1c d6dcbf20 e1dd0e2e c6584460 dcd4e278
       000000f4 db82dc5c 0806d3c4 00000001 00000002 00000000 00000000 d6dcbe24
Call Trace:
 [<e1dd0e2e>] snd_emu10k1_add_controls+0x1fe/0x2e0 [snd_emu10k1]
 [<e1dcf7c0>] snd_emu10k1_gpr_ctl_info+0x0/0x50 [snd_emu10k1]
 [<e1dcf810>] snd_emu10k1_gpr_ctl_get+0x0/0x50 [snd_emu10k1]
 [<e1dcf860>] snd_emu10k1_gpr_ctl_put+0x0/0x1e0 [snd_emu10k1]
 [<e1dd1212>] snd_emu10k1_icode_poke+0xc2/0x140 [snd_emu10k1]
 [<e1dd6580>] snd_emu10k1_fx8010_ioctl+0x0/0x5e0 [snd_emu10k1]
 [<e1dd6974>] snd_emu10k1_fx8010_ioctl+0x3f4/0x5e0 [snd_emu10k1]
 [<e1dd6580>] snd_emu10k1_fx8010_ioctl+0x0/0x5e0 [snd_emu10k1]
 [<e1cc5697>] snd_hwdep_ioctl+0x47/0xd0 [snd_hwdep]
 [<c0162722>] sys_ioctl+0x112/0x2b0
 [<c0105d3f>] syscall_call+0x7/0xb

Code: 8b 04 8d a0 73 dd e1 89 44 24 0c eb 9c 8b 43 0c be cd cc cc
 <6>note: ld10k1[5544] exited with preempt_count 2


--------------080209040507060904060302--

--------------enig0491A05CB53FFF01B8F42144
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAxNqzKwZcgs55jUMRAgQlAJ4+3Rxy5GXrCkBxkjO63esuFuwsuQCeKG4e
n7DtNDcfVwLYZj36Eh4C4xw=
=HqDq
-----END PGP SIGNATURE-----

--------------enig0491A05CB53FFF01B8F42144--


-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
