From: Vincent Bernat <bernat@free.fr>
Subject: Re: xmms segfaulting on 2.4.18 and 2.4.19-pre2-ac2 + oops
Date: Thu, 07 Mar 2002 00:28:02 +0100
Message-ID: <m3lmd56zul.fsf@neo.loria>
References: <19185.1015449992@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Received: from postfix3-2.free.fr (postfix3-2.free.fr [213.228.0.169])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id AAA27037
	for <alsa-devel@alsa-project.org>; Thu, 7 Mar 2002 00:28:39 +0100
In-Reply-To: <19185.1015449992@ocs3.intra.ocs.com.au> (Keith Owens's message
 of "Thu, 07 Mar 2002 08:26:32 +1100")
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

OoO En cette soir=E9e bien amorc=E9e du mercredi 06 mars 2002, vers 22:26=
,
Keith Owens <kaos@ocs.com.au> disait:

> The oops is not in 3c59x.  You are letting klogd convert the oops and
> klogd has been broken for years.  <rant>Why do distributors insist on
> shipping such broken code?</rant>.  Always run klogd with the -x flag
> to keep its sticky fingers off the oops then you can get clean data for
> ksymoops to decode.

You are right, I have used the output of dmesg instead and here is
what I get :

ksymoops 2.4.4 on i686 2.4.19-pre2-ac2-xfs-shawn9-preempt.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-pre2-ac2-xfs-shawn9-preempt/ (default)
     -m /usr/src/linux/System.map (default)

Reading Oops report from the terminal
Unable to handle kernel paging request at virtual address d8d7e000
d91a3730
*pde =3D 17b1f067
Oops: 0000
CPU:    0
EIP:    0010:[<d91a3730>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210202
eax: 00000001   ebx: 00000003   ecx: 000007ff   edx: 00000000
esi: 00000000   edi: d8d7bfa6   ebp: d8d7dffe   esp: c877de90
ds: 0018   es: 0018   ss: 0018
Process xmms (pid: 3910, stackpage=3Dc877d000)
Stack: d91a3840 d91a3730 cb4a4150 cb4a4130 00000000 00000004 00000004 000=
00001=20
       00000000 00000c29 000003ec 00000400 cb4a40c0 cd94cec0 d91a3a8a cb4=
a40c0=20
       c4dc8340 c4dc8380 00000400 000003ec cb4a40c0 00000400 cb4a40c0 000=
00400=20
Call Trace: [<d91a3840>] [<d91a3730>] [<d91a3a8a>] [<d91a0914>] [<d919ce9=
1>]=20
   [<d919d013>] [<d919ed23>] [<c0134ad5>] [<c0106f2b>]=20
Code: 8b 75 00 e9 87 00 00 00 8b 75 00 81 f6 00 80 00 00 eb 7c 8b=20

>>EIP; d91a3730 <[snd-pcm-oss]resample_shrink+180/390>   <=3D=3D=3D=3D=3D
Trace; d91a3840 <[snd-pcm-oss]resample_shrink+290/390>
Trace; d91a3730 <[snd-pcm-oss]resample_shrink+180/390>
Trace; d91a3a8a <[snd-pcm-oss]rate_transfer+2a/40>
Trace; d91a0914 <[snd-pcm-oss]snd_pcm_plug_write_transfer+94/d0>
Trace; d919ce91 <[snd-pcm-oss]snd_pcm_oss_write2+81/d0>
Trace; d919d013 <[snd-pcm-oss]snd_pcm_oss_write1+133/160>
Trace; d919ed23 <[snd-pcm-oss]snd_pcm_oss_write+33/50>
Trace; c0134ad5 <sys_write+95/120>
Trace; c0106f2b <system_call+33/38>
Code;  d91a3730 <[snd-pcm-oss]resample_shrink+180/390>
00000000 <_EIP>:
Code;  d91a3730 <[snd-pcm-oss]resample_shrink+180/390>   <=3D=3D=3D=3D=3D
   0:   8b 75 00                  mov    0x0(%ebp),%esi   <=3D=3D=3D=3D=3D
Code;  d91a3733 <[snd-pcm-oss]resample_shrink+183/390>
   3:   e9 87 00 00 00            jmp    8f <_EIP+0x8f> d91a37bf <[snd-pc=
m-oss]resample_shrink+20f/390>
Code;  d91a3738 <[snd-pcm-oss]resample_shrink+188/390>
   8:   8b 75 00                  mov    0x0(%ebp),%esi
Code;  d91a373b <[snd-pcm-oss]resample_shrink+18b/390>
   b:   81 f6 00 80 00 00         xor    $0x8000,%esi
Code;  d91a3741 <[snd-pcm-oss]resample_shrink+191/390>
  11:   eb 7c                     jmp    8f <_EIP+0x8f> d91a37bf <[snd-pc=
m-oss]resample_shrink+20f/390>
Code;  d91a3743 <[snd-pcm-oss]resample_shrink+193/390>
  13:   8b 00                     mov    (%eax),%eax

So, a problem with Alsa ? I use Alsa 0.9.0b12, compiled with no option
(plain ./configure).

snd-pcm-oss            36192   1 (autoclean)
snd-mixer-oss           8912   0 (autoclean) [snd-pcm-oss]
joydev                  5808   1 (autoclean)
ns558                   1360   0 (autoclean) (unused)
analog                  7536   0 (autoclean) (unused)
input                   3200   0 (autoclean) [joydev analog]
gameport                1376   0 (autoclean) [ns558 analog]
tuner                   8512   1 (autoclean)
tvaudio                11232   0 (autoclean) (unused)
bttv                   65584   0 (autoclean)
i2c-algo-bit            6912   1 (autoclean) [bttv]
i2c-core               12704   0 (autoclean) [tuner tvaudio bttv i2c-algo=
-bit]
videodev                4992   2 (autoclean) [bttv]
usb-uhci               22144   0 (unused)
printer                 5632   0
usbcore                58016   0 [usb-uhci printer]
snd-seq-midi            3200   0 (unused)
snd-seq-midi-event      2976   0 [snd-seq-midi]
snd-seq                36304   0 [snd-seq-midi snd-seq-midi-event]
snd-ens1370             8352   1 (autoclean)
snd-pcm                49184   0 (autoclean) [snd-pcm-oss snd-ens1370]
snd-timer              10096   0 (autoclean) [snd-seq snd-pcm]
snd-rawmidi            12256   0 (autoclean) [snd-seq-midi snd-ens1370]
snd-seq-device          3856   0 (autoclean) [snd-seq-midi snd-seq snd-ra=
wmidi]
snd-ak4531-codec        4896   0 (autoclean) [snd-ens1370]
snd                    24992   0 [snd-pcm-oss snd-mixer-oss snd-seq-midi =
snd-seq-midi-event snd-seq snd-ens1370 snd-pcm snd-timer snd-rawmidi snd-=
seq-device snd-ak4531-codec]
soundcore               3536   6 [snd]
ide-scsi                7840   0 (autoclean)
sr_mod                 13696   0 (autoclean)
scsi_mod               64048   2 (autoclean) [ide-scsi sr_mod]
cdrom                  27264   0 (autoclean) [sr_mod]
smbfs                  32848   1 (autoclean)
nfsd                   67648   4 (autoclean)
lockd                  48016   1 (autoclean) [nfsd]
sunrpc                 63264   1 (autoclean) [nfsd lockd]
3c59x                  25120   1 (autoclean)
rtc                     6496   0 (autoclean)

I have updated xmms to 1.2.7 too and I use the OSS plugin.
I have crossposted to alsa mailing lists and it seems that it is a
known problem. Feel free to drop lkml from the followup.
--=20
MY MOM IS NOT DATING JERRY SEINFELD
MY MOM IS NOT DATING JERRY SEINFELD
MY MOM IS NOT DATING JERRY SEINFELD
-+- Bart Simpson on chalkboard in episode AABF06

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
