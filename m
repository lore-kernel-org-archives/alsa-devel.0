From: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc5-mm1
Date: Wed, 25 May 2005 20:41:07 -0700
Message-ID: <20050525204107.722504bd.akpm@osdl.org>
References: <20050525134933.5c22234a.akpm@osdl.org>
	<200505252243.21092.tomlins@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261170AbVEZDmP@vger.kernel.org>
In-Reply-To: <200505252243.21092.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ed Tomlinson <tomlins@cam.org>
Cc: linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


(Added alsa-devel to cc)

Ed Tomlinson <tomlins@cam.org> wrote:
>
> On Wednesday 25 May 2005 16:49, you wrote:
> >=20
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.1=
2-rc5/2.6.12-rc5-mm1/
> >=20
> > - Added Oracle's clustering filesystem driver, via git-ocfs.
> >=20
> > =A0 =A0 OCFS2, a shared disk cluster file system. =A0See
> > =A0 =A0 Documentation/filesystems/ocfs2.txt Additionally a users gu=
ide is
> > =A0 =A0 available at:
> > =A0 =A0 http://oss.oracle.com/projects/ocfs2-tools/dist/documentati=
on/users_guide.txt
> >=20
> > - New Xtensa architecture: Tensilica Xtensa CPU series.
> >=20
> > - Added the Red Hat distributed lock manager for people to look at.
> >=20
> > - Various new git trees. =A0The remaining holdouts are:
>=20
> Got the following when I tried to use sound.  Anyone else see problem=
s in alsa land?
>=20
> May 25 21:17:38 grover kernel: [  131.322558] PGD 2ab13067 PUD 2ab1b0=
67 PMD 2a3f1067 PTE 0
> May 25 21:17:38 grover kernel: [  131.351464] CPU 0
> May 25 21:17:38 grover kernel: [  131.358041] Modules linked in: rade=
on nfsd exportfs lockd sunrpc sg parport_pc lp parport ipv6 sd_
> mod evdev mousedev tsdev usbhid usb_storage snd_intel8x0 snd_ac97_cod=
ec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore sn
> d_page_alloc ehci_hcd ohci_hcd eth1394 sata_nv libata forcedeth
>  ohci1394 powernow_k8 freq_table processor cpufreq_userspace w83627hf=
 eeprom i2c_sensor i2c_isa i2c_nforce2 i2c_core sr_mod sbp2 scs
> i_mod ieee1394 rtc unix
> May 25 21:17:38 grover kernel: [  131.487598] Pid: 5481, comm: artsd =
Not tainted 2.6.12-rc5-mm1
> May 25 21:17:38 grover kernel: [  131.506496] RIP: 0010:[__nosave_end=
+129759479/2131247104] <ffffffff8813b8f7>{:snd_pcm:snd_pcm_mmap
> _data_close+7}
> May 25 21:17:38 grover kernel: [  131.535142] RSP: 0018:ffff81002ab9d=
ee0  EFLAGS: 00010286
> May 25 21:17:38 grover kernel: [  131.553183] RAX: 00002aaaadb59000 R=
BX: ffff810029c64988 RCX: fffffffffffffff2
> May 25 21:17:38 grover kernel: [  131.576657] RDX: ffff810029c64988 R=
SI: ffff81002d672ce0 RDI: ffff81002b339f50
> May 25 21:17:38 grover kernel: [  131.600129] RBP: ffff81002b3051c0 R=
08: ffff810029c649a8 R09: ffff81002ab9dec8
> May 25 21:17:38 grover kernel: [  131.623602] R10: 0000000000000002 R=
11: 0000000000000206 R12: ffff81002b339f50
> May 25 21:17:38 grover kernel: [  131.647075] R13: ffff81002b339f50 R=
14: ffff81002e7f2a08 R15: 00002aaaadb67000
> May 25 21:17:38 grover kernel: [  131.670548] FS:  00002aaaad6d8f50(0=
000) GS:ffffffff80550840(0000) knlGS:0000000000000000
> May 25 21:17:38 grover kernel: [  131.697165] CS:  0010 DS: 0000 ES: =
0000 CR0: 0000000080050033
> May 25 21:17:38 grover kernel: [  131.716064] CR2: 00002aaaadb59098 C=
R3: 000000002aafd000 CR4: 00000000000006e0
> May 25 21:17:38 grover kernel: [  131.739537] Process artsd (pid: 548=
1, threadinfo ffff81002ab9c000, task ffff81002ada97f0)
> May 25 21:17:38 grover kernel: [  131.766439] Stack: ffffffff8016942d=
 0000000000000000 0000000000000000 ffff81002e7f2a00
> May 25 21:17:38 grover kernel: [  131.792174]        ffffffff8016a936=
 ffff81002d672df0 ffff81002d672e08 ffff81002d672df0
> May 25 21:17:38 grover kernel: [  131.818481]        ffff81002e7f2a00=
 0000000000560600
> May 25 21:17:38 grover kernel: [  131.835065] Call Trace:<ffffffff801=
6942d>{remove_vm_struct+125} <ffffffff8016a936>{do_munmap+550}
> May 25 21:17:38 grover kernel: [  131.864282]        <ffffffff8016b0f=
d>{sys_munmap+77} <ffffffff8010ead6>{system_call+126}
> May 25 21:17:38 grover kernel: [  131.890928]
> May 25 21:17:38 grover kernel: [  131.898387]
> May 25 21:17:38 grover kernel: [  131.898388] Code: 48 8b 80 98 00 00=
 00 ff 88 08 01 00 00 c3 66 66 66 90 66 66
>=20
> Hope this helps,
> Ed Tomlinson
