From: Adarsh <punia.adarsh@gmail.com>
Subject: Heavy looping inside snd_pcm_dmix_sync_area with
 snd_pcm_sw_params_set_stop_threshold > boundary and several hours of play
Date: Tue, 18 Feb 2014 19:32:29 +0530
Message-ID: <CANxfbX9TBYY3f7Ofs1Z3k12aMSfX08yi4xt604QCX6_PGLsxTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f177.google.com (mail-we0-f177.google.com
 [74.125.82.177])
 by alsa0.perex.cz (Postfix) with ESMTP id ABBDC2654CC
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 15:02:29 +0100 (CET)
Received: by mail-we0-f177.google.com with SMTP id t61so11295454wes.8
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 06:02:29 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

We are using RW_INTERLEAVED access as described in write_loop method in
/test/pcm.c and opening 'default' device.
However to disable the underruns, the snd_pcm_sw_params_set_stop_threshold
is set to 0x7fffffff which is greater than boundary
value. Period size is 1024 and buffer size is 2048. We try to write
period_size no of frames using snd_pcm_writei.

This setup runs fine for several hours. It was left runing overnight. After
some 12 hours of play, gdb is attached to the process and continued inside
gdb.
At this point, the thread went into a tight loop taking >100% cpu and
playing same sound over and over again abusing speakers.
It did not recover for a long time.

Stack trace shows that 'snd_pcm_dmix_sync_area' in pcm_dmix.c is taking a
very long time to return because the 'size' is
a large unsinged interger and mix_areas is getting called with 'transfer'
value of <=2048.

Below is the stack trace:
(gdb) bt
#0  0xb7c44463 in mix_areas_32_smp (size=1360, dst=0xb6855000,
src=0x84a7510, sum=0xb6845000, dst_step=4, src_step=4, sum_step=4) at
pcm_dmix_i386.h:261
#1  0xb7c44d2b in mix_areas (dmix=0x84a7110, src_areas=0x84a51d0,
dst_areas=0x84a6f00, src_ofs=0, dst_ofs=7168, size=1024) at pcm_dmix.c:193
#2  0xb7c45422 in snd_pcm_dmix_sync_area (pcm=0x84a71e0) at pcm_dmix.c:371
#3  0xb7c46680 in snd_pcm_dmix_mmap_commit (pcm=0x84a71e0, offset=0,
size=1024) at pcm_dmix.c:813
#4  0xb7c07033 in snd_pcm_mmap_commit (pcm=0x84a71e0, offset=0,
frames=1024) at pcm.c:6501
#5  0xb7c1804e in snd_pcm_plugin_mmap_commit (pcm=0x84a6d18, offset=0,
size=1024) at pcm_plugin.c:434
#6  0xb7c07033 in snd_pcm_mmap_commit (pcm=0x84a6d18, offset=0,
frames=1024) at pcm.c:6501
#7  0xb7c17956 in snd_pcm_plugin_write_areas (pcm=0x84a5390,
areas=0xb68362b0, offset=0, size=1024) at pcm_plugin.c:290
#8  0xb7c074bb in snd1_pcm_write_areas (pcm=0x84a5390, areas=0xb68362b0,
offset=0, size=1024, func=0xb7c177fc <snd_pcm_plugin_write_areas>) at
pcm.c:6667
#9  0xb7c17cd5 in snd_pcm_plugin_writei (pcm=0x84a5390, buffer=0x84ab518,
size=1024) at pcm_plugin.c:361
#10 0xb7bff1a7 in _snd_pcm_writei (pcm=0x84a6b18, buffer=0x84ab518,
size=1024) at pcm_local.h:516
#11 0xb7bff16c in snd_pcm_writei (pcm=0x84a6b18, buffer=0x84ab518,
size=1024) at pcm.c:1258

(gdb) f 2
#2  0xb7c45422 in snd_pcm_dmix_sync_area (pcm=0x84a71e0) at pcm_dmix.c:371
  371     pcm_dmix.c: No such file or directory.
(gdb) info locals
  dmix = 0x84a7110
  slave_hw_ptr = 234156032
  slave_appl_ptr = 7168
  slave_size = 1057171456
  appl_ptr = 0
  size = 1018295296
  transfer = 1024
  src_areas = 0x84a51d0
  dst_areas = 0x84a6f00
(gdb) p *dmix
  $1 = {type = SND_PCM_TYPE_DMIX, ipc_key = 5678293, ipc_perm = 432,
ipc_gid = 17, semid = 32768, shmid = 65536, shmptr = 0xb6859000, spcm =
0x84a7340,
    appl_ptr = 217121792, last_appl_ptr = 233882624, hw_ptr = 233875428,
avail_max = 0, slave_appl_ptr = 234156032, slave_hw_ptr = 234147996,
    slave_period_size = 1024, slave_buffer_size = 8192, slave_boundary =
1073741824, sync_ptr = 0xb7c4557c <snd_pcm_dmix_sync_ptr>,
    state = SND_PCM_STATE_RUNNING, trigger_tstamp = {tv_sec = 1392384066,
tv_nsec = 8308000}, server = 0, client = 0, comm_fd = 0, hw_fd = 4,
timer_fd = {
      fd = 3, events = 41, revents = 0}, poll_fd = 3, tread = 1,
timer_need_poll = 0, timer_event_suspend = 131072, timer_event_resume =
262144,
    server_fd = 0, server_pid = 0, timer = 0x8496b90, interleaved = 1,
slowptr = 1, max_periods = 0, channels = 2, bindings = 0x0, u = {dmix = {
      shmid_sum = 98305, sum_buffer = 0xb6837000, mix_areas_16 = 0xb7c443a8
<mix_areas_16_smp_mmx>, mix_areas_32 = 0xb7c44415 <mix_areas_32_smp>,
      mix_areas_24 = 0xb7c4451b <mix_areas_24_smp_cmov>, mix_areas_u8 = 0,
remix_areas_16 = 0xb7c44638 <remix_areas_16_smp_mmx>,
      remix_areas_32 = 0xb7c446a5 <remix_areas_32_smp>, remix_areas_24 =
0xb7c447ab <remix_areas_24_smp_cmov>, remix_areas_u8 = 0},
    dsnoop = {<No data fields>}, dshare = {chn_mask =
13151478482154389505}}, server_free = 0}
(gdb) p *pcm
$2 = {dl_handle = 0x0, name = 0x84a6e48 "dmix:0", type = SND_PCM_TYPE_DMIX,
stream = SND_PCM_STREAM_PLAYBACK, mode = 0, poll_fd_count = 1, poll_fd = 3,
  poll_events = 1, setup = -1, monotonic = 0, access =
SND_PCM_ACCESS_MMAP_INTERLEAVED, format = SND_PCM_FORMAT_S32_LE, subformat
= SND_PCM_SUBFORMAT_STD,
  channels = 2, rate = 44100, period_size = 1024, period_time = 23219,
periods = {min = 0, max = 0, openmin = 0, openmax = 0, integer = 0, empty =
0},
  tstamp_mode = SND_PCM_TSTAMP_NONE, period_step = 1, avail_min = 1024,
period_event = 0, start_threshold = 1024, stop_threshold = 2147483647,
  silence_threshold = 0, silence_size = 0, boundary = 1073741824, info =
2151743747, msbits = 32, rate_num = 44100, rate_den = 1, hw_flags = 0,
  fifo_size = 0, buffer_size = 2048, buffer_time = {min = 0, max = 0,
openmin = 0, openmax = 0, integer = 0, empty = 0}, sample_bits = 32,
  frame_bits = 64, appl = {master = 0x0, ptr = 0x84a7130, fd = -1, offset =
0, link_dst_count = 0, link_dst = 0x0, private_data = 0x0, changed = 0}, hw
= {
    master = 0x0, ptr = 0x84a7138, fd = -1, offset = 0, link_dst_count = 0,
link_dst = 0x0, private_data = 0x0, changed = 0}, min_align = 1, mmap_rw =
1,
  mmap_shadow = 0, donot_close = 0, mmap_channels = 0x84a54a0,
running_areas = 0x84a51d0, stopped_areas = 0x0, ops = 0xb7c91860, fast_ops
= 0xb7c918a0,
  op_arg = 0x84a71e0, fast_op_arg = 0x84a71e0, private_data = 0x84a7110,
async_handlers = {next = 0x84a72e4, prev = 0x84a72e4}}

Attaching gdb does not show this behaviour if
snd_pcm_sw_params_set_stop_threshold is not set, which then defaults to
buffer size or when the
application is running for shorter duration.

Is it that setting of stop threshold to 0x7fffffff is triggering this and
attaching gdb is making the buffer pointers misbehave?
If so, what can be done if we do not want PCM to stop.

Below is the pcm dump:
Plug PCM: Linear conversion PCM (S32_LE)
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 44100
  exact rate   : 44100 (44100/1)
  msbits       : 16
  buffer_size  : 2048
  period_size  : 1024
  period_time  : 23219
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 1024
  period_event : 0
  start_threshold  : 1024
  stop_threshold   : 2147483647
  silence_threshold: 0
  silence_size : 0
  boundary     : 1073741824
Slave: Soft volume PCM
Control: PCM Playback Volume
min_dB: -51
max_dB: 0
resolution: 256
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S32_LE
  subformat    : STD
  channels     : 2
  rate         : 44100
  exact rate   : 44100 (44100/1)
  msbits       : 32
  buffer_size  : 2048
  period_size  : 1024
  period_time  : 23219
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 1024
  period_event : 0
  start_threshold  : 1024
  stop_threshold   : 2147483647
  silence_threshold: 0
  silence_size : 0
  boundary     : 1073741824
Slave: Direct Stream Mixing PCM
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S32_LE
  subformat    : STD
  channels     : 2
  rate         : 44100
  exact rate   : 44100 (44100/1)
  msbits       : 32
  buffer_size  : 2048
  period_size  : 1024
  period_time  : 23219
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 1024
  period_event : 0
  start_threshold  : 1024
  stop_threshold   : 2147483647
  silence_threshold: 0
  silence_size : 0
  boundary     : 1073741824
Hardware PCM card 0 'HDA Intel PCH' device 0 subdevice 0
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S32_LE
  subformat    : STD
  channels     : 2
  rate         : 44100
  exact rate   : 44100 (44100/1)
  msbits       : 32
  buffer_size  : 8192
  period_size  : 1024
  period_time  : 23219
  tstamp_mode  : ENABLE
  period_step  : 1
  avail_min    : 1024
  period_event : 0
  start_threshold  : 1
  stop_threshold   : 1073741824
  silence_threshold: 0
  silence_size : 1073741824
  boundary     : 1073741824
  appl_ptr     : 0
  hw_ptr       : 0

Thanks
