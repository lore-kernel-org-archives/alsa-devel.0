From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: PulseAudio and SNDRV_PCM_INFO_BATCH
Date: Wed, 17 Jun 2015 21:48:11 +0500
Message-ID: <5581A4CB.7080300@gmail.com>
References: <CACuU-+jBWck1e3tf--=G+X3xNAQm++JCxRzQFkDUJ4f5zwhgoQ@mail.gmail.com>
 <557E86DD.8020709@metafoo.de>
 <CAN8cciYApKja0e0U7Uy2YG2ySemfhvKfLGUueGyFx5ajjyqKBA@mail.gmail.com>
 <557EBEAA.70004@metafoo.de>
 <CAN8cciZ4B2X+o4AXdCGEEAFCcX+iWqyf+FvMkEkrSu3Vt8Vx8Q@mail.gmail.com>
 <557EDE22.7080808@metafoo.de>
 <CAN8cciaYSJVySbyAr_af+0f-govGXEp2CsmQkPLpr=mfc_Quhg@mail.gmail.com>
 <55812F5C.8010502@metafoo.de> <s5h4mm68zfm.wl-tiwai@suse.de>
 <55818DB5.6050007@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040505040302030501030002"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f177.google.com (mail-wi0-f177.google.com
 [209.85.212.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 62C8326049A
 for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2015 18:48:14 +0200 (CEST)
Received: by wiga1 with SMTP id a1so145724169wig.0
 for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2015 09:48:14 -0700 (PDT)
In-Reply-To: <55818DB5.6050007@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>, Takashi Iwai <tiwai@suse.de>, Lars-Peter Clausen <lars@metafoo.de>
Cc: Raymond Yau <superquad.vortex2@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, clemens@ladisch.de, Tanu Kaskinen <tanu.kaskinen@linux.intel.com>, Arun Raghavan <arun@accosted.net>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040505040302030501030002
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 17.06.2015 20:09, David Henningsson wrote:
>
>
> On 2015-06-17 11:19, Takashi Iwai wrote:
>> Well, USB-audio has another problem.  USB-audio uses the intermediate
>> audio ring buffer, and the samples are copied to each URB buffer.  At
>> each packet complete, the driver copies the rest of sample chunk
>> again, and advances the hwptr when the packets.  So, the hwptr of
>> USB-audio is in advance of the actual sample position.  But we provide
>> the runtime delay information for user-space to correct to the more
>> accurate sample position.  So far, so good.
>>
>> A missing piece in this picture is, however, the position of the
>> not-yet-queued samples in ring buffer.  Basically you can rewrite /
>> rewind the sample at most this point, but not farther -- such
>> in-flight samples can't be modified any longer.  This can be seen a
>> kind of hardware fifo with a pretty big and non-continuously variable
>> size during operation.
>>
>> In that sense, get_fifo() looks like a candidate for giving such
>> information, indeed.  But reviving the old (and rather bad working)
>> API appears dangerous to me.  I'd prefer creating a new API function
>> instead, if any.
>>
>> BTW, because of its design like above, a large (or no) period size
>> doesn't help for saving power at all with USB-audio.  This should be
>> considered before the further discussion...
>
> Hmm...I was trying to understand this power save argument. I tried to
> figure out a "typical" URB size by just plugging my headset in, and I
> saw wMaxPacketSize being 96 and/or 192 bytes.
> Then, MAX_PACKS is set to either 6 (or 48 for USB 2.0 devices, but this
> is just a headset).
>
> Can this be correct? Does it mean that we are getting interrupts every
> 192 * 6 bytes (i e, every 6 ms for a 48kHz/stereo/16bit stream)?

At least that's how often the position gets updated in the worst case. I 
have attached a report for a Logitech USB headset and a test program 
where you can modify the buffer and period sizes. A line is logged every 
time snd_pcm_avail() returns a different value.

-- 
Alexander E. Patrakov

--------------040505040302030501030002
Content-Type: text/plain; charset=UTF-8;
 name="usb_sound_timings.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="usb_sound_timings.txt"

======= testing hw:2 =======
min_period_size: 48 frames, dir: 0
FIFO size is 0
Hardware PCM card 2 'C-Media USB Headphone Set' device 0 subdevice 0
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 16
  buffer_size  : 4096
  period_size  : 1024
  period_time  : 21333
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 1024
  period_event : 0
  start_threshold  : 1024
  stop_threshold   : 4096
  silence_threshold: 0
  silence_size : 0
  boundary     : 4611686018427387904
  appl_ptr     : 0
  hw_ptr       : 0
Playing silence
Available: 0, loop iteration: 0, diff: 0, timestamp diff: 6 usec
Available: 288, loop iteration: 2621, diff: 2621, timestamp diff: 5560 usec
Available: 528, loop iteration: 4934, diff: 2313, timestamp diff: 5985 usec
Available: 768, loop iteration: 6804, diff: 1870, timestamp diff: 6000 usec
Available: 1056, loop iteration: 8810, diff: 2006, timestamp diff: 5998 usec
Available: 1296, loop iteration: 10533, diff: 1723, timestamp diff: 5011 usec
Available: 1536, loop iteration: 12238, diff: 1705, timestamp diff: 4997 usec
Available: 1824, loop iteration: 14428, diff: 2190, timestamp diff: 6014 usec
Available: 2064, loop iteration: 16434, diff: 2006, timestamp diff: 4986 usec
Available: 2304, loop iteration: 18209, diff: 1775, timestamp diff: 4989 usec
Available: 2592, loop iteration: 20846, diff: 2637, timestamp diff: 5995 usec
Available: 2832, loop iteration: 23188, diff: 2342, timestamp diff: 5004 usec
Available: 3072, loop iteration: 25568, diff: 2380, timestamp diff: 4998 usec
Available: 3360, loop iteration: 28495, diff: 2927, timestamp diff: 6002 usec
Available: 3600, loop iteration: 30172, diff: 1677, timestamp diff: 5000 usec
Available: 3840, loop iteration: 32005, diff: 1833, timestamp diff: 4996 usec
======= testing hw:2 =======
min_period_size: 48 frames, dir: 0
FIFO size is 0
Hardware PCM card 2 'C-Media USB Headphone Set' device 0 subdevice 0
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 16
  buffer_size  : 512
  period_size  : 128
  period_time  : 2666
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 128
  period_event : 0
  start_threshold  : 128
  stop_threshold   : 512
  silence_threshold: 0
  silence_size : 0
  boundary     : 4611686018427387904
  appl_ptr     : 0
  hw_ptr       : 0
Playing silence
Available: 0, loop iteration: 0, diff: 0, timestamp diff: 6 usec
Available: 144, loop iteration: 2384, diff: 2384, timestamp diff: 2621 usec
Available: 288, loop iteration: 4286, diff: 1902, timestamp diff: 2996 usec
Available: 384, loop iteration: 6134, diff: 1848, timestamp diff: 3063 usec
======= testing hw:2 =======
min_period_size: 48 frames, dir: 0
FIFO size is 0
Hardware PCM card 2 'C-Media USB Headphone Set' device 0 subdevice 0
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 16
  buffer_size  : 512
  period_size  : 128
  period_time  : 2666
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 128
  period_event : 0
  start_threshold  : 128
  stop_threshold   : 512
  silence_threshold: 0
  silence_size : 0
  boundary     : 4611686018427387904
  appl_ptr     : 0
  hw_ptr       : 0
Playing silence
Available: 0, loop iteration: 0, diff: 0, timestamp diff: 5 usec
Available: 144, loop iteration: 2963, diff: 2963, timestamp diff: 3114 usec
Available: 288, loop iteration: 4528, diff: 1565, timestamp diff: 2993 usec
Available: 384, loop iteration: 4943, diff: 415, timestamp diff: 3807 usec
======= testing hw:2 =======
min_period_size: 48 frames, dir: 0
FIFO size is 0
Hardware PCM card 2 'C-Media USB Headphone Set' device 0 subdevice 0
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 16
  buffer_size  : 4096
  period_size  : 128
  period_time  : 2666
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 128
  period_event : 0
  start_threshold  : 128
  stop_threshold   : 4096
  silence_threshold: 0
  silence_size : 0
  boundary     : 4611686018427387904
  appl_ptr     : 0
  hw_ptr       : 0
Playing silence
Available: 0, loop iteration: 0, diff: 0, timestamp diff: 6 usec
Available: 144, loop iteration: 2907, diff: 2907, timestamp diff: 3099 usec
Available: 288, loop iteration: 4192, diff: 1285, timestamp diff: 4498 usec
Available: 384, loop iteration: 4957, diff: 765, timestamp diff: 1496 usec
Available: 528, loop iteration: 5447, diff: 490, timestamp diff: 3017 usec
Available: 672, loop iteration: 6718, diff: 1271, timestamp diff: 5295 usec
Available: 768, loop iteration: 7035, diff: 317, timestamp diff: 701 usec
Available: 912, loop iteration: 8346, diff: 1311, timestamp diff: 4201 usec
Available: 1056, loop iteration: 9278, diff: 932, timestamp diff: 1788 usec
Available: 1152, loop iteration: 9948, diff: 670, timestamp diff: 1996 usec
Available: 1296, loop iteration: 11591, diff: 1643, timestamp diff: 3007 usec
Available: 1440, loop iteration: 12760, diff: 1169, timestamp diff: 2995 usec
Available: 1536, loop iteration: 13759, diff: 999, timestamp diff: 2010 usec
Available: 1680, loop iteration: 15285, diff: 1526, timestamp diff: 2990 usec
Available: 1824, loop iteration: 16887, diff: 1602, timestamp diff: 2998 usec
Available: 1920, loop iteration: 17762, diff: 875, timestamp diff: 2001 usec
Available: 2064, loop iteration: 19287, diff: 1525, timestamp diff: 2996 usec
Available: 2208, loop iteration: 20872, diff: 1585, timestamp diff: 2998 usec
Available: 2304, loop iteration: 21980, diff: 1108, timestamp diff: 2003 usec
Available: 2448, loop iteration: 23677, diff: 1697, timestamp diff: 3014 usec
Available: 2592, loop iteration: 25332, diff: 1655, timestamp diff: 2988 usec
Available: 2688, loop iteration: 26443, diff: 1111, timestamp diff: 1999 usec
Available: 2832, loop iteration: 28060, diff: 1617, timestamp diff: 3007 usec
Available: 2976, loop iteration: 29702, diff: 1642, timestamp diff: 2997 usec
Available: 3072, loop iteration: 30748, diff: 1046, timestamp diff: 1989 usec
Available: 3216, loop iteration: 32351, diff: 1603, timestamp diff: 3006 usec
Available: 3360, loop iteration: 33923, diff: 1572, timestamp diff: 3013 usec
Available: 3456, loop iteration: 34982, diff: 1059, timestamp diff: 1990 usec
Available: 3600, loop iteration: 36595, diff: 1613, timestamp diff: 2999 usec
Available: 3744, loop iteration: 38126, diff: 1531, timestamp diff: 3007 usec
Available: 3840, loop iteration: 39131, diff: 1005, timestamp diff: 1987 usec
Available: 3984, loop iteration: 40743, diff: 1612, timestamp diff: 3004 usec
======= testing hw:2 =======
min_period_size: 48 frames, dir: 0
FIFO size is 0
Hardware PCM card 2 'C-Media USB Headphone Set' device 0 subdevice 0
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 16
  buffer_size  : 32768
  period_size  : 8192
  period_time  : 170666
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 8192
  period_event : 0
  start_threshold  : 8192
  stop_threshold   : 32768
  silence_threshold: 0
  silence_size : 0
  boundary     : 4611686018427387904
  appl_ptr     : 0
  hw_ptr       : 0
Playing silence
Available: 0, loop iteration: 0, diff: 0, timestamp diff: 6 usec
Available: 288, loop iteration: 5758, diff: 5758, timestamp diff: 6060 usec
Available: 576, loop iteration: 8994, diff: 3236, timestamp diff: 5981 usec
Available: 864, loop iteration: 9998, diff: 1004, timestamp diff: 10924 usec
Available: 1152, loop iteration: 10591, diff: 593, timestamp diff: 1078 usec
Available: 1440, loop iteration: 13865, diff: 3274, timestamp diff: 6010 usec
Available: 1728, loop iteration: 16758, diff: 2893, timestamp diff: 5989 usec
Available: 2016, loop iteration: 19899, diff: 3141, timestamp diff: 6001 usec
Available: 2304, loop iteration: 23141, diff: 3242, timestamp diff: 6009 usec
Available: 2592, loop iteration: 26416, diff: 3275, timestamp diff: 5990 usec
Available: 2832, loop iteration: 29733, diff: 3317, timestamp diff: 6001 usec
Available: 3120, loop iteration: 32973, diff: 3240, timestamp diff: 6008 usec
Available: 3408, loop iteration: 36215, diff: 3242, timestamp diff: 5986 usec
Available: 3696, loop iteration: 39013, diff: 2798, timestamp diff: 5002 usec
Available: 3984, loop iteration: 42252, diff: 3239, timestamp diff: 6007 usec
Available: 4272, loop iteration: 45450, diff: 3198, timestamp diff: 5992 usec
Available: 4560, loop iteration: 48762, diff: 3312, timestamp diff: 6000 usec
Available: 4848, loop iteration: 52013, diff: 3251, timestamp diff: 6002 usec
Available: 5136, loop iteration: 55228, diff: 3215, timestamp diff: 5994 usec
Available: 5424, loop iteration: 58508, diff: 3280, timestamp diff: 6003 usec
Available: 5664, loop iteration: 61803, diff: 3295, timestamp diff: 6001 usec
Available: 5952, loop iteration: 65035, diff: 3232, timestamp diff: 5999 usec
Available: 6240, loop iteration: 68285, diff: 3250, timestamp diff: 5997 usec
Available: 6528, loop iteration: 71028, diff: 2743, timestamp diff: 5001 usec
Available: 6816, loop iteration: 74260, diff: 3232, timestamp diff: 6001 usec
Available: 7104, loop iteration: 77483, diff: 3223, timestamp diff: 5998 usec
Available: 7392, loop iteration: 80763, diff: 3280, timestamp diff: 6002 usec
Available: 7680, loop iteration: 83994, diff: 3231, timestamp diff: 5998 usec
Available: 7968, loop iteration: 87264, diff: 3270, timestamp diff: 6000 usec
Available: 8208, loop iteration: 90594, diff: 3330, timestamp diff: 6010 usec
Available: 8496, loop iteration: 93736, diff: 3142, timestamp diff: 5991 usec
Available: 8784, loop iteration: 96978, diff: 3242, timestamp diff: 5999 usec
Available: 9072, loop iteration: 99722, diff: 2744, timestamp diff: 5213 usec
Available: 9360, loop iteration: 102870, diff: 3148, timestamp diff: 5784 usec
Available: 9648, loop iteration: 106131, diff: 3261, timestamp diff: 5999 usec
Available: 9936, loop iteration: 109396, diff: 3265, timestamp diff: 6008 usec
Available: 10176, loop iteration: 112670, diff: 3274, timestamp diff: 5991 usec
Available: 10464, loop iteration: 115949, diff: 3279, timestamp diff: 6003 usec
Available: 10752, loop iteration: 119133, diff: 3184, timestamp diff: 6000 usec
Available: 11040, loop iteration: 121861, diff: 2728, timestamp diff: 5007 usec
Available: 11328, loop iteration: 125087, diff: 3226, timestamp diff: 5991 usec
Available: 11616, loop iteration: 128297, diff: 3210, timestamp diff: 6001 usec
Available: 11904, loop iteration: 131508, diff: 3211, timestamp diff: 6007 usec
Available: 12192, loop iteration: 134751, diff: 3243, timestamp diff: 5992 usec
Available: 12480, loop iteration: 138020, diff: 3269, timestamp diff: 5997 usec
Available: 12720, loop iteration: 141905, diff: 3885, timestamp diff: 6004 usec
Available: 13008, loop iteration: 145912, diff: 4007, timestamp diff: 5995 usec
Available: 13296, loop iteration: 149204, diff: 3292, timestamp diff: 6005 usec
Available: 13584, loop iteration: 151936, diff: 2732, timestamp diff: 5010 usec
Available: 13872, loop iteration: 155234, diff: 3298, timestamp diff: 5984 usec
Available: 14160, loop iteration: 158505, diff: 3271, timestamp diff: 6003 usec
Available: 14448, loop iteration: 161738, diff: 3233, timestamp diff: 6007 usec
Available: 14736, loop iteration: 164654, diff: 2916, timestamp diff: 5994 usec
Available: 15024, loop iteration: 167883, diff: 3229, timestamp diff: 5997 usec
Available: 15312, loop iteration: 171085, diff: 3202, timestamp diff: 6013 usec
Available: 15552, loop iteration: 174292, diff: 3207, timestamp diff: 5985 usec
Available: 15840, loop iteration: 177599, diff: 3307, timestamp diff: 6000 usec
Available: 16128, loop iteration: 180910, diff: 3311, timestamp diff: 6011 usec
Available: 16416, loop iteration: 183632, diff: 2722, timestamp diff: 4986 usec
Available: 16704, loop iteration: 186775, diff: 3143, timestamp diff: 6002 usec
Available: 16992, loop iteration: 190041, diff: 3266, timestamp diff: 6010 usec
Available: 17280, loop iteration: 193280, diff: 3239, timestamp diff: 5988 usec
Available: 17520, loop iteration: 196472, diff: 3192, timestamp diff: 6001 usec
Available: 17808, loop iteration: 199722, diff: 3250, timestamp diff: 5998 usec
Available: 18096, loop iteration: 202932, diff: 3210, timestamp diff: 6001 usec
Available: 18384, loop iteration: 205659, diff: 2727, timestamp diff: 5003 usec
Available: 18672, loop iteration: 208904, diff: 3245, timestamp diff: 5998 usec
Available: 18960, loop iteration: 212209, diff: 3305, timestamp diff: 5999 usec
Available: 19248, loop iteration: 215563, diff: 3354, timestamp diff: 5999 usec
Available: 19536, loop iteration: 218857, diff: 3294, timestamp diff: 6002 usec
Available: 19824, loop iteration: 222209, diff: 3352, timestamp diff: 5997 usec
Available: 20064, loop iteration: 225492, diff: 3283, timestamp diff: 6003 usec
Available: 20352, loop iteration: 228637, diff: 3145, timestamp diff: 5999 usec
Available: 20640, loop iteration: 231919, diff: 3282, timestamp diff: 5998 usec
Available: 20928, loop iteration: 234640, diff: 2721, timestamp diff: 5000 usec
Available: 21216, loop iteration: 237912, diff: 3272, timestamp diff: 6001 usec
Available: 21504, loop iteration: 241208, diff: 3296, timestamp diff: 5996 usec
Available: 21792, loop iteration: 244431, diff: 3223, timestamp diff: 5997 usec
Available: 22080, loop iteration: 247673, diff: 3242, timestamp diff: 6009 usec
Available: 22368, loop iteration: 251092, diff: 3419, timestamp diff: 5997 usec
Available: 22656, loop iteration: 254376, diff: 3284, timestamp diff: 5995 usec
Available: 22896, loop iteration: 257490, diff: 3114, timestamp diff: 6007 usec
Available: 23184, loop iteration: 260712, diff: 3222, timestamp diff: 5997 usec
Available: 23472, loop iteration: 263679, diff: 2967, timestamp diff: 6004 usec
Available: 23760, loop iteration: 266440, diff: 2761, timestamp diff: 4990 usec
Available: 24048, loop iteration: 269745, diff: 3305, timestamp diff: 6001 usec
Available: 24336, loop iteration: 273006, diff: 3261, timestamp diff: 6002 usec
Available: 24576, loop iteration: 276372, diff: 3366, timestamp diff: 5994 usec
Available: 24864, loop iteration: 279501, diff: 3129, timestamp diff: 6011 usec
Available: 25152, loop iteration: 282796, diff: 3295, timestamp diff: 5990 usec
Available: 25440, loop iteration: 285381, diff: 2585, timestamp diff: 5000 usec
Available: 25728, loop iteration: 288446, diff: 3065, timestamp diff: 6002 usec
Available: 26016, loop iteration: 291653, diff: 3207, timestamp diff: 6000 usec
Available: 26304, loop iteration: 294848, diff: 3195, timestamp diff: 5996 usec
Available: 26592, loop iteration: 297995, diff: 3147, timestamp diff: 6014 usec
Available: 26880, loop iteration: 301231, diff: 3236, timestamp diff: 5998 usec
Available: 27168, loop iteration: 304342, diff: 3111, timestamp diff: 5988 usec
Available: 27408, loop iteration: 307349, diff: 3007, timestamp diff: 6007 usec
Available: 27696, loop iteration: 310425, diff: 3076, timestamp diff: 5994 usec
Available: 27984, loop iteration: 313506, diff: 3081, timestamp diff: 5998 usec
Available: 28272, loop iteration: 316100, diff: 2594, timestamp diff: 5011 usec
Available: 28560, loop iteration: 319363, diff: 3263, timestamp diff: 5988 usec
Available: 28848, loop iteration: 322609, diff: 3246, timestamp diff: 6004 usec
Available: 29136, loop iteration: 325623, diff: 3014, timestamp diff: 5995 usec
Available: 29424, loop iteration: 328627, diff: 3004, timestamp diff: 6006 usec
Available: 29712, loop iteration: 331894, diff: 3267, timestamp diff: 5997 usec
Available: 30000, loop iteration: 334955, diff: 3061, timestamp diff: 5999 usec
Available: 30240, loop iteration: 337880, diff: 2925, timestamp diff: 5998 usec
Available: 30528, loop iteration: 341150, diff: 3270, timestamp diff: 6002 usec
Available: 30816, loop iteration: 344292, diff: 3142, timestamp diff: 5996 usec
Available: 31104, loop iteration: 346737, diff: 2445, timestamp diff: 5002 usec
Available: 31392, loop iteration: 349724, diff: 2987, timestamp diff: 6011 usec
Available: 31680, loop iteration: 352886, diff: 3162, timestamp diff: 5991 usec
Available: 31968, loop iteration: 355931, diff: 3045, timestamp diff: 5995 usec
Available: 32256, loop iteration: 359009, diff: 3078, timestamp diff: 6001 usec
Available: 32544, loop iteration: 362272, diff: 3263, timestamp diff: 6009 usec
======= testing hw:2 =======
min_period_size: 48 frames, dir: 0
FIFO size is 0
Hardware PCM card 2 'C-Media USB Headphone Set' device 0 subdevice 0
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 16
  buffer_size  : 4096
  period_size  : 64
  period_time  : 1333
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 64
  period_event : 0
  start_threshold  : 64
  stop_threshold   : 4096
  silence_threshold: 0
  silence_size : 0
  boundary     : 4611686018427387904
  appl_ptr     : 0
  hw_ptr       : 0
Playing silence
Available: 0, loop iteration: 0, diff: 0, timestamp diff: 6 usec
Available: 96, loop iteration: 1671, diff: 1671, timestamp diff: 1727 usec
Available: 144, loop iteration: 2588, diff: 917, timestamp diff: 3541 usec
Available: 192, loop iteration: 2779, diff: 191, timestamp diff: 458 usec
Available: 288, loop iteration: 3828, diff: 1049, timestamp diff: 1994 usec
Available: 336, loop iteration: 4222, diff: 394, timestamp diff: 3783 usec
Available: 384, loop iteration: 4316, diff: 94, timestamp diff: 231 usec
Available: 480, loop iteration: 5226, diff: 910, timestamp diff: 2760 usec
Available: 528, loop iteration: 5863, diff: 637, timestamp diff: 1226 usec
Available: 672, loop iteration: 6775, diff: 912, timestamp diff: 4773 usec
Available: 720, loop iteration: 6894, diff: 119, timestamp diff: 225 usec
Available: 768, loop iteration: 7443, diff: 549, timestamp diff: 991 usec
Available: 864, loop iteration: 8360, diff: 917, timestamp diff: 2109 usec
Available: 912, loop iteration: 8840, diff: 480, timestamp diff: 892 usec
Available: 960, loop iteration: 9398, diff: 558, timestamp diff: 1000 usec
Available: 1056, loop iteration: 10456, diff: 1058, timestamp diff: 2004 usec
Available: 1104, loop iteration: 10986, diff: 530, timestamp diff: 996 usec
Available: 1152, loop iteration: 11505, diff: 519, timestamp diff: 1006 usec
Available: 1248, loop iteration: 12595, diff: 1090, timestamp diff: 1998 usec
Available: 1296, loop iteration: 13082, diff: 487, timestamp diff: 995 usec
Available: 1344, loop iteration: 13574, diff: 492, timestamp diff: 1006 usec
Available: 1440, loop iteration: 14647, diff: 1073, timestamp diff: 1999 usec
Available: 1488, loop iteration: 15160, diff: 513, timestamp diff: 995 usec
Available: 1536, loop iteration: 15689, diff: 529, timestamp diff: 1005 usec
Available: 1632, loop iteration: 16750, diff: 1061, timestamp diff: 1996 usec
Available: 1680, loop iteration: 17284, diff: 534, timestamp diff: 997 usec
Available: 1728, loop iteration: 17817, diff: 533, timestamp diff: 1001 usec
Available: 1824, loop iteration: 18876, diff: 1059, timestamp diff: 2013 usec
Available: 1872, loop iteration: 19381, diff: 505, timestamp diff: 987 usec
Available: 1920, loop iteration: 19905, diff: 524, timestamp diff: 999 usec
Available: 2016, loop iteration: 20952, diff: 1047, timestamp diff: 2005 usec
Available: 2064, loop iteration: 21453, diff: 501, timestamp diff: 996 usec
Available: 2112, loop iteration: 21964, diff: 511, timestamp diff: 1000 usec
Available: 2208, loop iteration: 22971, diff: 1007, timestamp diff: 2011 usec
Available: 2256, loop iteration: 23477, diff: 506, timestamp diff: 990 usec
Available: 2304, loop iteration: 24023, diff: 546, timestamp diff: 999 usec
Available: 2400, loop iteration: 25135, diff: 1112, timestamp diff: 2007 usec
Available: 2448, loop iteration: 25659, diff: 524, timestamp diff: 1000 usec
Available: 2496, loop iteration: 26211, diff: 552, timestamp diff: 992 usec
Available: 2592, loop iteration: 27260, diff: 1049, timestamp diff: 2003 usec
Available: 2640, loop iteration: 27783, diff: 523, timestamp diff: 998 usec
Available: 2688, loop iteration: 28326, diff: 543, timestamp diff: 1006 usec
Available: 2784, loop iteration: 29408, diff: 1082, timestamp diff: 1998 usec
Available: 2832, loop iteration: 29924, diff: 516, timestamp diff: 994 usec
Available: 2880, loop iteration: 30431, diff: 507, timestamp diff: 1008 usec
Available: 2976, loop iteration: 31507, diff: 1076, timestamp diff: 1996 usec
Available: 3024, loop iteration: 32018, diff: 511, timestamp diff: 997 usec
Available: 3072, loop iteration: 32584, diff: 566, timestamp diff: 1000 usec
Available: 3168, loop iteration: 33681, diff: 1097, timestamp diff: 2011 usec
Available: 3216, loop iteration: 34211, diff: 530, timestamp diff: 989 usec
Available: 3264, loop iteration: 34719, diff: 508, timestamp diff: 1006 usec
Available: 3360, loop iteration: 35802, diff: 1083, timestamp diff: 1995 usec
Available: 3408, loop iteration: 36338, diff: 536, timestamp diff: 998 usec
Available: 3456, loop iteration: 36861, diff: 523, timestamp diff: 1002 usec
Available: 3552, loop iteration: 37847, diff: 986, timestamp diff: 1999 usec
Available: 3600, loop iteration: 38394, diff: 547, timestamp diff: 999 usec
Available: 3648, loop iteration: 38933, diff: 539, timestamp diff: 1005 usec
Available: 3744, loop iteration: 39982, diff: 1049, timestamp diff: 1995 usec
Available: 3792, loop iteration: 40542, diff: 560, timestamp diff: 999 usec
Available: 3840, loop iteration: 41078, diff: 536, timestamp diff: 1005 usec
Available: 3936, loop iteration: 42085, diff: 1007, timestamp diff: 1996 usec
Available: 3984, loop iteration: 42616, diff: 531, timestamp diff: 998 usec
Available: 4032, loop iteration: 43143, diff: 527, timestamp diff: 1002 usec

--------------040505040302030501030002
Content-Type: text/x-csrc;
 name="pcm_avail.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="pcm_avail.c"

/*
 *  This extra small demo sends silence to your speakers and tests the precision of the reported position.
 */

#include <asoundlib.h>

#include <stdio.h>
#include <stdlib.h>

const char* device;
const int channels = 2;
const snd_pcm_sframes_t period_size = 64;
const int periods = 64;
const int rate = 48000;


int main(int argc, char* argv[])
{
        int err;
	int failed = 0;
        unsigned int j, j_old;
	short *silence;
	snd_pcm_sframes_t avail = -1;
	snd_pcm_uframes_t min_period_size;
	snd_pcm_uframes_t boundary;
	int dir;
	struct timeval tv_old;

	if (argc != 2) {
		fprintf(stderr, "Usage: %s pcm_name\n", argv[0]);
		exit(EXIT_FAILURE);
	}

	device = argv[1];
	printf("======= testing %s =======\n", device);


        snd_pcm_t *handle;
	snd_output_t *out = NULL;

	snd_pcm_hw_params_t *params;
	snd_pcm_sw_params_t *swparams;

	snd_pcm_hw_params_alloca(&params);
	snd_pcm_sw_params_alloca(&swparams);

	snd_output_stdio_attach(&out, stdout, 0);
	silence = calloc(period_size * periods, sizeof(short) * channels);

	if ((err = snd_pcm_open(&handle, device, SND_PCM_STREAM_PLAYBACK, 0)) < 0) {
		fprintf(stderr, "Playback open error: %s\n", snd_strerror(err));
		exit(EXIT_FAILURE);
	}

	failed =           (err = snd_pcm_hw_params_any(handle, params)) < 0;
	failed = failed || (err = snd_pcm_hw_params_set_rate_resample(handle, params, 1)) < 0;
	failed = failed || (err = snd_pcm_hw_params_set_access(handle, params, SND_PCM_ACCESS_RW_INTERLEAVED)) < 0;
	failed = failed || (err = snd_pcm_hw_params_set_format(handle, params, SND_PCM_FORMAT_S16)) < 0;
	failed = failed || (err = snd_pcm_hw_params_set_channels(handle, params, channels)) < 0;
	failed = failed || (err = snd_pcm_hw_params_set_rate(handle, params, rate, 0)) < 0;

	if (failed) {
		fprintf(stderr, "Playback hwparams (access & format) error: %s\n", snd_strerror(err));
		exit(EXIT_FAILURE);
	}

	err = snd_pcm_hw_params_get_period_size_min(params, &min_period_size, &dir);
	if (err < 0) {
		fprintf(stderr, "Cannot get minimum period size: %s\n", snd_strerror(err));
	}

	printf("min_period_size: %d frames, dir: %d\n", (int)min_period_size, dir);

	failed =           (err = snd_pcm_hw_params_set_period_size(handle, params, period_size, 0)) < 0;
	failed = failed || (err = snd_pcm_hw_params_set_periods(handle, params, periods, 0)) < 0;
	failed = failed || (err = snd_pcm_hw_params(handle, params)) < 0;
	if (failed) {
		fprintf(stderr, "Playback hwparams (period size & periods) error: %s\n", snd_strerror(err));
		exit(EXIT_FAILURE);
	}

	err = snd_pcm_hw_params_get_fifo_size(params);
	if (err < 0) {
		fprintf(stderr, "Playback hwparams: can't get FIFO size, error: %s\n", snd_strerror(err));
	} else {
		printf("FIFO size is %d\n", err);
	}

	failed =           (err = snd_pcm_sw_params_current(handle, swparams)) < 0;
	failed = failed || (err = snd_pcm_sw_params_set_start_threshold(handle, swparams, period_size)) < 0;
	failed = failed || (err = snd_pcm_sw_params_set_avail_min(handle, swparams, period_size)) < 0;
	failed = failed || (err = snd_pcm_sw_params(handle, swparams)) < 0;
	if (failed) {
		fprintf(stderr, "Playback swparams error: %s\n", snd_strerror(err));
		exit(EXIT_FAILURE);
	}

	snd_pcm_dump(handle, out);
	printf("Playing silence\n");
	fflush(stdout);
	memset(silence, 0, period_size * periods * sizeof(short) * channels);
	err = snd_pcm_writei(handle, silence, period_size * periods);
	if (err < 0) {
		fprintf(stderr, "Playback error: %s\n", snd_strerror(err));
		exit(EXIT_FAILURE);
	}

	j = 0;
	j_old = 0;
	gettimeofday(&tv_old, NULL);
	while (1) {
		snd_pcm_sframes_t avail1 = snd_pcm_avail(handle);
		if (avail1 < 0)
			break;
		if (avail != avail1) {
			struct timeval tv;
			gettimeofday(&tv, NULL);
			printf("Available: %d, loop iteration: %d, diff: %d, timestamp diff: %d usec\n", (int)avail1, j, j - j_old,
				(int)((tv.tv_sec - tv_old.tv_sec) * 1000000 + (tv.tv_usec - tv_old.tv_usec)));
			tv_old = tv;
			j_old = j;
		}
		avail = avail1;
		j++;
	}
	snd_pcm_drop(handle);
	snd_pcm_close(handle);

	free(silence);
	return 0;
}

--------------040505040302030501030002
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------040505040302030501030002--
