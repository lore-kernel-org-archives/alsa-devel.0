From: Paul <paul@mrarm.io>
Subject: Writing a driver for a device with no device-side
	buffer pointer
Date: Mon, 29 Jul 2019 14:42:31 +0200
Message-ID: <3c58350672b44b83d2018cd75cb60c55@mrarm.io>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from reset.mrarm.io (reset.mrarm.io [104.131.177.190])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C595AF803D5
 for <alsa-devel@alsa-project.org>; Mon, 29 Jul 2019 14:43:04 +0200 (CEST)
Received: from reset.mrarm.io (reset.mrarm.io [104.131.177.190])
 by reset.mrarm.io (Postfix) with ESMTPSA id D7E017DA17
 for <alsa-devel@alsa-project.org>; Mon, 29 Jul 2019 12:42:31 +0000 (UTC)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,
I am trying to write an ALSA driver for the T2 controller present in the 
2018 MacBook Pro machine by reverse engineering the OS X driver, however 
I have ran into synchronization issues.

The controller uses a ring buffer for the actual audio transfer, however 
there's no way for me to tell what position the device is currently 
reading from. Other than the ring buffer the device utilizes a two-way 
command protocol. Additionally, the host sends a timestamp to the device 
every 150ms.

When starting audio playback the host sends a StartIO command to the 
device, and then the device periodically sends an UpdateTimestamp 
command to the host which sends the timestamp in the host's time (by 
using the timestamp the host sent to it some time before and 
appropriately offsetting it; the update is sent ~every 0.346s; this is 
the amount of time that can be stored in the ring buffer at a time - 
it's forced at 48kHz, with 0x4100 values for each channel in the buffer 
which also calculates to basically this value; I'm not 100% sure about 
the full purpose of this command as I suspect it might be also used to 
reset the buffer position, but this is just a guess). When the playback 
is finished, a StopIO command is sent by the host.

I tried searching in the Linux kernel for devices using a similar system 
but I had trouble finding any results. I have also tried returning an 
approximated (by using the synched up time) pointer, however that ended 
up in garbage audio output. I also tried returning the 
substream->runtime->control->appl_ptr pointer, but this also ended up in 
garbage audio output.

I have observed the following results while the default test tools:
- speaker-test is the closest to giving any output making sense. When 
using the `sine` mode, you can however hear a clear break every 0.5s or 
around that. In `pink` mode, the noise generally makes sense but sounds 
distorted around this 0.5s interval as well. In `wav` mode a repeating 
"front-" sound can be heard. These observations were originally made 
when I returned 0 from pcm_pointer, attempting the other methods however 
ended up in the same result (appl_ptr in particular had to end up this 
way because it simply ended up in a zero return from the pointer method, 
as speaker-test seems to fill the whole buffer).
- aplay gives either no audible output (0 return) or garbage audio (the 
appl_ptr and time sync approaches)

I have trouble understanding how would this system be implemented using 
the ALSA's pointer functions. Any help, explanations, code snippets or 
references to the documentation or existing Linux drivers which may 
share similarities with this device would be greatly appreciated.

I am also attaching code snippets in case they are of any use for my 
particular issue.

Thank you,
Paul Pawlowski


Additional configuration information:
static struct snd_pcm_hardware aaudio_basic_hw = {
         .info = (SNDRV_PCM_INFO_MMAP |
                  SNDRV_PCM_INFO_INTERLEAVED |
                  SNDRV_PCM_INFO_BLOCK_TRANSFER |
                  SNDRV_PCM_INFO_MMAP_VALID |
                  SNDRV_PCM_INFO_HAS_LINK_SYNCHRONIZED_ATIME |
                  SNDRV_PCM_INFO_SYNC_APPLPTR),
         .formats =          SNDRV_PCM_FMTBIT_S24_LE,
         .rates =            SNDRV_PCM_RATE_48000,
         .rate_min =         48000,
         .rate_max =         48000,
         .channels_min =     4,
         .channels_max =     4,
         .buffer_bytes_max = 0x41000,
         .period_bytes_min = 0x10,
         .period_bytes_max = 0x10,
         .periods_min =      0x4100,
         .periods_max =      0x4100,
};

The "time-sync" test approach way of managing the pointer:
static snd_pcm_uframes_t aaudio_pcm_pointer(struct snd_pcm_substream 
*substream)
{
     ktime_t b;
     struct aaudio_device *a = snd_pcm_substream_chip(substream);
     b = ktime_get_boottime() - a->recv_ts_remote;
     b = (ktime_to_ns(b) % 346666666) * 0x41000 / 346666666;
     b -= b % 0x10;
     return bytes_to_frames(substream->runtime, b);
}
