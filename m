From: Carlo Wood <carlo@alinoe.com>
Subject: Re: snd_pcm_mmap_begin returns 0 but sets areas to NULL
Date: Tue, 22 Jul 2003 16:38:34 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030722143834.GA28051@alinoe.com>
References: <20030722135158.GA12258@alinoe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20030722135158.GA12258@alinoe.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 22, 2003 at 03:51:58PM +0200, Carlo Wood wrote:
>       int err = snd_pcm_mmap_begin(handle, &areas, &offset, &frames);
> 
> returns err == 0, but results in areas == NULL ?

I looked deeper into it, and it happens because
snd_pcm_mmap_begin returns snd_pcm_mmap_areas()
which returns pcm->running_areas:

314     static inline const snd_pcm_channel_area_t *snd_pcm_mmap_areas(snd_pcm_t *pcm)
315     {
316             if (pcm->stopped_areas &&
317                 snd_pcm_state(pcm) != SND_PCM_STATE_RUNNING)
318                     return pcm->stopped_areas;
319             return pcm->running_areas;
320     }

where

(gdb) p *pcm
$6 = {dl_handle = 0x40016670, name = 0x81a5088 "emu10k1", type = SND_PCM_TYPE_HW, stream = SND_PCM_STREAM_CAPTURE,
  mode = 0, poll_fd = 9, poll_events = 1, setup = 1, access = SND_PCM_ACCESS_RW_INTERLEAVED,
  format = SND_PCM_FORMAT_S16_LE, subformat = SND_PCM_SUBFORMAT_STD, channels = 1, rate = 22050, period_size = 384,
  period_time = 17414, periods = {min = 0, max = 0, openmin = 0, openmax = 0, integer = 0, empty = 0}, tick_time = 1000,
  tstamp_mode = SND_PCM_TSTAMP_NONE, period_step = 1, sleep_min = 0, avail_min = 384, start_threshold = 1,
  stop_threshold = 768, silence_threshold = 0, silence_size = 0, xfer_align = 384, boundary = 1610612736, info = 65795,
  msbits = 16, rate_num = 22050, rate_den = 1, fifo_size = 0, buffer_size = 768, buffer_time = {min = 0, max = 0,
    openmin = 0, openmax = 0, integer = 0, empty = 0}, sample_bits = 16, frame_bits = 16, appl = {master = 0x0,
    ptr = 0x4001b000, fd = 9, offset = -2130706432, link_dst_count = 0, link_dst = 0x0, private_data = 0x0, changed = 0},
  hw = {master = 0x0, ptr = 0x40018008, fd = 9, offset = -2147483640, link_dst_count = 0, link_dst = 0x0,
    private_data = 0x0, changed = 0}, min_align = 1, mmap_rw = 0, donot_close = 0, mmap_channels = 0x0,
  running_areas = 0x0, stopped_areas = 0x0, ops = 0x400cdc20, fast_ops = 0x400cdc60, op_arg = 0x804ffa8,
  fast_op_arg = 0x804ffa8, private_data = 0x81a4a98, async_handlers = {next = 0x80e5304, prev = 0x80e5304}}


Why is running_areas == 0x0 ??

I need direct read access for this capture-stream.

-- 
Carlo Wood <carlo@alinoe.com>


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
