From: Jeremy Hall <jhall@maoz.com>
Subject: lock with pcm_multi for two rme9652 cards
Date: Sun, 13 Apr 2003 11:05:32 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200304131505.h3DF5XsR008673@sith.maoz.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=ELM744821014-2088-25_
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


--ELM744821014-2088-25_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello,

For years I have thought my machine was plagued with heating issues, and 
many other reasons for my spurious lockups, indeed I had many different 
lockups manifesting themselves, but I now have proof for my madness.

It appears a lockup can somehow be caused if RME9652 both try to stop at 
once.  Attached is output from gdb that should hopefully at least start to 
point us down the right track to resolving this long-standing bug.  THe 
kernel is still in this state should a developer desire more information, 
say from another thread.

_J

--ELM744821014-2088-25_
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: attachment; filename=gdb-rme-crash.script
Content-Description: gdb-rme-crash.script
Content-Transfer-Encoding: quoted-printable

Script started on Sun Apr 13 10:30:46 2003
Rainbow:/usr/src/linux-2.5.67 # gdb vmlinux
GNU gdb 5.3
Copyright 2002 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain condition=
s.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i686-pc-linux-gnu"...
gdb_interrupt (irq=3D4, dev_id=3D0x0, regs=3D0xc04f5ddc)
    at arch/i386/lib/kgdb_serial.c:194
194	            continue ;
warning: shared library handler failed to enable breakpoint
(gdb) bt
#0  gdb_interrupt (irq=3D4, dev_id=3D0x0, regs=3D0xc04f5ddc)
    at arch/i386/lib/kgdb_serial.c:194
#1  0xc010cd68 in handle_IRQ_event (irq=3D4, regs=3D0xc04f5ddc, action=3D0x=
dffee640)
    at arch/i386/kernel/irq.c:214
#2  0xc010cfd1 in do_IRQ (regs=3D
      {ebx =3D -1068548096, ecx =3D -615541760, edx =3D 0, esi =3D -6155395=
44, edi =3D -615517184, ebp =3D -1068540392, eax =3D -1068548096, xds =3D 1=
23, xes =3D 123, orig_eax =3D -252, eip =3D -1072561615, xcs =3D 96, eflags=
 =3D 646, esp =3D -1068548096, xss =3D -1049704000}) at arch/i386/kernel/ir=
q.c:395
#3  0xc010b60c in common_interrupt () at net/8021q/vlan.c:130
#4  0xc0332ca0 in snd_pcm_stop (substream=3D0xc16ec900, state=3D4)
    at sound/core/pcm_native.c:723
#5  0xc0338030 in snd_pcm_update_hw_ptr_interrupt (substream=3D0xc16ec900)
    at sound/core/pcm_lib.c:179
#6  0xc033b88e in snd_pcm_period_elapsed (substream=3D0xc16ec900)
    at sound/core/pcm_lib.c:2016
#7  0xc0340fca in snd_rme9652_interrupt (irq=3D10, dev_id=3D0xc1679dc8,=20
    regs=3D0xc04f5ed4) at sound/pci/rme9652/rme9652.c:1965
#8  0xc010cd68 in handle_IRQ_event (irq=3D10, regs=3D0xc04f5ed4, action=3D0=
xc1700be0)
    at arch/i386/kernel/irq.c:214
#9  0xc010cfd1 in do_IRQ (regs=3D
      {ebx =3D -615539712, ecx =3D 1, edx =3D -615546880, esi =3D -10497040=
00, edi =3D 12, ebp =3D -1068540124, eax =3D -1049704000, xds =3D 123, xes =
=3D 123, orig_eax =3D -246, eip =3D -1070367156, xcs =3D 96, eflags =3D 646=
, esp =3D -615539712, xss =3D -1049704000})
    at arch/i386/kernel/irq.c:395
#10 0xc010b60c in common_interrupt () at net/8021q/vlan.c:130
#11 0xc033b88e in snd_pcm_period_elapsed (substream=3D0xc16ec9c0)
    at sound/core/pcm_lib.c:2016
#12 0xc0340faf in snd_rme9652_interrupt (irq=3D12, dev_id=3D0xc17171c8,=20
    regs=3D0xc04f5f94) at sound/pci/rme9652/rme9652.c:1961
#13 0xc010cd68 in handle_IRQ_event (irq=3D12, regs=3D0xc04f5f94, action=3D0=
xc1700340)
    at arch/i386/kernel/irq.c:214
#14 0xc010cfd1 in do_IRQ (regs=3D
      {ebx =3D -1068548096, ecx =3D -1068548096, edx =3D -1068548096, esi =
=3D -1072657920, edi =3D -1072672768, ebp =3D -1068539960, eax =3D 0, xds =
=3D 123, xes =3D 123, orig_eax =3D -244, eip =3D -1072657871, xcs =3D 96, e=
flags =3D 582, esp =3D -1068539944, xss =3D -1072657697}) at arch/i386/kern=
el/irq.c:395
#15 0xc010b60c in common_interrupt () at net/8021q/vlan.c:130
#16 0xc0108adf in cpu_idle () at arch/i386/kernel/process.c:146
#17 0xc0105065 in rest_init () at init/main.c:371
#18 0xc04f68a5 in start_kernel () at init/main.c:463
(gdb) up
#1  0xc010cd68 in handle_IRQ_event (irq=3D4, regs=3D0xc04f5ddc, action=3D0x=
dffee640)
    at arch/i386/kernel/irq.c:214
214				continue;
(gdb) print *action
$1 =3D {handler =3D 0xc024fd40 <gdb_interrupt>, flags =3D 536870912, mask =
=3D 0,=20
  name =3D 0xc03fff98 "KGDB-stub", dev_id =3D 0x0, next =3D 0x0}
(gdb) up
#2  0xc010cfd1 in do_IRQ (regs=3D
      {ebx =3D -1068548096, ecx =3D -615541760, edx =3D 0, esi =3D -6155395=
44, edi =3D -615517184, ebp =3D -1068540392, eax =3D -1068548096, xds =3D 1=
23, xes =3D 123, orig_eax =3D -252, eip =3D -1072561615, xcs =3D 96, eflags=
 =3D 646, esp =3D -1068548096, xss =3D -1049704000}) at arch/i386/kernel/ir=
q.c:395
395		retval =3D 2 + local_enabled;
(gdb) print *eip
No symbol "eip" in current context.
(gdb) print xes
No symbol "xes" in current context.
(gdb) up
#3  0xc010b60c in common_interrupt () at net/8021q/vlan.c:130
130		vlan_proc_cleanup();
(gdb) up
#4  0xc0332ca0 in snd_pcm_stop (substream=3D0xc16ec900, state=3D4)
    at sound/core/pcm_native.c:723
723		SND_PCM_ACTION(stop, substream, state);
(gdb) l
718	/**
719	 * snd_pcm_stop
720	 */
721	int snd_pcm_stop(snd_pcm_substream_t *substream, int state)
722	{
723		SND_PCM_ACTION(stop, substream, state);
724	}
725=09
726	static inline int snd_pcm_pre_pause(snd_pcm_substream_t *substream, int=
 push)
727	{
(gdb) print substream
$2 =3D (snd_pcm_substream_t *) 0xc16ec900
(gdb) print *substream
$3 =3D {pcm =3D 0xc16d8c00, pstr =3D 0xc16d8ca0, private_data =3D 0xc1679dc=
8,=20
  number =3D 0, name =3D "subdevice #0", '\0' <repeats 19 times>, stream =
=3D 0,=20
  buffer_bytes_max =3D 4294967295, dma_device =3D {type =3D 0, dev =3D {pci=
 =3D 0x0,=20
      flags =3D 0}, id =3D 0}, dma_buffer =3D {area =3D 0x0, addr =3D 0, by=
tes =3D 0,=20
    private_data =3D 0x0}, dma_max =3D 0, open_flag =3D 1, ops =3D 0xc04b12=
20,=20
  runtime =3D 0xdb4ff400, timer =3D 0xc16a9c00, timer_running =3D 0, timer_=
lock =3D {
    lock =3D 1}, next =3D 0x0, link_next =3D 0xc16ec840, link_prev =3D 0xc1=
6eca80,=20
  file =3D 0xdbab0ec0, ffile =3D 0xdb4f4bc0, proc_root =3D 0xc167c1c0,=20
  proc_info_entry =3D 0xc167c0c0, proc_hw_params_entry =3D 0xc1678ec0,=20
  proc_sw_params_entry =3D 0xc1678dc0, proc_status_entry =3D 0xc1678cc0,=20
  proc_prealloc_entry =3D 0x0}
(gdb) print *substream->pcm
$4 =3D {card =3D 0xc1679c00, device =3D 0, info_flags =3D 2097152, dev_clas=
s =3D 0,=20
  dev_subclass =3D 0, id =3D "RME Digi9652 (Rev 1.5)", '\0' <repeats 41 tim=
es>,=20
  name =3D "RME Digi9652 (Rev 1.5)", '\0' <repeats 57 times>, streams =3D {{
      stream =3D 0, pcm =3D 0xc16d8c00, substream_count =3D 1, substream_op=
ened =3D 1,=20
      substream =3D 0xc16ec900, files =3D 0xdbab0ec0, reg =3D 0xc04b0b40,=
=20
      proc_root =3D 0xc167c3c0, proc_info_entry =3D 0xc167c2c0}, {stream =
=3D 1,=20
      pcm =3D 0xc16d8c00, substream_count =3D 1, substream_opened =3D 1,=20
      substream =3D 0xc16ec840, files =3D 0xdbab0e40, reg =3D 0xc04b0b5c,=
=20
      proc_root =3D 0xc1678bc0, proc_info_entry =3D 0xc1678ac0}}, open_mute=
x =3D {
    count =3D {counter =3D 1}, sleepers =3D 0, wait =3D {lock =3D {lock =3D=
 1},=20
      task_list =3D {next =3D 0xc16d8cf4, prev =3D 0xc16d8cf4}}}, open_wait=
 =3D {
    lock =3D {lock =3D 1}, task_list =3D {next =3D 0xc16d8d00, prev =3D 0xc=
16d8d00}},=20
  private_data =3D 0xc1679dc8, private_free =3D 0}
(gdb) print *substream->pcm->card
$5 =3D {number =3D 1, id =3D "15_1", '\0' <repeats 11 times>,=20
  driver =3D "RME9652\0\0\0\0\0\0\0\0",=20
  shortname =3D "RME Digi9652 (Rev 1.5)\0\0\0\0\0\0\0\0\0",=20
  longname =3D "RME Digi9652 (Rev 1.5) at 0xf6000000, irq 10", '\0' <repeat=
s 35 times>, mixername =3D '\0' <repeats 79 times>,=20
  components =3D '\0' <repeats 79 times>, module =3D 0x0,=20
  private_data =3D 0xc1679dc8,=20
  private_free =3D 0xc0342020 <snd_rme9652_card_free>, devices =3D {
    next =3D 0xc167da80, prev =3D 0xc167db80}, last_numid =3D 17, controls_=
rwsem =3D {
    count =3D 0, wait_lock =3D {lock =3D 1}, wait_list =3D {next =3D 0xc167=
9d54,=20
      prev =3D 0xc1679d54}}, ctl_files_rwlock =3D {lock =3D 16777216},=20
  controls_count =3D 17, controls =3D {next =3D 0xc16784c0, prev =3D 0xc167=
7bc0},=20
  ctl_files =3D {next =3D 0xc1679d6c, prev =3D 0xc1679d6c}, proc_root =3D 0=
xc167c4c0,=20
  proc_id =3D 0xc16777c0, proc_root_link =3D 0xc1677840, files =3D 0xdbab0e=
60,=20
  s_f_ops =3D 0x0, files_lock =3D {lock =3D 1}, shutdown =3D 0, shutdown_sl=
eep =3D {
    lock =3D {lock =3D 1}, task_list =3D {next =3D 0xc1679d94, prev =3D 0xc=
1679d94}},=20
  set_power_state =3D 0, power_state_private_data =3D 0x0, power_state =3D =
0,=20
  power_lock =3D {count =3D {counter =3D 1}, sleepers =3D 0, wait =3D {lock=
 =3D {
        lock =3D 1}, task_list =3D {next =3D 0xc1679db4, prev =3D 0xc1679db=
4}}},=20
  power_sleep =3D {lock =3D {lock =3D 1}, task_list =3D {next =3D 0xc1679dc=
0,=20
      prev =3D 0xc1679dc0}}}
(gdb) up
#5  0xc0338030 in snd_pcm_update_hw_ptr_interrupt (substream=3D0xc16ec900)
    at sound/core/pcm_lib.c:179
179			snd_pcm_stop(substream,
(gdb) up=08=08print *substream->pcm->card
$6 =3D {number =3D 1, id =3D "15_1", '\0' <repeats 11 times>,=20
  driver =3D "RME9652\0\0\0\0\0\0\0\0",=20
  shortname =3D "RME Digi9652 (Rev 1.5)\0\0\0\0\0\0\0\0\0",=20
  longname =3D "RME Digi9652 (Rev 1.5) at 0xf6000000, irq 10", '\0' <repeat=
s 35 times>, mixername =3D '\0' <repeats 79 times>,=20
  components =3D '\0' <repeats 79 times>, module =3D 0x0,=20
  private_data =3D 0xc1679dc8,=20
  private_free =3D 0xc0342020 <snd_rme9652_card_free>, devices =3D {
    next =3D 0xc167da80, prev =3D 0xc167db80}, last_numid =3D 17, controls_=
rwsem =3D {
    count =3D 0, wait_lock =3D {lock =3D 1}, wait_list =3D {next =3D 0xc167=
9d54,=20
      prev =3D 0xc1679d54}}, ctl_files_rwlock =3D {lock =3D 16777216},=20
  controls_count =3D 17, controls =3D {next =3D 0xc16784c0, prev =3D 0xc167=
7bc0},=20
  ctl_files =3D {next =3D 0xc1679d6c, prev =3D 0xc1679d6c}, proc_root =3D 0=
xc167c4c0,=20
  proc_id =3D 0xc16777c0, proc_root_link =3D 0xc1677840, files =3D 0xdbab0e=
60,=20
  s_f_ops =3D 0x0, files_lock =3D {lock =3D 1}, shutdown =3D 0, shutdown_sl=
eep =3D {
    lock =3D {lock =3D 1}, task_list =3D {next =3D 0xc1679d94, prev =3D 0xc=
1679d94}},=20
  set_power_state =3D 0, power_state_private_data =3D 0x0, power_state =3D =
0,=20
  power_lock =3D {count =3D {counter =3D 1}, sleepers =3D 0, wait =3D {lock=
 =3D {
        lock =3D 1}, task_list =3D {next =3D 0xc1679db4, prev =3D 0xc1679db=
4}}},=20
  power_sleep =3D {lock =3D {lock =3D 1}, task_list =3D {next =3D 0xc1679dc=
0,=20
      prev =3D 0xc1679dc0}}}
(gdb) w
Ambiguous command "w": watch, whatis, where, while, while-stepping, ws.
(gdb) wh
Ambiguous command "wh": whatis, where, while, while-stepping.
(gdb) whe
#0  gdb_interrupt (irq=3D4, dev_id=3D0x0, regs=3D0xc04f5ddc)
    at arch/i386/lib/kgdb_serial.c:194
#1  0xc010cd68 in handle_IRQ_event (irq=3D4, regs=3D0xc04f5ddc, action=3D0x=
dffee640)
    at arch/i386/kernel/irq.c:214
#2  0xc010cfd1 in do_IRQ (regs=3D
      {ebx =3D -1068548096, ecx =3D -615541760, edx =3D 0, esi =3D -6155395=
44, edi =3D -615517184, ebp =3D -1068540392, eax =3D -1068548096, xds =3D 1=
23, xes =3D 123, orig_eax =3D -252, eip =3D -1072561615, xcs =3D 96, eflags=
 =3D 646, esp =3D -1068548096, xss =3D -1049704000}) at arch/i386/kernel/ir=
q.c:395
#3  0xc010b60c in common_interrupt () at net/8021q/vlan.c:130
#4  0xc0332ca0 in snd_pcm_stop (substream=3D0xc16ec900, state=3D4)
    at sound/core/pcm_native.c:723
#5  0xc0338030 in snd_pcm_update_hw_ptr_interrupt (substream=3D0xc16ec900)
    at sound/core/pcm_lib.c:179
#6  0xc033b88e in snd_pcm_period_elapsed (substream=3D0xc16ec900)
    at sound/core/pcm_lib.c:2016
#7  0xc0340fca in snd_rme9652_interrupt (irq=3D10, dev_id=3D0xc1679dc8,=20
    regs=3D0xc04f5ed4) at sound/pci/rme9652/rme9652.c:1965
#8  0xc010cd68 in handle_IRQ_event (irq=3D10, regs=3D0xc04f5ed4, action=3D0=
xc1700be0)
    at arch/i386/kernel/irq.c:214
#9  0xc010cfd1 in do_IRQ (regs=3D
      {ebx =3D -615539712, ecx =3D 1, edx =3D -615546880, esi =3D -10497040=
00, edi =3D 12, ebp =3D -1068540124, eax =3D -1049704000, xds =3D 123, xes =
=3D 123, orig_eax =3D -246, eip =3D -1070367156, xcs =3D 96, eflags =3D 646=
, esp =3D -615539712, xss =3D -1049704000})
    at arch/i386/kernel/irq.c:395
#10 0xc010b60c in common_interrupt () at net/8021q/vlan.c:130
#11 0xc033b88e in snd_pcm_period_elapsed (substream=3D0xc16ec9c0)
    at sound/core/pcm_lib.c:2016
#12 0xc0340faf in snd_rme9652_interrupt (irq=3D12, dev_id=3D0xc17171c8,=20
    regs=3D0xc04f5f94) at sound/pci/rme9652/rme9652.c:1961
#13 0xc010cd68 in handle_IRQ_event (irq=3D12, regs=3D0xc04f5f94, action=3D0=
xc1700340)
    at arch/i386/kernel/irq.c:214
#14 0xc010cfd1 in do_IRQ (regs=3D
      {ebx =3D -1068548096, ecx =3D -1068548096, edx =3D -1068548096, esi =
=3D -1072657920, edi =3D -1072672768, ebp =3D -1068539960, eax =3D 0, xds =
=3D 123, xes =3D 123, orig_eax =3D -244, eip =3D -1072657871, xcs =3D 96, e=
flags =3D 582, esp =3D -1068539944, xss =3D -1072657697}) at arch/i386/kern=
el/irq.c:395
#15 0xc010b60c in common_interrupt () at net/8021q/vlan.c:130
#16 0xc0108adf in cpu_idle () at arch/i386/kernel/process.c:146
#17 0xc0105065 in rest_init () at init/main.c:371
#18 0xc04f68a5 in start_kernel () at init/main.c:463
(gdb) up
#6  0xc033b88e in snd_pcm_period_elapsed (substream=3D0xc16ec900)
    at sound/core/pcm_lib.c:2016
2016		    snd_pcm_update_hw_ptr_interrupt(substream) < 0)
(gdb) l
2011		if (runtime->transfer_ack_begin)
2012			runtime->transfer_ack_begin(substream);
2013=09
2014		spin_lock(&runtime->lock);
2015		if (!snd_pcm_running(substream) ||
2016		    snd_pcm_update_hw_ptr_interrupt(substream) < 0)
2017			goto _end;
2018=09
2019		if (substream->timer_running)
2020			snd_timer_interrupt(substream->timer, 1);
(gdb) p snd_pcm_running(substream)
No symbol "snd_pcm_running" in current context.
(gdb) print runtime->lock
Attempt to extract a component of a value that is not a structure pointer.
(gdb) print runtime
$7 =3D <incomplete type>
(gdb) whatis runtime
type =3D struct <unknown>
(gdb) up
#7  0xc0340fca in snd_rme9652_interrupt (irq=3D10, dev_id=3D0xc1679dc8,=20
    regs=3D0xc04f5ed4) at sound/pci/rme9652/rme9652.c:1965
1965			snd_pcm_period_elapsed(rme9652->pcm->streams[SNDRV_PCM_STREAM_PLAYBA=
CK].substream);
(gdb) =07=07up
#8  0xc010cd68 in handle_IRQ_event (irq=3D10, regs=3D0xc04f5ed4, action=3D0=
xc1700be0)
    at arch/i386/kernel/irq.c:214
214				continue;
(gdb) up
#9  0xc010cfd1 in do_IRQ (regs=3D
      {ebx =3D -615539712, ecx =3D 1, edx =3D -615546880, esi =3D -10497040=
00, edi =3D 12, ebp =3D -1068540124, eax =3D -1049704000, xds =3D 123, xes =
=3D 123, orig_eax =3D -246, eip =3D -1070367156, xcs =3D 96, eflags =3D 646=
, esp =3D -615539712, xss =3D -1049704000})
    at arch/i386/kernel/irq.c:395
395		retval =3D 2 + local_enabled;
(gdb) up
#10 0xc010b60c in common_interrupt () at net/8021q/vlan.c:130
130		vlan_proc_cleanup();
(gdb) up
#11 0xc033b88e in snd_pcm_period_elapsed (substream=3D0xc16ec9c0)
    at sound/core/pcm_lib.c:2016
2016		    snd_pcm_update_hw_ptr_interrupt(substream) < 0)
(gdb) print *subscr=08 =08=08 =08=08 =08stream->pcm->card
$8 =3D {number =3D 0, id =3D "15", '\0' <repeats 13 times>,=20
  driver =3D "RME9652\0\0\0\0\0\0\0\0",=20
  shortname =3D "RME Digi9652 (Rev 1.5)\0\0\0\0\0\0\0\0\0",=20
  longname =3D "RME Digi9652 (Rev 1.5) at 0xf5000000, irq 12", '\0' <repeat=
s 35 times>, mixername =3D '\0' <repeats 79 times>,=20
  components =3D '\0' <repeats 79 times>, module =3D 0x0,=20
  private_data =3D 0xc17171c8,=20
  private_free =3D 0xc0342020 <snd_rme9652_card_free>, devices =3D {
    next =3D 0xc167de60, prev =3D 0xc167df60}, last_numid =3D 17, controls_=
rwsem =3D {
    count =3D 0, wait_lock =3D {lock =3D 1}, wait_list =3D {next =3D 0xc171=
7154,=20
      prev =3D 0xc1717154}}, ctl_files_rwlock =3D {lock =3D 16777216},=20
  controls_count =3D 17, controls =3D {next =3D 0xc16843c0, prev =3D 0xc167=
cac0},=20
  ctl_files =3D {next =3D 0xdbdf32c0, prev =3D 0xdbdf32c0}, proc_root =3D 0=
xc16863c0,=20
  proc_id =3D 0xc167c6c0, proc_root_link =3D 0xc167c740, files =3D 0xdbab0f=
40,=20
  s_f_ops =3D 0x0, files_lock =3D {lock =3D 1}, shutdown =3D 0, shutdown_sl=
eep =3D {
    lock =3D {lock =3D 1}, task_list =3D {next =3D 0xc1717194, prev =3D 0xc=
1717194}},=20
  set_power_state =3D 0, power_state_private_data =3D 0x0, power_state =3D =
0,=20
  power_lock =3D {count =3D {counter =3D 1}, sleepers =3D 0, wait =3D {lock=
 =3D {
        lock =3D 1}, task_list =3D {next =3D 0xc17171b4, prev =3D 0xc17171b=
4}}},=20
  power_sleep =3D {lock =3D {lock =3D 1}, task_list =3D {next =3D 0xc17171c=
0,=20
      prev =3D 0xc17171c0}}}
(gdb) l
2011		if (runtime->transfer_ack_begin)
2012			runtime->transfer_ack_begin(substream);
2013=09
2014		spin_lock(&runtime->lock);
2015		if (!snd_pcm_running(substream) ||
2016		    snd_pcm_update_hw_ptr_interrupt(substream) < 0)
2017			goto _end;
2018=09
2019		if (substream->timer_running)
2020			snd_timer_interrupt(substream->timer, 1);
(gdb) p=08 =08whatis runtime
type =3D struct <unknown>
(gdb) down
#10 0xc010b60c in common_interrupt () at net/8021q/vlan.c:130
130		vlan_proc_cleanup();
(gdb) down
#9  0xc010cfd1 in do_IRQ (regs=3D
      {ebx =3D -615539712, ecx =3D 1, edx =3D -615546880, esi =3D -10497040=
00, edi =3D 12, ebp =3D -1068540124, eax =3D -1049704000, xds =3D 123, xes =
=3D 123, orig_eax =3D -246, eip =3D -1070367156, xcs =3D 96, eflags =3D 646=
, esp =3D -615539712, xss =3D -1049704000})
    at arch/i386/kernel/irq.c:395
395		retval =3D 2 + local_enabled;
(gdb) print flags
No symbol "flags" in current context.
(gdb) print eflags
No symbol "eflags" in current context.
(gdb) up
#10 0xc010b60c in common_interrupt () at net/8021q/vlan.c:130
130		vlan_proc_cleanup();
(gdb) up
#11 0xc033b88e in snd_pcm_period_elapsed (substream=3D0xc16ec9c0)
    at sound/core/pcm_lib.c:2016
2016		    snd_pcm_update_hw_ptr_interrupt(substream) < 0)
(gdb) up
#12 0xc0340faf in snd_rme9652_interrupt (irq=3D12, dev_id=3D0xc17171c8,=20
    regs=3D0xc04f5f94) at sound/pci/rme9652/rme9652.c:1961
1961			snd_pcm_period_elapsed(rme9652->pcm->streams[SNDRV_PCM_STREAM_CAPTUR=
E].substream);
(gdb) up
#13 0xc010cd68 in handle_IRQ_event (irq=3D12, regs=3D0xc04f5f94, action=3D0=
xc1700340)
    at arch/i386/kernel/irq.c:214
214				continue;
(gdb) up
#14 0xc010cfd1 in do_IRQ (regs=3D
      {ebx =3D -1068548096, ecx =3D -1068548096, edx =3D -1068548096, esi =
=3D -1072657920, edi =3D -1072672768, ebp =3D -1068539960, eax =3D 0, xds =
=3D 123, xes =3D 123, orig_eax =3D -244, eip =3D -1072657871, xcs =3D 96, e=
flags =3D 582, esp =3D -1068539944, xss =3D -1072657697}) at arch/i386/kern=
el/irq.c:395
395		retval =3D 2 + local_enabled;
(gdb) up
#15 0xc010b60c in common_interrupt () at net/8021q/vlan.c:130
130		vlan_proc_cleanup();
(gdb) up
#16 0xc0108adf in cpu_idle () at arch/i386/kernel/process.c:146
146			pm_idle =3D poll_idle;
(gdb) f=08 =08up
#17 0xc0105065 in rest_init () at init/main.c:371
371		/*
(gdb) cont
Continuing.

Program received signal SIGTRAP, Trace/breakpoint trap.
gdb_interrupt (irq=3D4, dev_id=3D0x0, regs=3D0xc04f5ddc)
    at arch/i386/lib/kgdb_serial.c:194
194	            continue ;
(gdb) bt
#0  gdb_interrupt (irq=3D4, dev_id=3D0x0, regs=3D0xc04f5ddc)
    at arch/i386/lib/kgdb_serial.c:194
#1  0xc010cd68 in handle_IRQ_event (irq=3D4, regs=3D0xc04f5ddc, action=3D0x=
dffee640)
    at arch/i386/kernel/irq.c:214
#2  0xc010cfd1 in do_IRQ (regs=3D
      {ebx =3D -1068548096, ecx =3D -615541760, edx =3D 0, esi =3D -6155395=
44, edi =3D -615517184, ebp =3D -1068540392, eax =3D -1068548096, xds =3D 1=
23, xes =3D 123, orig_eax =3D -252, eip =3D -1072561615, xcs =3D 96, eflags=
 =3D 646, esp =3D -1068548096, xss =3D -1049704000}) at arch/i386/kernel/ir=
q.c:395
#3  0xc010b60c in common_interrupt () at net/8021q/vlan.c:130
#4  0xc0332ca0 in snd_pcm_stop (substream=3D0xc16ec900, state=3D4)
    at sound/core/pcm_native.c:723
#5  0xc0338030 in snd_pcm_update_hw_ptr_interrupt (substream=3D0xc16ec900)
    at sound/core/pcm_lib.c:179
#6  0xc033b88e in snd_pcm_period_elapsed (substream=3D0xc16ec900)
    at sound/core/pcm_lib.c:2016
#7  0xc0340fca in snd_rme9652_interrupt (irq=3D10, dev_id=3D0xc1679dc8,=20
    regs=3D0xc04f5ed4) at sound/pci/rme9652/rme9652.c:1965
#8  0xc010cd68 in handle_IRQ_event (irq=3D10, regs=3D0xc04f5ed4, action=3D0=
xc1700be0)
    at arch/i386/kernel/irq.c:214
#9  0xc010cfd1 in do_IRQ (regs=3D
      {ebx =3D -615539712, ecx =3D 1, edx =3D -615546880, esi =3D -10497040=
00, edi =3D 12, ebp =3D -1068540124, eax =3D -1049704000, xds =3D 123, xes =
=3D 123, orig_eax =3D -246, eip =3D -1070367156, xcs =3D 96, eflags =3D 646=
, esp =3D -615539712, xss =3D -1049704000})
    at arch/i386/kernel/irq.c:395
#10 0xc010b60c in common_interrupt () at net/8021q/vlan.c:130
#11 0xc033b88e in snd_pcm_period_elapsed (substream=3D0xc16ec9c0)
    at sound/core/pcm_lib.c:2016
#12 0xc0340faf in snd_rme9652_interrupt (irq=3D12, dev_id=3D0xc17171c8,=20
    regs=3D0xc04f5f94) at sound/pci/rme9652/rme9652.c:1961
#13 0xc010cd68 in handle_IRQ_event (irq=3D12, regs=3D0xc04f5f94, action=3D0=
xc1700340)
    at arch/i386/kernel/irq.c:214
#14 0xc010cfd1 in do_IRQ (regs=3D
      {ebx =3D -1068548096, ecx =3D -1068548096, edx =3D -1068548096, esi =
=3D -1072657920, edi =3D -1072672768, ebp =3D -1068539960, eax =3D 0, xds =
=3D 123, xes =3D 123, orig_eax =3D -244, eip =3D -1072657871, xcs =3D 96, e=
flags =3D 582, esp =3D -1068539944, xss =3D -1072657697}) at arch/i386/kern=
el/irq.c:395
#15 0xc010b60c in common_interrupt () at net/8021q/vlan.c:130
#16 0xc0108adf in cpu_idle () at arch/i386/kernel/process.c:146
#17 0xc0105065 in rest_init () at init/main.c:371
#18 0xc04f68a5 in start_kernel () at init/main.c:463
(gdb) q
The program is running.  Exit anyway? (y or n) y
Rainbow:/usr/src/linux-2.5.67 # exit
Script done on Sun Apr 13 10:58:06 2003

--ELM744821014-2088-25_--


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
