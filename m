From: p z oooo <pzad@pobox.sk>
Subject: Not important oops
Date: Wed, 21 Jan 2004 13:55:53 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200401211255.i0LCtroL006857@www1.pobox.sk>
Reply-To: p z oooo <pzad@pobox.sk>
Mime-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
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

Hi,

When I remove control through hwdep layer on emu10k1=20
driver when in use by oss emulation I got oops.=20
This is because oss emulation holds pointer to this control.
Is there any api to disable an then enable oss emulation or=20
only proc interface ???

Jan 20 20:53:52 localhost kernel: Unable to handle kernel NULL=20
pointer dereference at virtual address 000000b0
Jan 20 20:53:52 localhost kernel:  printing eip:
Jan 20 20:53:52 localhost kernel: e8edc94b
Jan 20 20:53:52 localhost kernel: *pde =3D 0567b067
Jan 20 20:53:52 localhost kernel: *pte =3D 00000000
Jan 20 20:53:52 localhost kernel: Oops: 0000
Jan 20 20:53:52 localhost kernel: snd-pcm-oss snd-mixer-oss evdev=20
tuner saa7134 video-buf v4l2-common v4l1-compat ir-common videodev=20
w83781d i2c-isa eeprom i2c-proc i2c-viapro i2c-dev i2c-core
Jan 20 20:53:52 localhost kernel: CPU:    0
Jan 20 20:53:52 localhost kernel: EIP:    0060:[<e8edc94b>]   =20
Tainted: P
Jan 20 20:53:52 localhost kernel: EFLAGS: 00010286
Jan 20 20:53:52 localhost kernel:
Jan 20 20:53:52 localhost kernel: EIP is at snd_emu10k1_gpr_ctl_info=20
[snd-emu10k1] 0xb (2.4.22-1.2115.nptlcustom)
Jan 20 20:53:52 localhost kernel: eax: daf33cc0   ebx: daf33cc0  =20
ecx: daa8ce00   edx: 00000000
Jan 20 20:53:52 localhost kernel: esi: daa8ce00   edi: c5ff8000  =20
ebp: d4795f60   esp: d4795ef4
Jan 20 20:53:52 localhost kernel: ds: 0068   es: 0068   ss: 0068
Jan 20 20:53:52 localhost kernel: Process xine (pid: 4800,=20
stackpage=3Dd4795000)
Jan 20 20:53:52 localhost kernel: Stack: e9040ded daf33cc0 daa8ce00=20
00000000 00000000 d4795f64 dd93a0e4 dd2bf400
Jan 20 20:53:52 localhost kernel:        dadb7000 dadb714c c9a9d200=20
e90411d7 c9a9d200 dd93a0e4 daf33cc0 d4795f60
Jan 20 20:53:52 localhost kernel:        d4795f64 dffef300 dd93a0e4=20
c9a9d200 c52ae540 c9a9d200 e90406cf c9a9d200
Jan 20 20:53:52 localhost kernel: Call Trace:   [<e9040ded>]=20
snd_mixer_oss_get_volume1_vol [snd-mixer-oss] 0x6d (0xd4795ef4)
Jan 20 20:53:52 localhost kernel: [<e90411d7>]=20
snd_mixer_oss_get_volume1 [snd-mixer-oss] 0x207 (0xd4795f20)
Jan 20 20:53:52 localhost kernel: [<e90406cf>]=20
snd_mixer_oss_get_volume [snd-mixer-oss] 0x9f (0xd4795f4c)
Jan 20 20:53:52 localhost kernel: [<e904086d>] snd_mixer_oss_ioctl1=20
[snd-mixer-oss] 0xcd (0xd4795f70)
Jan 20 20:53:52 localhost kernel: [<e9040b30>] snd_mixer_oss_ioctl=20
[snd-mixer-oss] 0x0 (0xd4795f90)
Jan 20 20:53:52 localhost kernel: [<c015570c>] sys_ioctl [kernel]=20
0xbc (0xd4795f94)
Jan 20 20:53:52 localhost kernel: [<c014561a>] sys_open [kernel] 0x8a=20
(0xd4795fa8)
Jan 20 20:53:52 localhost kernel: [<c01099df>] system_call [kernel]=20
0x33 (0xd4795fc0)
Jan 20 20:53:52 localhost kernel:
Jan 20 20:53:52 localhost kernel:
Jan 20 20:53:52 localhost kernel: Code: 8b 82 b0 00 00 00 85 c0 75 09=20
83 ba b4 00 00 00 01 74 22 c7=20


=0A____________________________________=0Ahttp://www.logofun.pobox.sk - uro=
bte radost svojmu telefonu=0A


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
