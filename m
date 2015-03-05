From: Qais Yousef <qais.yousef@imgtec.com>
Subject: Re: [ALSA-LIB][PATCH] Add support for compress offload
 API
Date: Thu, 5 Mar 2015 10:15:24 +0000
Message-ID: <54F82CBC.9010200@imgtec.com>
References: <1425486142-19910-1-git-send-email-qais.yousef@imgtec.com>
 <54F787CF.1030804@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by alsa0.perex.cz (Postfix) with ESMTP id C433B260430
 for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2015 11:15:27 +0100 (CET)
In-Reply-To: <54F787CF.1030804@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 03/04/2015 10:31 PM, Pierre-Louis Bossart wrote:
> I am no lawyer but I think there is work to do on the license and 
> copyright parts, see below.
> -Pierre
>
> On 3/4/15 10:22 AM, Qais Yousef wrote:
>> Merge tinycompress library into alsa-lib using LGPL license.
>> Only function names were modified to match the coding style in alsa-lib,
>> prepending snd_compr to function names and structs.
>>
>> Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
>> Cc: Takashi Iwai <tiwai@suse.de>
>> Cc: Vinod Koul <vinod.koul@intel.com>
>> Cc: Mark Brown <broonie@kernel.org>
>> ---
>>   configure.ac                     |   9 +
>>   include/Makefile.am              |   4 +
>>   include/compress.h               | 245 ++++++++++++++++
>>   include/sound/compress_offload.h | 191 +++++++++++++
>>   include/sound/compress_params.h  | 404 ++++++++++++++++++++++++++
>>   src/Makefile.am                  |   7 +
>>   src/compress/Makefile.am         |   8 +
>>   src/compress/compress.c          | 599 
>> +++++++++++++++++++++++++++++++++++++++
>>   8 files changed, 1467 insertions(+)
>>   create mode 100644 include/compress.h
>>   create mode 100644 include/sound/compress_offload.h
>>   create mode 100644 include/sound/compress_params.h
>>   create mode 100644 src/compress/Makefile.am
>>   create mode 100644 src/compress/compress.c
>>
>> diff --git a/configure.ac b/configure.ac
>> index f0995e3ae787..a768730781e0 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -368,6 +368,9 @@ AC_ARG_ENABLE(mixer,
>>   AC_ARG_ENABLE(pcm,
>>     AS_HELP_STRING([--disable-pcm], [disable the PCM component]),
>>     [build_pcm="$enableval"], [build_pcm="yes"])
>> +AC_ARG_ENABLE(compress,
>> +  AS_HELP_STRING([--disable-compress], [disable the compress 
>> component]),
>> +  [build_compress="$enableval"], [build_compress="yes"])
>>   AC_ARG_ENABLE(rawmidi,
>>     AS_HELP_STRING([--disable-rawmidi], [disable the raw MIDI 
>> component]),
>>     [build_rawmidi="$enableval"], [build_rawmidi="yes"])
>> @@ -418,6 +421,7 @@ AC_SUBST(PYTHON_INCLUDES)
>>
>>   AM_CONDITIONAL([BUILD_MIXER], [test x$build_mixer = xyes])
>>   AM_CONDITIONAL([BUILD_PCM], [test x$build_pcm = xyes])
>> +AM_CONDITIONAL([BUILD_COMPRESS], [test x$build_compress = xyes])
>>   AM_CONDITIONAL([BUILD_RAWMIDI], [test x$build_rawmidi = xyes])
>>   AM_CONDITIONAL([BUILD_HWDEP], [test x$build_hwdep = xyes])
>>   AM_CONDITIONAL([BUILD_SEQ], [test x$build_seq = xyes])
>> @@ -431,6 +435,9 @@ fi
>>   if test "$build_pcm" = "yes"; then
>>     AC_DEFINE([BUILD_PCM], "1", [Build PCM component])
>>   fi
>> +if test "$build_compress" = "yes"; then
>> +  AC_DEFINE([BUILD_COMPRESS], "1", [Build compress component])
>> +fi
>>   if test "$build_rawmidi" = "yes"; then
>>     AC_DEFINE([BUILD_RAWMIDI], "1", [Build raw MIDI component])
>>   fi
>> @@ -641,6 +648,7 @@ AC_OUTPUT(Makefile doc/Makefile 
>> doc/pictures/Makefile doc/doxygen.cfg \
>>         include/Makefile include/sound/Makefile src/Versions 
>> src/Makefile \
>>             src/control/Makefile src/mixer/Makefile \
>>         src/pcm/Makefile src/pcm/scopes/Makefile \
>> +      src/compress/Makefile \
>>         src/rawmidi/Makefile src/timer/Makefile \
>>             src/hwdep/Makefile src/seq/Makefile src/ucm/Makefile \
>>             src/alisp/Makefile \
>> @@ -693,6 +701,7 @@ cat >> include/asoundlib.h <<EOF
>>   #include <alsa/conf.h>
>>   EOF
>>   test "$build_pcm" = "yes" && echo "#include <alsa/pcm.h>" >> 
>> include/asoundlib.h
>> +test "$build_compress" = "yes" && echo "#include <alsa/compress.h>" 
>> >> include/asoundlib.h
>>   test "$build_rawmidi" = "yes" && echo "#include <alsa/rawmidi.h>" 
>> >> include/asoundlib.h
>>   test "$build_pcm" = "yes" && echo "#include <alsa/timer.h>" >> 
>> include/asoundlib.h
>>   test "$build_hwdep" = "yes" && echo "#include <alsa/hwdep.h>" >> 
>> include/asoundlib.h
>> diff --git a/include/Makefile.am b/include/Makefile.am
>> index 4baa03af69e1..395a2ed60d70 100644
>> --- a/include/Makefile.am
>> +++ b/include/Makefile.am
>> @@ -30,6 +30,10 @@ alsainclude_HEADERS += pcm_ioplug.h
>>   endif
>>   endif
>>
>> +if BUILD_COMPRESS
>> +alsainclude_HEADERS += compress.h
>> +endif
>> +
>>   if BUILD_RAWMIDI
>>   alsainclude_HEADERS += rawmidi.h
>>   endif
>> diff --git a/include/compress.h b/include/compress.h
>> new file mode 100644
>> index 000000000000..250ce0c3f7c4
>> --- /dev/null
>> +++ b/include/compress.h
>> @@ -0,0 +1,245 @@
>> +/*
>> + * tinycompress library for compress audio offload in alsa
>> + * Copyright (c) 2011-2012, Intel Corporation.
>> + *
>> + *
>> + * This program is free software; you can redistribute it and/or 
>> modify it
>> + * under the terms and conditions of the GNU Lesser General Public 
>> License,
>> + * version 2.1, as published by the Free Software Foundation.
>> + * Yes last minute update from the kernel.
>> + * This program is distributed in the hope it will be useful, but 
>> WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of 
>> MERCHANTABILITY or
>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public
>> + * License for more details.
>
> It looks like this is pulled from 
> tinycompress/include/tinycompress/tinycompress.h, which was released 
> with a dual BSD and LGPL license. I wonder if you can remove the BSD 
> license really? At the very least you should make it clear where this 
> code came from.

I don't know. I thought 'choosing' the license that applies means 
removing the other. But I am probably being naive here.
I kept the reference to tiny compress. Would add the tinycompress.h 
reference, but I think we have greater issues than that.

>
>> + *
>> + * You should have received a copy of the GNU Lesser General Public 
>> License
>> + * along with this program; if not, write to
>> + * the Free Software Foundation, Inc.,
>> + * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
>> + */
>> +
>> +
>> +#ifndef __ALSA_COMPRESS_H
>> +#define __ALSA_COMPRESS_H
>> +
>> +#include <stdbool.h>
>> +#include <linux/types.h>
>> +
>> +#if defined(__cplusplus)
>> +extern "C" {
>> +#endif
>> +/*
>> + * struct compr_config: config structure, needs to be filled by app
>> + * If fragment_size or fragments are zero, this means "don't care"
>> + * and tinycompress will choose values that the driver supports
>> + *
>> + * @fragment_size: size of fragment requested, in bytes
>> + * @fragments: number of fragments
>> + * @codec: codec type and parameters requested
>> + */
>> +struct snd_compr_config {
>> +    __u32 fragment_size;
>> +    __u32 fragments;
>> +    struct snd_codec *codec;
>> +};
>> +
>> +struct snd_compr_gapless_mdata {
>> +    __u32 encoder_delay;
>> +    __u32 encoder_padding;
>> +};
>> +
>> +#define COMPRESS_OUT        0x20000000
>> +#define COMPRESS_IN         0x10000000
>> +
>> +struct snd_compr;
>> +struct snd_compr_tstamp;
>> +
>> +/*
>> + * snd_compr_open: open a new compress stream
>> + * returns the valid struct snd_compr on success, NULL on failure
>> + * If config does not specify a requested fragment size, on return
>> + * it will be updated with the size and number of fragments that
>> + * were configured
>> + *
>> + * @card: sound card number
>> + * @device: device number
>> + * @flags: device flags can be COMPRESS_OUT or COMPRESS_IN
>> + * @config: stream config requested. Returns actual fragment config
>> + */
>> +struct snd_compr *snd_compr_open(unsigned int card, unsigned int 
>> device,
>> +        unsigned int flags, struct snd_compr_config *config);
>> +
>> +/*
>> + * snd_compr_close: close the compress stream
>> + *
>> + * @compr: compress stream to be closed
>> + */
>> +void snd_compr_close(struct snd_compr *compr);
>> +
>> +/*
>> + * snd_compr_get_hpointer: get the hw timestamp
>> + * return 0 on success, negative on error
>> + *
>> + * @compr: compress stream on which query is made
>> + * @avail: buffer availble for write/read, in bytes
>> + * @tstamp: hw time
>> + */
>> +int snd_compr_get_hpointer(struct snd_compr *compr,
>> +        unsigned int *avail, struct timespec *tstamp);
>> +
>> +
>> +/*
>> + * snd_compr_get_tstamp: get the raw hw timestamp
>> + * return 0 on success, negative on error
>> + *
>> + * @compr: compress stream on which query is made
>> + * @samples: number of decoded samples played
>> + * @sampling_rate: sampling rate of decoded samples
>> + */
>> +int snd_compr_get_tstamp(struct snd_compr *compr,
>> +        unsigned int *samples, unsigned int *sampling_rate);
>> +
>> +/*
>> + * snd_compr_write: write data to the compress stream
>> + * return bytes written on success, negative on error
>> + * By default this is a blocking call and will not return
>> + * until all bytes have been written or there was a
>> + * write error.
>> + * If non-blocking mode has been enabled with snd_compr_nonblock(),
>> + * this function will write all bytes that can be written without
>> + * blocking and will then return the number of bytes successfully
>> + * written. If the return value is not an error and is < size
>> + * the caller can use snd_compr_wait() to block until the driver
>> + * is ready for more data.
>> + *
>> + * @compr: compress stream to be written to
>> + * @buf: pointer to data
>> + * @size: number of bytes to be written
>> + */
>> +int snd_compr_write(struct snd_compr *compr, const void *buf, 
>> unsigned int size);
>> +
>> +/*
>> + * snd_compr_read: read data from the compress stream
>> + * return bytes read on success, negative on error
>> + * By default this is a blocking call and will block until
>> + * size bytes have been written or there was a read error.
>> + * If non-blocking mode was enabled using snd_compr_nonblock()
>> + * the behaviour will change to read only as many bytes as
>> + * are currently available (if no bytes are available it
>> + * will return immediately). The caller can then use
>> + * snd_compr_wait() to block until more bytes are available.
>> + *
>> + * @compr: compress stream from where data is to be read
>> + * @buf: pointer to data buffer
>> + * @size: size of given buffer
>> + */
>> +int snd_compr_read(struct snd_compr *compr, void *buf, unsigned int 
>> size);
>> +
>> +/*
>> + * snd_compr_start: start the compress stream
>> + * return 0 on success, negative on error
>> + *
>> + * @compr: compress stream to be started
>> + */
>> +int snd_compr_start(struct snd_compr *compr);
>> +
>> +/*
>> + * snd_compr_stop: stop the compress stream
>> + * return 0 on success, negative on error
>> + *
>> + * @compr: compress stream to be stopped
>> + */
>> +int snd_compr_stop(struct snd_compr *compr);
>> +
>> +/*
>> + * snd_compr_pause: pause the compress stream
>> + * return 0 on success, negative on error
>> + *
>> + * @compr: compress stream to be paused
>> + */
>> +int snd_compr_pause(struct snd_compr *compr);
>> +
>> +/*
>> + * snd_compr_resume: resume the compress stream
>> + * return 0 on success, negative on error
>> + *
>> + * @compr: compress stream to be resumed
>> + */
>> +int snd_compr_resume(struct snd_compr *compr);
>> +
>> +/*
>> + * snd_compr_drain: drain the compress stream
>> + * return 0 on success, negative on error
>> + *
>> + * @compr: compress stream to be drain
>> + */ Yes last minute update from the kernel.
>> +int snd_compr_drain(struct snd_compr *compr);
>> +
>> +/*
>> + * snd_compr_next_track: set the next track for stream
>> + *
>> + * return 0 on success, negative on error
>> + *
>> + * @compr: compress stream to be transistioned to next track
>> + */
>> +int snd_compr_next_track(struct snd_compr *compr);
>> +
>> +/*
>> + * snd_compr_partial_drain: drain will return after the last frame 
>> is decoded
>> + * by DSP and will play the , All the data written into compressed
>> + * ring buffer is decoded
>> + *
>> + * return 0 on success, negative on error
>> + *
>> + * @compr: compress stream to be drain
>> + */
>> +int snd_compr_partial_drain(struct snd_compr *compr);
>> +
>> +/*
>> + * snd_compr_set_gapless_metadata: set gapless metadYes last minute 
>> update from the kernel.ata of a compress strem
>> + *
>> + * return 0 on success, negative on error
>> + *
>> + * @compr: compress stream for which metadata has to set
>> + * @mdata: metadata encoder delay and  padding
>> + */
>> +
>> +int snd_compr_set_gapless_metadata(struct snd_compr *compr,
>> +            struct snd_compr_gapless_mdata *mdata);
>> +
>> +/*
>> + * snd_compr_is_codec_supported: check if the given codec is supported
>> + * returns true when supported, false if not
>> + *
>> + * @card: sound card number
>> + * @device: device number
>> + * @flags: stream flags
>> + * @codec: codec type and parameters to be checked
>> + */
>> +bool snd_compr_is_codec_supported(unsigned int card, unsigned int 
>> device,
>> +           unsigned int flags, struct snd_codec *codec);
>> +
>> +/*
>> + * snd_compr_set_max_poll_wait: set the maximum time tinycompress
>> + * will wait for driver to signal a poll(). Interval is in
>> + * milliseconds.
>> + * Pass interval of -1 to disable timeout and make poll() wait
>> + * until driver signals.
>> + * If this function is not used the timeout defaults to 20 seconds.
>> + */
>> +void snd_compr_set_max_poll_wait(struct snd_compr *compr, int 
>> milliseconds);
>> +
>> +/* Enable or disable non-blocking mode for write and read */
>> +void snd_compr_nonblock(struct snd_compr *compr, int nonblock);
>> +
>> +/* Wait for ring buffer to ready for next read or write */
>> +int snd_compr_wait(struct snd_compr *compr, int timeout_ms);
>> +
>> +int snd_compr_is_running(struct snd_compr *compr);
>> +
>> +int snd_compr_is_ready(struct snd_compr *compr);
>> +
>> +/* Returns a human readable reason for the last error */
>> +const char *snd_compr_get_error(struct snd_compr *compr);
>> +
>> +#endif
>> diff --git a/include/sound/compress_offload.h 
>> b/include/sound/compress_offload.h
>> new file mode 100644
>> index 000000000000..22ed8cb7800b
>> --- /dev/null
>> +++ b/include/sound/compress_offload.h
>> @@ -0,0 +1,191 @@
>> +/*
>> + *  compress_offload.h - compress offload header definations
>> + *
>> + *  Copyright (C) 2011 Intel Corporation
>> + *  Authors:    Vinod Koul <vinod.koul@linux.intel.com>
>> + *        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> + * 
>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> + *
>> + *  This program is free software; you can redistribute it and/or 
>> modify
>> + *  it under the terms of the GNU General Public License as 
>> published by
>> + *  the Free Software Foundation; version 2 of the License.
>
> So this one is pulled form the kernel and with GPL, not LGPL. Whoa.

Right. I updated this to the latest copy from the kernel before I 
created the final patch. Looking at the commit history other 
include/sound/*.h files were copied from the kernel too with GPL license?
>
>> + *
>> + *  This program is distributed in the hope that it will be useful, but
>> + *  WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + *  General Public License for more details.
>> + *
>> + *  You should have received a copy of the GNU General Public 
>> License along
>> + *  with this program; if not, write to the Free Software 
>> Foundation, Inc.,
>> + *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
>> + *
>> + * 
>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> + *
>> + */
>> +#ifndef __COMPRESS_OFFLOAD_H
>> +#define __COMPRESS_OFFLOAD_H
>> +
>> +#include <linux/types.h>
>> +#include <sound/asound.h>
>> +#include <sound/compress_params.h>
>> +
>> +
>> +#define SNDRV_COMPRESS_VERSION SNDRV_PROTOCOL_VERSION(0, 1, 2)
>> +/**
>> + * struct snd_compressed_buffer - compressed buffer
>> + * @fragment_size: size of buffer fragment in bytes
>> + * @fragments: number of such fragments
>> + */
>> +struct snd_compressed_buffer {
>> +    __u32 fragment_size;
>> +    __u32 fragments;
>> +} __attribute__((packed, aligned(4)));
>> +
>> +/**
>> + * struct snd_compr_params - compressed stream params
>> + * @buffer: buffer description
>> + * @codec: codec parameters
>> + * @no_wake_mode: dont wake on fragment elapsed
>> + */
>> +struct snd_compr_params {
>> +    struct snd_compressed_buffer buffer;
>> +    struct snd_codec codec;
>> +    __u8 no_wake_mode;
>> +} __attribute__((packed, aligned(4)));
>> +
>> +/**
>> + * struct snd_compr_tstamp - timestamp descriptor
>> + * @byte_offset: Byte offset in ring buffer to DSP
>> + * @copied_total: Total number of bytes copied from/to ring buffer 
>> to/by DSP
>> + * @pcm_frames: Frames decoded or encoded by DSP. This field will 
>> evolve by
>> + *    large steps and should only be used to monitor encoding/decoding
>> + *    progress. It shall not be used for timing estimates.
>> + * @pcm_io_frames: Frames rendered or received by DSP into a mixer 
>> or an audio
>> + * output/input. This field should be used for A/V sync or time 
>> estimates.
>> + * @sampling_rate: sampling rate of audio
>> + */
>> +struct snd_compr_tstamp {
>> +    __u32 byte_offset;
>> +    __u32 copied_total;
>> +    __u32 pcm_frames;
>> +    __u32 pcm_io_frames;
>> +    __u32 sampling_rate;
>> +} __attribute__((packed, aligned(4)));
>> +
>> +/**
>> + * struct snd_compr_avail - avail descriptor
>> + * @avail: Number of bytes available in ring buffer for writing/reading
>> + * @tstamp: timestamp infomation
>> + */
>> +struct snd_compr_avail {
>> +    __u64 avail;
>> +    struct snd_compr_tstamp tstamp;
>> +} __attribute__((packed, aligned(4)));
>> +
>> +enum snd_compr_direction {
>> +    SND_COMPRESS_PLAYBACK = 0,
>> +    SND_COMPRESS_CAPTURE
>> +};
>> +
>> +/**
>> + * struct snd_compr_caps - caps descriptor
>> + * @codecs: pointer to array of codecs
>> + * @direction: direction supported. Of type snd_compr_direction
>> + * @min_fragment_size: minimum fragment supported by DSP
>> + * @max_fragment_size: maximum fragment supported by DSP
>> + * @min_fragments: min fragments supported by DSP
>> + * @max_fragments: max fragments supported by DSP
>> + * @num_codecs: number of codecs supported
>> + * @reserved: reserved field
>> + */
>> +struct snd_compr_caps {
>> +    __u32 num_codecs;
>> +    __u32 direction;
>> +    __u32 min_fragment_size;
>> +    __u32 max_fragment_size;
>> +    __u32 min_fragments;
>> +    __u32 max_fragments;
>> +    __u32 codecs[MAX_NUM_CODECS];
>> +    __u32 reserved[11];
>> +} __attribute__((packed, aligned(4)));
>> +
>> +/**
>> + * struct snd_compr_codec_caps - query capability of codec
>> + * @codec: codec for which capability is queried
>> + * @num_descriptors: number of codec descriptors
>> + * @descriptor: array of codec capability descriptor
>> + */
>> +struct snd_compr_codec_caps {
>> +    __u32 codec;
>> +    __u32 num_descriptors;
>> +    struct snd_codec_desc descriptor[MAX_NUM_CODEC_DESCRIPTORS];
>> +} __attribute__((packed, aligned(4)));
>> +
>> +/**
>> + * enum sndrv_compress_encoder
>> + * @SNDRV_COMPRESS_ENCODER_PADDING: no of samples appended by the 
>> encoder at the
>> + * end of the track
>> + * @SNDRV_COMPRESS_ENCODER_DELAY: no of samples inserted by the 
>> encoder at the
>> + * beginning of the track
>> + */
>> +enum sndrv_compress_encoder {
>> +    SNDRV_COMPRESS_ENCODER_PADDING = 1,
>> +    SNDRV_COMPRESS_ENCODER_DELAY = 2,
>> +};
>> +
>> +/**
>> + * struct snd_compr_metadata - compressed stream metadata
>> + * @key: key id
>> + * @value: key value
>> + */
>> +struct snd_compr_metadata {
>> +     __u32 key;
>> +     __u32 value[8];
>> +} __attribute__((packed, aligned(4)));
>> +
>> +/**
>> + * compress path ioctl definitions
>> + * SNDRV_COMPRESS_GET_CAPS: Query capability of DSP
>> + * SNDRV_COMPRESS_GET_CODEC_CAPS: Query capability of a codec
>> + * SNDRV_COMPRESS_SET_PARAMS: Set codec and stream parameters
>> + * Note: only codec params can be changed runtime and stream params 
>> cant be
>> + * SNDRV_COMPRESS_GET_PARAMS: Query codec params
>> + * SNDRV_COMPRESS_TSTAMP: get the current timestamp value
>> + * SNDRV_COMPRESS_AVAIL: get the current buffer avail value.
>> + * This also queries the tstamp properties
>> + * SNDRV_COMPRESS_PAUSE: Pause the running stream
>> + * SNDRV_COMPRESS_RESUME: resume a paused stream
>> + * SNDRV_COMPRESS_START: Start a stream
>> + * SNDRV_COMPRESS_STOP: stop a running stream, discarding ring 
>> buffer content
>> + * and the buffers currently with DSP
>> + * SNDRV_COMPRESS_DRAIN: Play till end of buffers and stop after that
>> + * SNDRV_COMPRESS_IOCTL_VERSION: Query the API version
>> + */
>> +#define SNDRV_COMPRESS_IOCTL_VERSION    _IOR('C', 0x00, int)
>> +#define SNDRV_COMPRESS_GET_CAPS        _IOWR('C', 0x10, struct 
>> snd_compr_caps)
>> +#define SNDRV_COMPRESS_GET_CODEC_CAPS    _IOWR('C', 0x11,\
>> +                        struct snd_compr_codec_caps)
>> +#define SNDRV_COMPRESS_SET_PARAMS    _IOW('C', 0x12, struct 
>> snd_compr_params)
>> +#define SNDRV_COMPRESS_GET_PARAMS    _IOR('C', 0x13, struct snd_codec)
>> +#define SNDRV_COMPRESS_SET_METADATA    _IOW('C', 0x14,\
>> +                         struct snd_compr_metadata)
>> +#define SNDRV_COMPRESS_GET_METADATA    _IOWR('C', 0x15,\
>> +                         struct snd_compr_metadata)
>> +#define SNDRV_COMPRESS_TSTAMP        _IOR('C', 0x20, struct 
>> snd_compr_tstamp)
>> +#define SNDRV_COMPRESS_AVAIL        _IOR('C', 0x21, struct 
>> snd_compr_avail)
>> +#define SNDRV_COMPRESS_PAUSE        _IO('C', 0x30)
>> +#define SNDRV_COMPRESS_RESUME        _IO('C', 0x31)
>> +#define SNDRV_COMPRESS_START        _IO('C', 0x32)
>> +#define SNDRV_COMPRESS_STOP        _IO('C', 0x33)
>> +#define SNDRV_COMPRESS_DRAIN        _IO('C', 0x34)
>> +#define SNDRV_COMPRESS_NEXT_TRACK    _IO('C', 0x35)
>> +#define SNDRV_COMPRESS_PARTIAL_DRAIN    _IO('C', 0x36)
>> +/*
>> + * TODO
>> + * 1. add mmap support
>> + *
>> + */
>> +#define SND_COMPR_TRIGGER_DRAIN 7 /*FIXME move this to pcm.h */
>> +#define SND_COMPR_TRIGGER_NEXT_TRACK 8
>> +#define SND_COMPR_TRIGGER_PARTIAL_DRAIN 9
>> +#endif
>> diff --git a/include/sound/compress_params.h 
>> b/include/sound/compress_params.h
>> new file mode 100644
>> index 000000000000..d9bd9ca0d5b0
>> --- /dev/null
>> +++ b/include/sound/compress_params.h
>> @@ -0,0 +1,404 @@
>> +/*
>> + *  compress_params.h - codec types and parameters for compressed data
>> + *  streaming interface
>> + *
>> + *  Copyright (C) 2011 Intel Corporation
>> + *  Authors:    Pierre-Louis Bossart 
>> <pierre-louis.bossart@linux.intel.com>
>> + *              Vinod Koul <vinod.koul@linux.intel.com>
>> + *
>> + * 
>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> + *
>> + *  This program is free software; you can redistribute it and/or 
>> modify
>> + *  it under the terms of the GNU General Public License as 
>> published by
>> + *  the Free Software Foundation; version 2 of the License.
>
> same here.
>
>> + *
>> + *  This program is distributed in the hope that it will be useful, but
>> + *  WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + *  General Public License for more details.
>> + *
>> + *  You should have received a copy of the GNU General Public 
>> License along
>> + *  with this program; if not, write to the Free Software 
>> Foundation, Inc.,
>> + *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
>> + *
>> + * 
>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> + *
>> + * The definitions in this file are derived from the OpenMAX AL 
>> version 1.1
>> + * and OpenMAX IL v 1.1.2 header files which contain the copyright 
>> notice below.
>> + *
>> + * Copyright (c) 2007-2010 The Khronos Group Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person 
>> obtaining
>> + * a copy of this software and/or associated documentation files (the
>> + * "Materials "), to deal in the Materials without restriction, 
>> including
>> + * without limitation the rights to use, copy, modify, merge, publish,
>> + * distribute, sublicense, and/or sell copies of the Materials, and to
>> + * permit persons to whom the Materials are furnished to do so, 
>> subject to
>> + * the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be 
>> included
>> + * in all copies or substantial portions of the Materials.
>> + *
>> + * THE MATERIALS ARE PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
>> EXPRESS
>> + * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> + * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND 
>> NONINFRINGEMENT.
>> + * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
>> + * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
>> + * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
>> + * MATERIALS OR THE USE OR OTHER DEALINGS IN THE MATERIALS.
>> + *
>> + */
>> +#ifndef __SND_COMPRESS_PARAMS_H
>> +#define __SND_COMPRESS_PARAMS_H
>> + Yes last minute update from the kernel.
>> +#include <linux/types.h>
>> +
>> +/* AUDIO CODECS SUPPORTED */
>> +#define MAX_NUM_CODECS 32
>> +#define MAX_NUM_CODEC_DESCRIPTORS 32
>> +#define MAX_NUM_BITRATES 32
>> +#define MAX_NUM_SAMPLE_RATES 32
>> +
>> +/* Codecs are listed linearly to allow for extensibility */
>> +#define SND_AUDIOCODEC_PCM                   ((__u32) 0x00000001)
>> +#define SND_AUDIOCODEC_MP3                   ((__u32) 0x00000002)
>> +#define SND_AUDIOCODEC_AMR                   ((__u32) 0x00000003)
>> +#define SND_AUDIOCODEC_AMRWB                 ((__u32) 0x00000004)
>> +#define SND_AUDIOCODEC_AMRWBPLUS             ((__u32) 0x00000005)
>> +#define SND_AUDIOCODEC_AAC                   ((__u32) 0x00000006)
>> +#define SND_AUDIOCODEC_WMA                   ((__u32) 0x00000007)
>> +#define SND_AUDIOCODEC_REAL                  ((__u32) 0x00000008)
>> +#define SND_AUDIOCODEC_VORBIS                ((__u32) 0x00000009)
>> +#define SND_AUDIOCODEC_FLAC                  ((__u32) 0x0000000A)
>> +#define SND_AUDIOCODEC_IEC61937              ((__u32) 0x0000000B)
>> +#define SND_AUDIOCODEC_G723_1                ((__u32) 0x0000000C)
>> +#define SND_AUDIOCODEC_G729                  ((__u32) 0x0000000D)
>> +#define SND_AUDIOCODEC_MAX SND_AUDIOCODEC_G729
>> +
>> +/*
>> + * Profile and modes are listed with bit masks. This allows for a
>> + * more compact representation of fields that will not evolve
>> + * (in contrast to the list of codecs)
>> + */
>> +
>> +#define SND_AUDIOPROFILE_PCM                 ((__u32) 0x00000001)
>> +
>> +/* MP3 modes are only useful for encoders */
>> +#define SND_AUDIOCHANMODE_MP3_MONO           ((__u32) 0x00000001)
>> +#define SND_AUDIOCHANMODE_MP3_STEREO         ((__u32) 0x00000002)
>> +#define SND_AUDIOCHANMODE_MP3_JOINTSTEREO    ((__u32) 0x00000004)
>> +#define SND_AUDIOCHANMODE_MP3_DUAL           ((__u32) 0x00000008)
>> +
>> +#define SND_AUDIOPROFILE_AMR                 ((__u32) 0x00000001)
>> +
>> +/* AMR modes are only useful for encoders */
>> +#define SND_AUDIOMODE_AMR_DTX_OFF            ((__u32) 0x00000001)
>> +#define SND_AUDIOMODE_AMR_VAD1               ((__u32) 0x00000002)
>> +#define SND_AUDIOMODE_AMR_VAD2               ((__u32) 0x00000004)
>> +
>> +#define SND_AUDIOSTREAMFORMAT_UNDEFINED         ((__u32) 0x00000000)
>> +#define SND_AUDIOSTREAMFORMAT_CONFORMANCE    ((__u32) 0x00000001)
>> +#define SND_AUDIOSTREAMFORMAT_IF1            ((__u32) 0x00000002)
>> +#define SND_AUDIOSTREAMFORMAT_IF2            ((__u32) 0x00000004)
>> +#define SND_AUDIOSTREAMFORMAT_FSF            ((__u32) 0x00000008)
>> +#define SND_AUDIOSTREAMFORMAT_RTPPAYLOAD     ((__u32) 0x00000010)
>> +#define SND_AUDIOSTREAMFORMAT_ITU            ((__u32) 0x00000020)
>> +
>> +#define SND_AUDIOPROFILE_AMRWB               ((__u32) 0x00000001)
>> +
>> +/* AMRWB modes are only useful for encoders */
>> +#define SND_AUDIOMODE_AMRWB_DTX_OFF          ((__u32) 0x00000001)
>> +#define SND_AUDIOMODE_AMRWB_VAD1             ((__u32) 0x00000002)
>> +#define SND_AUDIOMODE_AMRWB_VAD2             ((__u32) 0x00000004)
>> +
>> +#define SND_AUDIOPROFILE_AMRWBPLUS           ((__u32) 0x00000001)
>> +
>> +#define SND_AUDIOPROFILE_AAC                 ((__u32) 0x00000001)
>> +
>> +/* AAC modes are required for encoders and decoders */
>> +#define SND_AUDIOMODE_AAC_MAIN               ((__u32) 0x00000001)
>> +#define SND_AUDIOMODE_AAC_LC                 ((__u32) 0x00000002)
>> +#define SND_AUDIOMODE_AAC_SSR                ((__u32) 0x00000004)
>> +#define SND_AUDIOMODE_AAC_LTP                ((__u32) 0x00000008)
>> +#define SND_AUDIOMODE_AAC_HE                 ((__u32) 0x00000010)
>> +#define SND_AUDIOMODE_AAC_SCALABLE           ((__u32) 0x00000020)
>> +#define SND_AUDIOMODE_AAC_ERLC               ((__u32) 0x00000040)
>> +#define SND_AUDIOMODE_AAC_LD                 ((__u32) 0x00000080)
>> +#define SND_AUDIOMODE_AAC_HE_PS              ((__u32) 0x00000100)
>> +#define SND_AUDIOMODE_AAC_HE_MPS             ((__u32) 0x00000200)
>> +
>> +/* AAC formats are required for encoders and decoders */
>> +#define SND_AUDIOSTREAMFORMAT_MP2ADTS        ((__u32) 0x00000001)
>> +#define SND_AUDIOSTREAMFORMAT_MP4ADTS        ((__u32) 0x00000002)
>> +#define SND_AUDIOSTREAMFORMAT_MP4LOAS        ((__u32) 0x00000004)
>> +#define SND_AUDIOSTREAMFORMAT_MP4LATM        ((__u32) 0x00000008)
>> +#define SND_AUDIOSTREAMFORMAT_ADIF           ((__u32) 0x00000010)
>> +#define SND_AUDIOSTREAMFORMAT_MP4FF          ((__u32) 0x00000020)
>> +#define SND_AUDIOSTREAMFORMAT_RAW            ((__u32) 0x00000040)
>> +
>> +#define SND_AUDIOPROFILE_WMA7                ((__u32) 0x00000001)
>> +#define SND_AUDIOPROFILE_WMA8                ((__u32) 0x00000002)
>> +#define SND_AUDIOPROFILE_WMA9                ((__u32) 0x00000004)
>> +#define SND_AUDIOPROFILE_WMA10               ((__u32) 0x00000008)
>> +
>> +#define SND_AUDIOMODE_WMA_LEVEL1             ((__u32) 0x00000001)
>> +#define SND_AUDIOMODE_WMA_LEVEL2             ((__u32) 0x00000002)
>> +#define SND_AUDIOMODE_WMA_LEVEL3             ((__u32) 0x00000004)
>> +#define SND_AUDIOMODE_WMA_LEVEL4             ((__u32) 0x00000008)
>> +#define SND_AUDIOMODE_WMAPRO_LEVELM0         ((__u32) 0x00000010)
>> +#define SND_AUDIOMODE_WMAPRO_LEVELM1         ((__u32) 0x00000020)
>> +#define SND_AUDIOMODE_WMAPRO_LEVELM2         ((__u32) 0x00000040)
>> +#define SND_AUDIOMODE_WMAPRO_LEVELM3         ((__u32) 0x00000080)
>> +
>> +#define SND_AUDIOSTREAMFORMAT_WMA_ASF        ((__u32) 0x00000001)
>> +/*
>> + * Some implementations strip the ASF header and only send ASF packets
>> + * to the DSP
>> + */
>> +#define SND_AUDIOSTREAMFORMAT_WMA_NOASF_HDR  ((__u32) 0x00000002)
>> +
>> +#define SND_AUDIOPROFILE_REALAUDIO           ((__u32) 0x00000001)
>> +
>> +#define SND_AUDIOMODE_REALAUDIO_G2           ((__u32) 0x00000001)
>> +#define SND_AUDIOMODE_REALAUDIO_8            ((__u32) 0x00000002)
>> +#define SND_AUDIOMODE_REALAUDIO_10           ((__u32) 0x00000004)
>> +#define SND_AUDIOMODE_REALAUDIO_SURROUND     ((__u32) 0x00000008)
>> +
>> +#define SND_AUDIOPROFILE_VORBIS              ((__u32) 0x00000001)
>> +
>> +#define SND_AUDIOMODE_VORBIS                 ((__u32) 0x00000001)
>> +
>> +#define SND_AUDIOPROFILE_FLAC                ((__u32) 0x00000001)
>> +
>> +/*
>> + * Define quality levels for FLAC encoders, from LEVEL0 (fast)
>> + * to LEVEL8 (best)
>> + */
>> +#define SND_AUDIOMODE_FLAC_LEVEL0            ((__u32) 0x00000001)
>> +#define SND_AUDIOMODE_FLAC_LEVEL1            ((__u32) 0x00000002)
>> +#define SND_AUDIOMODE_FLAC_LEVEL2            ((__u32) 0x00000004)
>> +#define SND_AUDIOMODE_FLAC_LEVEL3            ((__u32) 0x00000008)
>> +#define SND_AUDIOMODE_FLAC_LEVEL4            ((__u32) 0x00000010)
>> +#define SND_AUDIOMODE_FLAC_LEVEL5            ((__u32) 0x00000020)
>> +#define SND_AUDIOMODE_FLAC_LEVEL6            ((__u32) 0x00000040)
>> +#define SND_AUDIOMODE_FLAC_LEVEL7            ((__u32) 0x00000080)
>> +#define SND_AUDIOMODE_FLAC_LEVEL8            ((__u32) 0x00000100)
>> +
>> +#define SND_AUDIOSTREAMFORMAT_FLAC           ((__u32) 0x00000001)
>> +#define SND_AUDIOSTREAMFORMAT_FLAC_OGG       ((__u32) 0x00000002)
>> +
>> +/* IEC61937 payloads without CUVP and preambles */
>> +#define SND_AUDIOPROFILE_IEC61937            ((__u32) 0x00000001)
>> +/* IEC61937 with S/PDIF preambles+CUVP bits in 32-bit containers */
>> +#define SND_AUDIOPROFILE_IEC61937_SPDIF      ((__u32) 0x00000002)
>> +
>> +/*
>> + * IEC modes are mandatory for decoders. Format autodetection
>> + * will only happen on the DSP side with mode 0. The PCM mode should
>> + * not be used, the PCM codec should be used instead.
>> + */
>> +#define SND_AUDIOMODE_IEC_REF_STREAM_HEADER  ((__u32) 0x00000000)
>> +#define SND_AUDIOMODE_IEC_LPCM             ((__u32) 0x00000001)
>> +#define SND_AUDIOMODE_IEC_AC3             ((__u32) 0x00000002)
>> +#define SND_AUDIOMODE_IEC_MPEG1             ((__u32) 0x00000004)
>> +#define SND_AUDIOMODE_IEC_MP3             ((__u32) 0x00000008)
>> +#define SND_AUDIOMODE_IEC_MPEG2             ((__u32) 0x00000010)
>> +#define SND_AUDIOMODE_IEC_AACLC             ((__u32) 0x00000020)
>> +#define SND_AUDIOMODE_IEC_DTS             ((__u32) 0x00000040)
>> +#define SND_AUDIOMODE_IEC_ATRAC             ((__u32) 0x00000080)
>> +#define SND_AUDIOMODE_IEC_SACD             ((__u32) 0x00000100)
>> +#define SND_AUDIOMODE_IEC_EAC3             ((__u32) 0x00000200)
>> +#define SND_AUDIOMODE_IEC_DTS_HD         ((__u32) 0x00000400)
>> +#define SND_AUDIOMODE_IEC_MLP             ((__u32) 0x00000800)
>> +#define SND_AUDIOMODE_IEC_DST             ((__u32) 0x00001000)
>> +#define SND_AUDIOMODE_IEC_WMAPRO         ((__u32) 0x00002000)
>> +#define SND_AUDIOMODE_IEC_REF_CXT            ((__u32) 0x00004000)
>> +#define SND_AUDIOMODE_IEC_HE_AAC         ((__u32) 0x00008000)
>> +#define SND_AUDIOMODE_IEC_HE_AAC2         ((__u32) 0x00010000)
>> +#define SND_AUDIOMODE_IEC_MPEG_SURROUND         ((__u32) 0x00020000)
>> +
>> +#define SND_AUDIOPROFILE_G723_1              ((__u32) 0x00000001)
>> +
>> +#define SND_AUDIOMODE_G723_1_ANNEX_A         ((__u32) 0x00000001)
>> +#define SND_AUDIOMODE_G723_1_ANNEX_B         ((__u32) 0x00000002)
>> +#define SND_AUDIOMODE_G723_1_ANNEX_C         ((__u32) 0x00000004)
>> +
>> +#define SND_AUDIOPROFILE_G729                ((__u32) 0x00000001)
>> +
>> +#define SND_AUDIOMODE_G729_ANNEX_A           ((__u32) 0x00000001)
>> +#define SND_AUDIOMODE_G729_ANNEX_B           ((__u32) 0x00000002)
>> +
>> +/* <FIXME: multichannel encoders aren't supported for now. Would need
>> +   an additional definition of channel arrangement> */
>> +
>> +/* VBR/CBR definitions */
>> +#define SND_RATECONTROLMODE_CONSTANTBITRATE  ((__u32) 0x00000001)
>> +#define SND_RATECONTROLMODE_VARIABLEBITRATE  ((__u32) 0x00000002)
>> +
>> +/* Encoder options */
>> +
>> +struct snd_enc_wma {
>> +    __u32 super_block_align; /* WMA Type-specific data */
>> +};
>> +
>> +
>> +/**
>> + * struct snd_enc_vorbis
>> + * @quality: Sets encoding quality to n, between -1 (low) and 10 
>> (high).
>> + * In the default mode of operation, the quality level is 3.
>> + * Normal quality range is 0 - 10.
>> + * @managed: Boolean. Set  bitrate  management  mode. This turns off 
>> the
>> + * normal VBR encoding, but allows hard or soft bitrate constraints 
>> to be
>> + * enforced by the encoder. This mode can be slower, and may also be
>> + * lower quality. It is primarily useful for streaming.
>> + * @max_bit_rate: Enabled only if managed is TRUE
>> + * @min_bit_rate: Enabled only if managed is TRUE
>> + * @downmix: Boolean. Downmix input from stereo to mono (has no 
>> effect on
>> + * non-stereo streams). Useful for lower-bitrate encoding.
>> + *
>> + * These options were extracted from the OpenMAX IL spec and 
>> Gstreamer vorbisenc
>> + * properties
>> + *
>> + * For best quality users should specify VBR mode and set quality 
>> levels.
>> + */
>> +
>> +struct snd_enc_vorbis {
>> +    __s32 quality;
>> +    __u32 managed;
>> +    __u32 max_bit_rate;
>> +    __u32 min_bit_rate;
>> +    __u32 downmix;
>> +} __attribute__((packed, aligned(4)));
>> +
>> +
>> +/**
>> + * struct snd_enc_real
>> + * @quant_bits: number of coupling quantization bits in the stream
>> + * @start_region: coupling start region in the stream
>> + * @num_regions: number of regions value
>> + *
>> + * These options were extracted from the OpenMAX IL spec
>> + */
>> +
>> +struct snd_enc_real {
>> +    __u32 quant_bits;
>> +    __u32 start_region;
>> +    __u32 num_regions;
>> +} __attribute__((packed, aligned(4)));
>> +
>> +/**
>> + * struct snd_enc_flac
>> + * @num: serial number, valid only for OGG formats
>> + *    needs to be set by application
>> + * @gain: Add replay gain tags
>> + *
>> + * These options were extracted from the FLAC online documentation
>> + * at http://flac.sourceforge.net/documentation_tools_flac.html
>> + *
>> + * To make the API simpler, it is assumed that the user will select 
>> quality
>> + * profiles. Additional options that affect encoding quality and 
>> speed can
>> + * be added at a later stage if needed.
>> + *
>> + * By default the Subset format is used by encoders.
>> + *
>> + * TAGS such as pictures, etc, cannot be handled by an offloaded 
>> encoder and are
>> + * not supported in this API.
>> + */
>> +
>> +struct snd_enc_flac {
>> +    __u32 num;
>> +    __u32 gain;
>> +} __attribute__((packed, aligned(4)));
>> +
>> +struct snd_enc_generic {
>> +    __u32 bw;    /* encoder bandwidth */
>> +    __s32 reserved[15];
>> +} __attribute__((packed, aligned(4)));
>> +
>> +union snd_codec_options {
>> +    struct snd_enc_wma wma;
>> +    struct snd_enc_vorbis vorbis;
>> +    struct snd_enc_real real;
>> +    struct snd_enc_flac flac;
>> +    struct snd_enc_generic generic;
>> +} __attribute__((packed, aligned(4)));
>> +
>> +/** struct snd_codec_desc - description of codec capabilities
>> + * @max_ch: Maximum number of audio channels
>> + * @sample_rates: Sampling rates in Hz, use values like 48000 for this
>> + * @num_sample_rates: Number of valid values in sample_rates array
>> + * @bit_rate: Indexed array containing supported bit rates
>> + * @num_bitrates: Number of valid values in bit_rate array
>> + * @rate_control: value is specified by SND_RATECONTROLMODE defines.
>> + * @profiles: Supported profiles. See SND_AUDIOPROFILE defines.
>> + * @modes: Supported modes. See SND_AUDIOMODE defines
>> + * @formats: Supported formats. See SND_AUDIOSTREAMFORMAT defines
>> + * @min_buffer: Minimum buffer size handled by codec implementation
>> + * @reserved: reserved for future use
>> + *
>> + * This structure provides a scalar value for profiles, modes and 
>> stream
>> + * format fields.
>> + * If an implementation supports multiple combinations, they will be 
>> listed as
>> + * codecs with different descriptors, for example there would be 2 
>> descriptors
>> + * for AAC-RAW and AAC-ADTS.
>> + * This entails some redundancy but makes it easier to avoid invalid
>> + * configurations.
>> + *
>> + */
>> +
>> +struct snd_codec_desc {
>> +    __u32 max_ch;
>> +    __u32 sample_rates[MAX_NUM_SAMPLE_RATES];
>> +    __u32 num_sample_rates;
>> +    __u32 bit_rate[MAX_NUM_BITRATES];
>> +    __u32 num_bitrates;
>> +    __u32 rate_control;
>> +    __u32 profiles;
>> +    __u32 modes;
>> +    __u32 formats;
>> +    __u32 min_buffer;
>> +    __u32 reserved[15];
>> +} __attribute__((packed, aligned(4)));
>> +
>> +/** struct snd_codec
>> + * @id: Identifies the supported audio encoder/decoder.
>> + *        See SND_AUDIOCODEC macros.
>> + * @ch_in: Number of input audio channels
>> + * @ch_out: Number of output channels. In case of contradiction between
>> + *        this field and the channelMode field, the channelMode field
>> + *        overrides.
>> + * @sample_rate: Audio sample rate of input data in Hz, use values 
>> like 48000
>> + *        for this.
>> + * @bit_rate: Bitrate of encoded data. May be ignored by decoders
>> + * @rate_control: Encoding rate control. See SND_RATECONTROLMODE 
>> defines.
>> + *               Encoders may rely on profiles for quality levels.
>> + *         May be ignored by decoders.
>> + * @profile: Mandatory for encoders, can be mandatory for specific
>> + *        decoders as well. See SND_AUDIOPROFILE defines.
>> + * @level: Supported level (Only used by WMA at the moment)
>> + * @ch_mode: Channel mode for encoder. See SND_AUDIOCHANMODE defines
>> + * @format: Format of encoded bistream. Mandatory when defined.
>> + *        See SND_AUDIOSTREAMFORMAT defines.
>> + * @align: Block alignment in bytes of an audio sample.
>> + *        Only required for PCM or IEC formats.
>> + * @options: encoder-specific settings
>> + * @reserved: reserved for future use
>> + */
>> +
>> +struct snd_codec {
>> +    __u32 id;
>> +    __u32 ch_in;
>> +    __u32 ch_out;
>> +    __u32 sample_rate;
>> +    __u32 bit_rate;
>> +    __u32 rate_control;
>> +    __u32 profile;
>> +    __u32 level;
>> +    __u32 ch_mode;
>> +    __u32 format;
>> +    __u32 align;
>> +    union snd_codec_options options;
>> +    __u32 reserved[3];
>> +} __attribute__((packed, aligned(4)));
>> +
>> +#endif
>> diff --git a/src/Makefile.am b/src/Makefile.am
>> index fa255ff43ee0..3930986946cf 100644
>> --- a/src/Makefile.am
>> +++ b/src/Makefile.am
>> @@ -26,6 +26,10 @@ if BUILD_PCM
>>   SUBDIRS += pcm timer
>>   libasound_la_LIBADD += pcm/libpcm.la timer/libtimer.la
>>   endif
>> +if BUILD_COMPRESS
>> +SUBDIRS += compress
>> +libasound_la_LIBADD += compress/libcompress.la
>> +endif
>>   if BUILD_RAWMIDI
>>   SUBDIRS += rawmidi
>>   libasound_la_LIBADD += rawmidi/librawmidi.la
>> @@ -66,6 +70,9 @@ pcm/libpcm.la:
>>   ordinary_pcm/libordinarypcm.la:
>>       $(MAKE) -C ordinary_pcm libordinarypcm.la
>>
>> +pcm/libcompress.la:
>> +    $(MAKE) -C compress libcompress.la
>> +
>>   rawmidi/librawmidi.la:
>>       $(MAKE) -C rawmidi librawmidi.la
>>
>> diff --git a/src/compress/Makefile.am b/src/compress/Makefile.am
>> new file mode 100644
>> index 000000000000..893871ab00a5
>> --- /dev/null
>> +++ b/src/compress/Makefile.am
>> @@ -0,0 +1,8 @@
>> +EXTRA_LTLIBRARIES=libcompress.la
>> +
>> +libcompress_la_SOURCES = compress.c
>> +
>> +all: libcompress.la
>> +
>> +
>> +AM_CPPFLAGS=-I$(top_srcdir)/include
>> diff --git a/src/compress/compress.c b/src/compress/compress.c
>> new file mode 100644
>> index 000000000000..e3fe828f2b1b
>> --- /dev/null
>> +++ b/src/compress/compress.c
>> @@ -0,0 +1,599 @@
>> +/*
>> + * tinycompress library for compress audio offload in alsa
>> + * Copyright (c) 2011-2012, Intel Corporation.
>> + *
>> + *
>> + * This program is free software; you can redistribute it and/or 
>> modify it
>> + * under the terms and conditions of the GNU Lesser General Public 
>> License,
>> + * version 2.1, as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope it will be useful, but 
>> WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of 
>> MERCHANTABILITY or
>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public
>> + * License for more details.
>> + *
>> + * You should have received a copy of the GNU Lesser General Public 
>> License
>> + * along with this program; if not, write to
>> + * the Free Software Foundation, Inc.,
>> + * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
>> + */
>> +
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <fcntl.h>
>> +#include <stdarg.h>
>> +#include <string.h>
>> +#include <errno.h>
>> +#include <unistd.h>
>> +#include <poll.h>
>> +#include <stdbool.h>
>> +#include <sys/ioctl.h>
>> +#include <sys/mman.h>
>> +#include <sys/time.h>
>> +#include <limits.h>
>> +
>> +#include <linux/types.h>
>> +#include <linux/ioctl.h>
>> +#define __force
>> +#define __bitwise
>> +#define __user
>> +#include <sound/asound.h>
>> +#include "sound/compress_params.h"
>> +#include "sound/compress_offload.h"
>> +
>> +#include "compress.h"
>> +
>> +#define COMPR_ERR_MAX 128
>> +
>> +/* Default maximum time we will wait in a poll() - 20 seconds */
>> +#define DEFAULT_MAX_POLL_WAIT_MS    20000
>> +
>> +struct snd_compr {
>> +    int fd;
>> +    unsigned int flags;
>> +    char error[COMPR_ERR_MAX];
>> +    struct snd_compr_config *config;
>> +    int running;
>> +    int max_poll_wait_ms;
>> +    int nonblocking;
>> +    unsigned int gapless_metadata;
>> +    unsigned int next_track;
>> +};
>> +
>> +static int oops(struct snd_compr *compr, int e, const char *fmt, ...)
>> +{
>> +    va_list ap;
>> +    int sz;
>> +
>> +    va_start(ap, fmt);
>> +    vsnprintf(compr->error, COMPR_ERR_MAX, fmt, ap);
>> +    va_end(ap);
>> +    sz = strlen(compr->error);
>> +
>> +    snprintf(compr->error + sz, COMPR_ERR_MAX - sz,
>> +        ": %s", strerror(e));
>> +    errno = e;
>> +
>> +    return -1;
>> +}
>> +
>> +const char *snd_compr_get_error(struct snd_compr *compr)
>> +{
>> +    return compr->error;
>> +}
>> +static struct snd_compr bad_compress = {
>> +    .fd = -1,
>> +};
>> +
>> +int snd_compr_is_running(struct snd_compr *compr)
>> +{
>> +    return ((compr->fd > 0) && compr->running) ? 1 : 0;
>> +}
>> +
>> +int snd_compr_is_ready(struct snd_compr *compr)
>> +{
>> +    return (compr->fd > 0) ? 1 : 0;
>> +}
>> +
>> +static int snd_compr_get_version(struct snd_compr *compr)
>> +{
>> +    int version = 0;
>> +
>> +    if (ioctl(compr->fd, SNDRV_COMPRESS_IOCTL_VERSION, &version)) {
>> +        oops(compr, errno, "cant read version");
>> +        return -1;
>> +    }
>> +    return version;
>> +}
>> +
>> +static bool _snd_compr_snd_compr_is_codec_supported(struct snd_compr 
>> *compr,
>> +        struct snd_compr_config *config, const struct snd_compr_caps 
>> *caps)
>> +{
>> +    bool codec = false;
>> +    unsigned int i;
>> +
>> +    for (i = 0; i < caps->num_codecs; i++) {
>> +        if (caps->codecs[i] == config->codec->id) {
>> +            /* found the codec */
>> +            codec = true;
>> +            break;
>> +        }
>> +    }
>> +    if (codec == false) {
>> +        oops(compr, ENXIO, "this codec is not supported");
>> +        return false;
>> +    }
>> +
>> +    if (config->fragment_size < caps->min_fragment_size) {
>> +        oops(compr, EINVAL, "requested fragment size %d is below min 
>> supported %d",
>> +            config->fragment_size, caps->min_fragment_size);
>> +        return false;
>> +    }
>> +    if (config->fragment_size > caps->max_fragment_size) {
>> +        oops(compr, EINVAL, "requested fragment size %d is above max 
>> supported %d",
>> +            config->fragment_size, caps->max_fragment_size);
>> +        return false;
>> +    }
>> +    if (config->fragments < caps->min_fragments) {
>> +        oops(compr, EINVAL, "requested fragments %d are below min 
>> supported %d",
>> +            config->fragments, caps->min_fragments);
>> +        return false;
>> +    }
>> +    if (config->fragments > caps->max_fragments) {
>> +        oops(compr, EINVAL, "requested fragments %d are above max 
>> supported %d",
>> +            config->fragments, caps->max_fragments);
>> +        return false;
>> +    }
>> +
>> +    /* TODO: match the codec properties */
>> +    return true;
>> +}
>> +
>> +static bool _snd_compr_is_codec_type_supported(int fd, struct 
>> snd_codec *codec)
>> +{
>> +    struct snd_compr_caps caps;
>> +    bool found = false;
>> +    unsigned int i;
>> +
>> +    if (ioctl(fd, SNDRV_COMPRESS_GET_CAPS, &caps)) {
>> +        oops(&bad_compress, errno, "cannot get device caps");
>> +        return false;
>> +    }
>> +
>> +    for (i = 0; i < caps.num_codecs; i++) {
>> +        if (caps.codecs[i] == codec->id) {
>> +            /* found the codec */
>> +            found = true;
>> +            break;
>> +        }
>> +    }
>> +    /* TODO: match the codec properties */
>> +    return found;
>> +}
>> +
>> +static inline void
>> +snd_compr_fill_params(struct snd_compr_config *config, struct 
>> snd_compr_params *params)
>> +{
>> +    params->buffer.fragment_size = config->fragment_size;
>> +    params->buffer.fragments = config->fragments;
>> +    memcpy(&params->codec, config->codec, sizeof(params->codec));
>> +}
>> +
>> +struct snd_compr *snd_compr_open(unsigned int card, unsigned int 
>> device,
>> +        unsigned int flags, struct snd_compr_config *config)
>> +{
>> +    struct snd_compr *compr;
>> +    struct snd_compr_params params;
>> +    struct snd_compr_caps caps;
>> +    char fn[256];
>> +
>> +    if (!config) {
>> +        oops(&bad_compress, EINVAL, "passed bad config");
>> +        return &bad_compress;
>> +    }
>> +
>> +    compr = calloc(1, sizeof(struct snd_compr));
>> +    if (!compr) {
>> +        oops(&bad_compress, errno, "cannot allocate compress object");
>> +        return &bad_compress;
>> +    }
>> +
>> +    compr->next_track = 0;
>> +    compr->gapless_metadata = 0;
>> +    compr->config = calloc(1, sizeof(*config));
>> +    if (!compr->config)
>> +        goto input_fail;
>> +
>> +    snprintf(fn, sizeof(fn), "/dev/snd/comprC%uD%u", card, device);
>> +
>> +    compr->max_poll_wait_ms = DEFAULT_MAX_POLL_WAIT_MS;
>> +
>> +    compr->flags = flags;
>> +    if (!((flags & COMPRESS_OUT) || (flags & COMPRESS_IN))) {
>> +        oops(&bad_compress, EINVAL, "can't deduce device direction 
>> from given flags");
>> +        goto config_fail;
>> +    }
>> +
>> +    if (flags & COMPRESS_OUT) {
>> +        compr->fd = open(fn, O_RDONLY);
>> +    } else {
>> +        compr->fd = open(fn, O_WRONLY);
>> +    }
>> +    if (compr->fd < 0) {
>> +        oops(&bad_compress, errno, "cannot open device '%s'", fn);
>> +        goto config_fail;
>> +    }
>> +
>> +    if (ioctl(compr->fd, SNDRV_COMPRESS_GET_CAPS, &caps)) {
>> +        oops(compr, errno, "cannot get device caps");
>> +        goto codec_fail;
>> +    }
>> +
>> +    /* If caller passed "don't care" fill in default values */
>> +    if ((config->fragment_size == 0) || (config->fragments == 0)) {
>> +        config->fragment_size = caps.min_fragment_size;
>> +        config->fragments = caps.max_fragments;
>> +    }
>> +
>> +#if 0
>> +    /* FIXME need to turn this On when DSP supports
>> +     * and treat in no support case
>> +     */
>> +    if (_snd_compr_snd_compr_is_codec_supported(compr, config, 
>> &caps) == false) {
>> +        oops(compr, errno, "codec not supported\n");
>> +        goto codec_fail;
>> +    }
>> +#endif
>> +
>> +    memcpy(compr->config, config, sizeof(*compr->config));
>> +    snd_compr_fill_params(config, &params);
>> +
>> +    if (ioctl(compr->fd, SNDRV_COMPRESS_SET_PARAMS, &params)) {
>> +        oops(&bad_compress, errno, "cannot set device");
>> +        goto codec_fail;
>> +    }
>> +
>> +    return compr;
>> +
>> +codec_fail:
>> +    close(compr->fd);
>> +    compr->fd = -1;
>> +config_fail:
>> +    free(compr->config);
>> +input_fail:
>> +    free(compr);
>> +    return &bad_compress;
>> +}
>> +
>> +void snd_compr_close(struct snd_compr *compr)
>> +{
>> +    if (compr == &bad_compress)
>> +        return;
>> +
>> +    if (compr->fd >= 0)
>> +        close(compr->fd);
>> +    compr->running = 0;
>> +    compr->fd = -1;
>> +    free(compr->config);
>> +    free(compr);
>> +}
>> +
>> +int snd_compr_get_hpointer(struct snd_compr *compr,
>> +        unsigned int *avail, struct timespec *tstamp)
>> +{
>> +    struct snd_compr_avail kavail;
>> +    __u64 time;
>> +
>> +    if (!snd_compr_is_ready(compr))
>> +        return oops(compr, ENODEV, "device not ready");
>> +
>> +    if (ioctl(compr->fd, SNDRV_COMPRESS_AVAIL, &kavail))
>> +        return oops(compr, errno, "cannot get avail");
>> +    if (0 == kavail.tstamp.sampling_rate)
>> +        return oops(compr, ENODATA, "sample rate unknown");
>> +    *avail = (unsigned int)kavail.avail;
>> +    time = kavail.tstamp.pcm_io_frames / kavail.tstamp.sampling_rate;
>> +    tstamp->tv_sec = time;
>> +    time = kavail.tstamp.pcm_io_frames % kavail.tstamp.sampling_rate;
>> +    tstamp->tv_nsec = time * 1000000000 / kavail.tstamp.sampling_rate;
>> +    return 0;
>> +}
>> +
>> +int snd_compr_get_tstamp(struct snd_compr *compr,
>> +            unsigned int *samples, unsigned int *sampling_rate)
>> +{
>> +    struct snd_compr_tstamp ktstamp;
>> +
>> +    if (!snd_compr_is_ready(compr))
>> +        return oops(compr, ENODEV, "device not ready");
>> +
>> +    if (ioctl(compr->fd, SNDRV_COMPRESS_TSTAMP, &ktstamp))
>> +        return oops(compr, errno, "cannot get tstamp");
>> +
>> +    *samples = ktstamp.pcm_io_frames;
>> +    *sampling_rate = ktstamp.sampling_rate;
>> +    return 0;
>> +}
>> +
>> +int snd_compr_write(struct snd_compr *compr, const void *buf, 
>> unsigned int size)
>> +{
>> +    struct snd_compr_avail avail;
>> +    struct pollfd fds;
>> +    int to_write = 0;    /* zero indicates we haven't written yet */
>> +    int written, total = 0, ret;
>> +    const char* cbuf = buf;
>> +    const unsigned int frag_size = compr->config->fragment_size;
>> +
>> +    if (!(compr->flags & COMPRESS_IN))
>> +        return oops(compr, EINVAL, "Invalid flag set");
>> +    if (!snd_compr_is_ready(compr))
>> +        return oops(compr, ENODEV, "device not ready");
>> +    fds.fd = compr->fd;
>> +    fds.events = POLLOUT;
>> +
>> +    /*TODO: treat auto start here first */
>> +    while (size) {
>> +        if (ioctl(compr->fd, SNDRV_COMPRESS_AVAIL, &avail))
>> +            return oops(compr, errno, "cannot get avail");
>> +
>> +        /* We can write if we have at least one fragment available
>> +         * or there is enough space for all remaining data
>> +         */
>> +        if ((avail.avail < frag_size) && (avail.avail < size)) {
>> +
>> +            if (compr->nonblocking)
>> +                return total;
>> +
>> +            ret = poll(&fds, 1, compr->max_poll_wait_ms);
>> +            if (fds.revents & POLLERR) {
>> +                return oops(compr, EIO, "poll returned error!");
>> +            }
>> +            /* A pause will cause -EBADFD or zero.
>> +             * This is not an error, just stop writing */
>> +            if ((ret == 0) || (ret == -EBADFD))
>> +                break;
>> +            if (ret < 0)
>> +                return oops(compr, errno, "poll error");
>> +            if (fds.revents & POLLOUT) {
>> +                continue;
>> +            }
>> +        }
>> +        /* write avail bytes */
>> +        if (size > avail.avail)
>> +            to_write =  avail.avail;
>> +        else
>> +            to_write = size;
>> +        written = write(compr->fd, cbuf, to_write);
>> +        /* If play was paused the write returns -EBADFD */
>> +        if (written == -EBADFD)
>> +            break;
>> +        if (written < 0)
>> +            return oops(compr, errno, "write failed!");
>> +
>> +        size -= written;
>> +        cbuf += written;
>> +        total += written;
>> +    }
>> +    return total;
>> +}
>> +
>> +int snd_compr_read(struct snd_compr *compr, void *buf, unsigned int 
>> size)
>> +{
>> +    struct snd_compr_avail avail;
>> +    struct pollfd fds;
>> +    int to_read = 0;
>> +    int num_read, total = 0, ret;
>> +    char* cbuf = buf;
>> +    const unsigned int frag_size = compr->config->fragment_size;
>> +
>> +    if (!(compr->flags & COMPRESS_OUT))
>> +        return oops(compr, EINVAL, "Invalid flag set");
>> +    if (!snd_compr_is_ready(compr))
>> +        return oops(compr, ENODEV, "device not ready");
>> +    fds.fd = compr->fd;
>> +    fds.events = POLLIN;
>> +
>> +    while (size) {
>> +        if (ioctl(compr->fd, SNDRV_COMPRESS_AVAIL, &avail))
>> +            return oops(compr, errno, "cannot get avail");
>> +
>> +        if ( (avail.avail < frag_size) && (avail.avail < size) ) {
>> +            /* Less than one fragment available and not at the
>> +             * end of the read, so poll
>> +             */
>> +            if (compr->nonblocking)
>> +                return total;
>> +
>> +            ret = poll(&fds, 1, compr->max_poll_wait_ms);
>> +            if (fds.revents & POLLERR) {
>> +                return oops(compr, EIO, "poll returned error!");
>> +            }
>> +            /* A pause will cause -EBADFD or zero.
>> +             * This is not an error, just stop reading */
>> +            if ((ret == 0) || (ret == -EBADFD))
>> +                break;
>> +            if (ret < 0)
>> +                return oops(compr, errno, "poll error");
>> +            if (fds.revents & POLLIN) {
>> +                continue;
>> +            }
>> +        }
>> +        /* read avail bytes */
>> +        if (size > avail.avail)
>> +            to_read = avail.avail;
>> +        else
>> +            to_read = size;
>> +        num_read = read(compr->fd, cbuf, to_read);
>> +        /* If play was paused the read returns -EBADFD */
>> +        if (num_read == -EBADFD)
>> +            break;
>> +        if (num_read < 0)
>> +            return oops(compr, errno, "read failed!");
>> +
>> +        size -= num_read;
>> +        cbuf += num_read;
>> +        total += num_read;
>> +    }
>> +
>> +    return total;
>> +}
>> +
>> +int snd_compr_start(struct snd_compr *compr)
>> +{
>> +    if (!snd_compr_is_ready(compr))
>> +        return oops(compr, ENODEV, "device not ready");
>> +    if (ioctl(compr->fd, SNDRV_COMPRESS_START))
>> +        return oops(compr, errno, "cannot start the stream");
>> +    compr->running = 1;
>> +    return 0;
>> +
>> +}
>> +
>> +int snd_compr_stop(struct snd_compr *compr)
>> +{
>> +    if (!snd_compr_is_running(compr))
>> +        return oops(compr, ENODEV, "device not ready");
>> +    if (ioctl(compr->fd, SNDRV_COMPRESS_STOP))
>> +        return oops(compr, errno, "cannot stop the stream");
>> +    return 0;
>> +}
>> +
>> +int snd_compr_pause(struct snd_compr *compr)
>> +{
>> +    if (!snd_compr_is_running(compr))
>> +        return oops(compr, ENODEV, "device not ready");
>> +    if (ioctl(compr->fd, SNDRV_COMPRESS_PAUSE))
>> +        return oops(compr, errno, "cannot pause the stream");
>> +    return 0;
>> +}
>> +
>> +int snd_compr_resume(struct snd_compr *compr)
>> +{
>> +    if (ioctl(compr->fd, SNDRV_COMPRESS_RESUME))
>> +        return oops(compr, errno, "cannot resume the stream");
>> +    return 0;
>> +}
>> +
>> +int snd_compr_drain(struct snd_compr *compr)
>> +{
>> +    if (!snd_compr_is_running(compr))
>> +        return oops(compr, ENODEV, "device not ready");
>> +    if (ioctl(compr->fd, SNDRV_COMPRESS_DRAIN))
>> +        return oops(compr, errno, "cannot drain the stream");
>> +    return 0;
>> +}
>> +
>> +int snd_compr_partial_drain(struct snd_compr *compr)
>> +{
>> +    if (!snd_compr_is_running(compr))
>> +        return oops(compr, ENODEV, "device not ready");
>> +
>> +    if (!compr->next_track)
>> +        return oops(compr, EPERM, "next track not signalled");
>> +    if (ioctl(compr->fd, SNDRV_COMPRESS_PARTIAL_DRAIN))
>> +        return oops(compr, errno, "cannot drain the stream\n");
>> +    compr->next_track = 0;
>> +    return 0;
>> +}
>> +
>> +int snd_compr_next_track(struct snd_compr *compr)
>> +{
>> +    if (!snd_compr_is_running(compr))
>> +        return oops(compr, ENODEV, "device not ready");
>> +
>> +    if (!compr->gapless_metadata)
>> +        return oops(compr, EPERM, "metadata not set");
>> +    if (ioctl(compr->fd, SNDRV_COMPRESS_NEXT_TRACK))
>> +        return oops(compr, errno, "cannot set next track\n");
>> +    compr->next_track = 1;
>> +    compr->gapless_metadata = 0;
>> +    return 0;
>> +}
>> +
>> +int snd_compr_set_gapless_metadata(struct snd_compr *compr,
>> +    struct snd_compr_gapless_mdata *mdata)
>> +{
>> +    struct snd_compr_metadata metadata;
>> +    int version;
>> +
>> +    if (!snd_compr_is_ready(compr))
>> +        return oops(compr, ENODEV, "device not ready");
>> +
>> +    version = snd_compr_get_version(compr);
>> +    if (version <= 0)
>> +        return -1;
>> +
>> +    if (version < SNDRV_PROTOCOL_VERSION(0, 1, 1))
>> +        return oops(compr, ENXIO, "gapless apis not supported in 
>> kernel");
>> +
>> +    metadata.key = SNDRV_COMPRESS_ENCODER_PADDING;
>> +    metadata.value[0] = mdata->encoder_padding;
>> +    if (ioctl(compr->fd, SNDRV_COMPRESS_SET_METADATA, &metadata))
>> +        return oops(compr, errno, "can't set metadata for stream\n");
>> +
>> +    metadata.key = SNDRV_COMPRESS_ENCODER_DELAY;
>> +    metadata.value[0] = mdata->encoder_delay;
>> +    if (ioctl(compr->fd, SNDRV_COMPRESS_SET_METADATA, &metadata))
>> +        return oops(compr, errno, "can't set metadata for stream\n");
>> +    compr->gapless_metadata = 1;
>> +    return 0;
>> +}
>> +
>> +bool snd_compr_is_codec_supported(unsigned int card, unsigned int 
>> device,
>> +        unsigned int flags, struct snd_codec *codec)
>> +{
>> +    unsigned int dev_flag;
>> +    bool ret;
>> +    int fd;
>> +    char fn[256];
>> +
>> +    snprintf(fn, sizeof(fn), "/dev/snd/comprC%uD%u", card, device);
>> +
>> +    if (flags & COMPRESS_OUT)
>> +        dev_flag = O_RDONLY;
>> +    else
>> +        dev_flag = O_WRONLY;
>> +
>> +    fd = open(fn, dev_flag);
>> +    if (fd < 0)
>> +        return oops(&bad_compress, errno, "cannot open device '%s'", 
>> fn);
>> +
>> +    ret = _snd_compr_is_codec_type_supported(fd, codec);
>> +
>> +    close(fd);
>> +    return ret;
>> +}
>> +
>> +void snd_compr_set_max_poll_wait(struct snd_compr *compr, int 
>> milliseconds)
>> +{
>> +    compr->max_poll_wait_ms = milliseconds;
>> +}
>> +
>> +void snd_compr_nonblock(struct snd_compr *compr, int nonblock)
>> +{
>> +    compr->nonblocking = !!nonblock;
>> +}
>> +
>> +int snd_compr_wait(struct snd_compr *compr, int timeout_ms)
>> +{
>> +    struct pollfd fds;
>> +    int ret;
>> +
>> +    fds.fd = compr->fd;
>> +    fds.events = POLLOUT | POLLIN;
>> +
>> +    ret = poll(&fds, 1, timeout_ms);
>> +    if (ret > 0) {
>> +        if (fds.revents & POLLERR)
>> +            return oops(compr, EIO, "poll returned error!");
>> +        if (fds.revents & (POLLOUT | POLLIN))
>> +            return 0;
>> +    }
>> +    if (ret == 0)
>> +        return oops(compr, ETIME, "poll timed out");
>> +    if (ret < 0)
>> +        return oops(compr, errno, "poll error");
>> +
>> +    return oops(compr, EIO, "poll signalled unhandled event");
>> +}
>> +
>>
>
