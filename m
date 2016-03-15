From: "Lu, Han" <han.lu@intel.com>
Subject: Re: [PATCH 03/10] alsabat: add tinyalsa support
Date: Tue, 15 Mar 2016 03:50:30 +0000
Message-ID: <B51200AC81AB024499A3C2C9A1BB90A83D3AAE90@SHSMSX101.ccr.corp.intel.com>
References: <cover.1456907242.git.han.lu@intel.com>
 <b80d0a5a176bda9bef10d3611e3eb4dbf47231ef.1456907242.git.han.lu@intel.com>
 <s5ha8m5yueh.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id BA2502605CA
 for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2016 04:50:53 +0100 (CET)
In-Reply-To: <s5ha8m5yueh.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "Gautier, Bernard" <bernard.gautier@intel.com>, "Popescu,
 Edward C" <edward.c.popescu@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Friday, March 11, 2016 10:14 PM
> To: Lu, Han <han.lu@intel.com>
> Cc: liam.r.girdwood@linux.intel.com; Gautier, Bernard
> <bernard.gautier@intel.com>; Popescu, Edward C
> <edward.c.popescu@intel.com>; alsa-devel@alsa-project.org
> Subject: Re: [alsa-devel] [PATCH 03/10] alsabat: add tinyalsa support
> 
> On Wed, 02 Mar 2016 09:53:13 +0100,
> han.lu@intel.com wrote:
> >
> > From: "Lu, Han" <han.lu@intel.com>
> >
> > Add support for alsabat to work on tinyalsa library based platforms
> > such as Android and some Embedded Linux devices.
> > Use option '-t' to select tinyalsa library instead of ALSA library.
> > If '-t' is used while tinyalsa library is not installed in system,
> > alsabat will print error message and quit.
> >
> > Signed-off-by: Lu, Han <han.lu@intel.com>
> 
> Hrm, I don't think it makes so much sense to build a binary bound with both
> libraries.  Usually it's mutual exclusive, the backend is selected / detected via
> configure script.
> 
> 
> thanks,
> 
> Takashi
> 

[han] I agree. I'd like to submit the tinyalsa patches separately, since I need a
little more work to implement the mutual exclusive.

BR,
Han

> >
> > diff --git a/bat/Makefile.am b/bat/Makefile.am index 5646e9a..6101681
> > 100644
> > --- a/bat/Makefile.am
> > +++ b/bat/Makefile.am
> > @@ -21,6 +21,11 @@ alsabat_SOURCES += analyze.c  noinst_HEADERS +=
> > analyze.h  endif
> >
> > +if HAVE_LIBTINYALSA
> > +alsabat_SOURCES += tinyalsa.c
> > +noinst_HEADERS += tinyalsa.h
> > +endif
> > +
> >  AM_CPPFLAGS = \
> >  	      -Wall -I$(top_srcdir)/include
> >
> > diff --git a/bat/alsabat.1 b/bat/alsabat.1 index 5f41669..126232e
> > 100644
> > --- a/bat/alsabat.1
> > +++ b/bat/alsabat.1
> > @@ -106,6 +106,9 @@ Valid range is (DC_THRESHOLD, 40% * Sampling
> rate).
> >  \fI\-p\fP
> >  Total number of periods to play or capture.
> >  .TP
> > +\fI\-t\fP
> > +If tinyalsa lib is installed, use tinyalsa lib instead of alsa lib.
> > +.TP
> >  \fI\-\-log=#\fP
> >  Write stderr and stdout output to this log file.
> >  .TP
> > diff --git a/bat/bat.c b/bat/bat.c
> > index 85ec5aa..8db16c0 100644
> > --- a/bat/bat.c
> > +++ b/bat/bat.c
> > @@ -36,6 +36,9 @@
> >  #ifdef HAVE_LIBFFTW3
> >  #include "analyze.h"
> >  #endif
> > +#ifdef HAVE_LIBTINYALSA
> > +#include "tinyalsa.h"
> > +#endif
> >
> >  static int get_duration(struct bat *bat)  { @@ -125,6 +128,35 @@
> > static void get_format(struct bat *bat, char *optarg)
> >  	}
> >  }
> >
> > +static int get_tiny_format(struct bat *bat, char *alsa_device,
> > +		unsigned int *tiny_card, unsigned int *tiny_device) {
> > +	char *tmp1, *tmp2, *tmp3;
> > +
> > +	if (alsa_device == NULL)
> > +		goto fail;
> > +
> > +	tmp1 = strchr(alsa_device, ':');
> > +	if (tmp1 == NULL)
> > +		goto fail;
> > +
> > +	tmp3 = tmp1 + 1;
> > +	tmp2 = strchr(tmp3, ',');
> > +	if (tmp2 == NULL)
> > +		goto fail;
> > +
> > +	tmp1 = tmp2 + 1;
> > +	*tiny_device = atoi(tmp1);
> > +	*tmp2 = '\0';
> > +	*tiny_card = atoi(tmp3);
> > +	*tmp2 = ',';
> > +
> > +	return 0;
> > +fail:
> > +	fprintf(bat->err, _("Invalid tiny format!\n"));
> > +	return -EINVAL;
> > +}
> > +
> >  static inline int thread_wait_completion(struct bat *bat,
> >  		pthread_t id, int **val)
> >  {
> > @@ -287,6 +319,7 @@ _("Usage: alsabat [-options]...\n"
> >  "  -k                     parameter for frequency detecting threshold\n"
> >  "  -F                     target frequency\n"
> >  "  -p                     total number of periods to play/capture\n"
> > +"  -t                     use tinyalsa instead of alsa\n"
> >  "      --log=#            file that both stdout and strerr redirecting to\n"
> >  "      --file=#           file for playback\n"
> >  "      --saveplay=#       file that storing playback content, for debug\n"
> > @@ -330,6 +363,7 @@ static void set_defaults(struct bat *bat)
> >  	bat->period_is_limited = false;
> >  	bat->log = stdout;
> >  	bat->err = stderr;
> > +	bat->tinyalsa = false;
> >  }
> >
> >  static void parse_arguments(struct bat *bat, int argc, char *argv[])
> > @@ -406,6 +440,16 @@ static void parse_arguments(struct bat *bat, int
> argc, char *argv[])
> >  			bat->periods_total = atoi(optarg);
> >  			bat->period_is_limited = true;
> >  			break;
> > +		case 't':
> > +#ifdef HAVE_LIBTINYALSA
> > +			bat->playback.fct = &playback_tinyalsa;
> > +			bat->capture.fct = &record_tinyalsa;
> > +			bat->tinyalsa = true;
> > +#else
> > +			fprintf(bat->err, _("tinyalsa lib is not installed\n"));
> > +			exit(EXIT_FAILURE);
> > +#endif
> > +			break;
> >  		case 'h':
> >  		default:
> >  			usage(bat);
> > @@ -484,6 +528,24 @@ static int bat_init(struct bat *bat)
> >  	if (bat->playback.device == NULL && bat->capture.device == NULL)
> >  		bat->playback.device = bat->capture.device =
> DEFAULT_DEV_NAME;
> >
> > +	/* Determine tiny device if needed */
> > +	if (bat->tinyalsa == true) {
> > +		if (bat->playback.mode != MODE_SINGLE) {
> > +			err = get_tiny_format(bat, bat->capture.device,
> > +					&bat->capture.card_tiny,
> > +					&bat->capture.device_tiny);
> > +			if (err < 0)
> > +				return err;
> > +		}
> > +		if (bat->capture.mode != MODE_SINGLE) {
> > +			err = get_tiny_format(bat, bat->playback.device,
> > +					&bat->playback.card_tiny,
> > +					&bat->playback.device_tiny);
> > +			if (err < 0)
> > +				return err;
> > +		}
> > +	}
> > +
> >  	/* Determine capture file */
> >  	if (bat->local) {
> >  		bat->capture.file = bat->playback.file; diff --git
> a/bat/common.c
> > b/bat/common.c index 798b00b..bbf969e 100644
> > --- a/bat/common.c
> > +++ b/bat/common.c
> > @@ -18,16 +18,39 @@
> >  #include <stdlib.h>
> >  #include <stdbool.h>
> >  #include <errno.h>
> > +#include <signal.h>
> >
> >  #include "aconfig.h"
> >  #include "gettext.h"
> >
> >  #include "common.h"
> >  #include "alsa.h"
> > +#include "bat-signal.h"
> >
> >  int retval_play;
> >  int retval_record;
> >
> > +int is_capturing = 1;
> > +int is_playing = 1;
> > +
> > +/**
> > + * Handling of Ctrl-C for capture
> > + */
> > +void sigint_handler(int sig)
> > +{
> > +	is_capturing = 0;
> > +}
> > +
> > +/**
> > + * Handling of Ctrl-C for playback
> > + */
> > +void stream_close(int sig)
> > +{
> > +	/* allow the stream to be closed gracefully */
> > +	signal(sig, SIG_IGN);
> > +	is_playing = 0;
> > +}
> > +
> >  /* update chunk_fmt data to bat */
> >  static int update_fmt_to_bat(struct bat *bat, struct chunk_fmt *fmt)
> > { @@ -196,3 +219,69 @@ int write_wav_header(FILE *fp, struct
> > wav_container *wav, struct bat *bat)
> >
> >  	return 0;
> >  }
> > +
> > +/* update wav header when data size changed */ int
> > +update_wav_header(struct bat *bat, FILE *fp, int bytes) {
> > +	int err = 0;
> > +	struct wav_container wav;
> > +
> > +	prepare_wav_info(&wav, bat);
> > +	wav.chunk.length = bytes;
> > +	wav.header.length = (wav.chunk.length) + sizeof(wav.chunk)
> > +		+ sizeof(wav.format) + sizeof(wav.header) - 8;
> > +	rewind(fp);
> > +	err = write_wav_header(fp, &wav, bat);
> > +
> > +	return err;
> > +}
> > +
> > +/*
> > + * Generate buffer to be played either from input file or from
> > +generated data
> > + * Return value
> > + * <0 error
> > + * 0 ok
> > + * >0 break
> > + */
> > +int generate_input_data0(struct bat *bat, void *buffer, int bytes,
> > +int frames) {
> > +	int err;
> > +	static int load;
> > +
> > +	if (bat->playback.file != NULL) {
> > +		/* From input file */
> > +		load = 0;
> > +
> > +		while (1) {
> > +			err = fread(buffer + load, 1, bytes - load, bat->fp);
> > +			if (0 == err) {
> > +				if (feof(bat->fp)) {
> > +					fprintf(bat->log,
> > +							_("End of
> playing.\n"));
> > +					return 1;
> > +				}
> > +			} else if (err < bytes - load) {
> > +				if (ferror(bat->fp)) {
> > +					fprintf(bat->err, _("Read file error"));
> > +					fprintf(bat->err, _(": %d\n"), err);
> > +					return -EIO;
> > +				}
> > +				load += err;
> > +			} else {
> > +				break;
> > +			}
> > +		}
> > +	} else {
> > +		/* Generate sine wave */
> > +		if ((bat->sinus_duration) && (load > bat->sinus_duration))
> > +			return 1;
> > +
> > +		err = generate_sine_wave(bat, frames, buffer);
> > +		if (err != 0)
> > +			return err;
> > +
> > +		load += frames;
> > +	}
> > +
> > +	return 0;
> > +}
> > diff --git a/bat/common.h b/bat/common.h index 30e39fc..0d92a8d 100644
> > --- a/bat/common.h
> > +++ b/bat/common.h
> > @@ -14,6 +14,9 @@
> >   */
> >
> >  #include <alsa/asoundlib.h>
> > +#ifdef HAVE_LIBTINYALSA
> > +#include <tinyalsa/asoundlib.h>
> > +#endif
> >
> >  #define TEMP_RECORD_FILE_NAME		"/tmp/bat.wav.XXXXXX"
> >  #define DEFAULT_DEV_NAME		"default"
> > @@ -119,6 +122,8 @@ enum _bat_op_mode {
> >
> >  struct pcm {
> >  	char *device;
> > +	unsigned int card_tiny;
> > +	unsigned int device_tiny;
> >  	char *file;
> >  	enum _bat_op_mode mode;
> >  	void *(*fct)(struct bat *);
> > @@ -171,6 +176,8 @@ struct bat {
> >  	void *buf;			/* PCM Buffer */
> >
> >  	bool local;			/* true for internal test */
> > +
> > +	bool tinyalsa;			/* true to use tinyalsa lib */
> >  };
> >
> >  struct analyze {
> > @@ -180,6 +187,10 @@ struct analyze {
> >  	double *mag;
> >  };
> >
> > +void sigint_handler(int);
> > +void stream_close(int);
> >  void prepare_wav_info(struct wav_container *, struct bat *);  int
> > read_wav_header(struct bat *, char *, FILE *, bool);  int
> > write_wav_header(FILE *, struct wav_container *, struct bat *);
> > +int update_wav_header(struct bat *, FILE *, int); int
> > +generate_input_data0(struct bat *, void *, int, int);
> > diff --git a/bat/tinyalsa.c b/bat/tinyalsa.c new file mode 100644
> > index 0000000..ab11247
> > --- /dev/null
> > +++ b/bat/tinyalsa.c
> > @@ -0,0 +1,422 @@
> > +/*
> > + * Copyright (C) 2013-2015 Intel Corporation
> > + *
> > + * This program is free software; you can redistribute it and/or
> > +modify
> > + * it under the terms of the GNU General Public License as published
> > +by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + */
> > +
> > +#include <stdio.h>
> > +#include <string.h>
> > +#include <stdbool.h>
> > +#include <signal.h>
> > +#include <pthread.h>
> > +#include <errno.h>
> > +
> > +#include <tinyalsa/asoundlib.h>
> > +
> > +#include "aconfig.h"
> > +#include "gettext.h"
> > +
> > +#include "common.h"
> > +#include "tinyalsa.h"
> > +
> > +struct format_map_table {
> > +	int sample_bytes;
> > +	enum pcm_format format;
> > +};
> > +
> > +static struct format_map_table map_tables[] = {
> > +	{ 2, PCM_FORMAT_S16_LE },
> > +	{ 4, PCM_FORMAT_S32_LE },
> > +	{}
> > +};
> > +
> > +/**
> > + * Called when thread is finished
> > + */
> > +static void close_handle(void *handle) {
> > +	struct pcm *pcm = handle;
> > +
> > +	if (NULL != pcm)
> > +		pcm_close(pcm);
> > +}
> > +
> > +static int format_convert(struct bat *bat, struct pcm_config *config)
> > +{
> > +	struct format_map_table *t = map_tables;
> > +
> > +	for (; t->sample_bytes; t++) {
> > +		if (t->sample_bytes == bat->sample_size) {
> > +			config->format = t->format;
> > +			return 0;
> > +		}
> > +	}
> > +
> > +	fprintf(bat->err, _("Invalid format!\n"));
> > +	return -EINVAL;
> > +}
> > +
> > +static int init_config(struct bat *bat, struct pcm_config *config) {
> > +	config->channels = bat->channels;
> > +	config->rate = bat->rate;
> > +	config->period_size = 1024;
> > +	config->period_count = 4;
> > +	config->start_threshold = 0;
> > +	config->stop_threshold = 0;
> > +	config->silence_threshold = 0;
> > +
> > +	return format_convert(bat, config);
> > +}
> > +
> > +/**
> > + * Check that a parameter is inside bounds  */ static int
> > +check_param(struct bat *bat, struct pcm_params *params,
> > +		unsigned int param, unsigned int value,
> > +		char *param_name, char *param_unit) {
> > +	unsigned int min;
> > +	unsigned int max;
> > +	int ret = 0;
> > +
> > +	min = pcm_params_get_min(params, param);
> > +	if (value < min) {
> > +		fprintf(bat->err,
> > +			_("%s is %u%s, device only supports >= %u%s!\n"),
> > +			param_name, value, param_unit, min, param_unit);
> > +		ret = -EINVAL;
> > +	}
> > +
> > +	max = pcm_params_get_max(params, param);
> > +	if (value > max) {
> > +		fprintf(bat->err,
> > +			_("%s is %u%s, device only supports <= %u%s!\n"),
> > +			param_name, value, param_unit, max, param_unit);
> > +		ret = -EINVAL;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +/**
> > + * Check all parameters
> > + */
> > +static int check_playback_params(struct bat *bat,
> > +		struct pcm_config *config)
> > +{
> > +	struct pcm_params *params;
> > +	unsigned int card = bat->playback.card_tiny;
> > +	unsigned int device = bat->playback.device_tiny;
> > +	int err = 0;
> > +
> > +	params = pcm_params_get(card, device, PCM_OUT);
> > +	if (params == NULL) {
> > +		fprintf(bat->err, _("Unable to open PCM device %u!\n"),
> > +				device);
> > +		return -EINVAL;
> > +	}
> > +
> > +	err = check_param(bat, params, PCM_PARAM_RATE,
> > +			config->rate, "Sample rate", "Hz");
> > +	if (err < 0)
> > +		goto exit;
> > +	err = check_param(bat, params, PCM_PARAM_CHANNELS,
> > +			config->channels, "Sample", " channels");
> > +	if (err < 0)
> > +		goto exit;
> > +	err = check_param(bat, params, PCM_PARAM_SAMPLE_BITS,
> > +			bat->sample_size * 8, "Bitrate", " bits");
> > +	if (err < 0)
> > +		goto exit;
> > +	err = check_param(bat, params, PCM_PARAM_PERIOD_SIZE,
> > +			config->period_size, "Period size", "Hz");
> > +	if (err < 0)
> > +		goto exit;
> > +	err = check_param(bat, params, PCM_PARAM_PERIODS,
> > +			config->period_count, "Period count", "Hz");
> > +	if (err < 0)
> > +		goto exit;
> > +
> > +exit:
> > +	pcm_params_free(params);
> > +
> > +	return err;
> > +}
> > +
> > +/**
> > + * Play sample
> > + */
> > +static int play_sample(struct bat *bat, struct pcm *pcm,
> > +		void *buffer, int bytes)
> > +{
> > +	int err = 0;
> > +	FILE *fp = NULL;
> > +	int frames = bytes / bat->frame_size;
> > +	int bytes_total = 0;
> > +
> > +	if (bat->debugplay) {
> > +		fp = fopen(bat->debugplay, "wb");
> > +		if (fp == NULL) {
> > +			fprintf(bat->err, _("Cannot open file for capture: "));
> > +			fprintf(bat->err, _("%s %d\n"), bat->debugplay, -
> errno);
> > +			return -errno;
> > +		}
> > +		/* leave space for file header */
> > +		if (fseek(fp, sizeof(struct wav_container), SEEK_SET) != 0) {
> > +			fclose(fp);
> > +			return -errno;
> > +		}
> > +	}
> > +
> > +	do {
> > +		err = generate_input_data0(bat, buffer, bytes, frames);
> > +		if (err != 0)
> > +			break;
> > +
> > +		if (bat->debugplay) {
> > +			if (fwrite(buffer, 1, bytes, fp) != bytes) {
> > +				update_wav_header(bat, fp, bytes_total);
> > +				fclose(fp);
> > +				return -EIO;
> > +			}
> > +			bytes_total += bytes;
> > +		}
> > +
> > +		bat->periods_played++;
> > +		if (bat->period_is_limited
> > +				&& bat->periods_played >= bat-
> >periods_total)
> > +			break;
> > +
> > +		err = pcm_write(pcm, buffer, bytes);
> > +		if (err != 0) {
> > +			fprintf(bat->err, _("Write PCM device error: %d\n"),
> > +					err);
> > +			break;
> > +		}
> > +	} while (is_playing);
> > +
> > +	if (bat->debugplay) {
> > +		err = update_wav_header(bat, fp, bytes_total);
> > +		fclose(fp);
> > +	}
> > +	return err;
> > +}
> > +
> > +/**
> > + * Play
> > + */
> > +void *playback_tinyalsa(struct bat *bat) {
> > +	int err = 0;
> > +	struct pcm_config config;
> > +	struct pcm *pcm = NULL;
> > +	void *buffer = NULL;
> > +	int bufbytes;
> > +	unsigned int card = bat->playback.card_tiny;
> > +	unsigned int device = bat->playback.device_tiny;
> > +
> > +	fprintf(bat->log, _("Entering playback thread (tinyalsa).\n"));
> > +
> > +	retval_play = 0;
> > +
> > +	/* init config */
> > +	err = init_config(bat, &config);
> > +	if (err < 0) {
> > +		retval_play = err;
> > +		goto exit1;
> > +	}
> > +
> > +	/* check param before open device */
> > +	err = check_playback_params(bat, &config);
> > +	if (err < 0) {
> > +		retval_play = err;
> > +		goto exit1;
> > +	}
> > +
> > +	/* init device */
> > +	pcm = pcm_open(card, device, PCM_OUT, &config);
> > +	if (!pcm || !pcm_is_ready(pcm)) {
> > +		fprintf(bat->err, _("Unable to open PCM device %u (%s)!\n"),
> > +				device, pcm_get_error(pcm));
> > +		retval_play = -EINVAL;
> > +		goto exit1;
> > +	}
> > +
> > +	/* init buffer */
> > +	bufbytes = pcm_frames_to_bytes(pcm, pcm_get_buffer_size(pcm));
> > +	buffer = malloc(bufbytes);
> > +	if (!buffer) {
> > +		retval_play = -ENOMEM;
> > +		goto exit2;
> > +	}
> > +
> > +	/* init playback source */
> > +	if (bat->playback.file == NULL) {
> > +		fprintf(bat->log, _("Playing generated audio sine wave"));
> > +		bat->sinus_duration == 0 ?
> > +			fprintf(bat->log, _(" endlessly\n")) :
> > +			fprintf(bat->log, _("\n"));
> > +	} else {
> > +		fprintf(bat->log, _("Playing input audio file: %s\n"),
> > +				bat->playback.file);
> > +		bat->fp = fopen(bat->playback.file, "rb");
> > +		if (bat->fp == NULL) {
> > +			fprintf(bat->err, _("Cannot open file for playback: "));
> > +			fprintf(bat->err, _("%s %d\n"),
> > +					bat->playback.file, -errno);
> > +			retval_play = -errno;
> > +			goto exit3;
> > +		}
> > +		/* Skip header */
> > +		err = read_wav_header(bat, bat->playback.file, bat->fp,
> true);
> > +		if (err != 0) {
> > +			retval_play = err;
> > +			goto exit4;
> > +		}
> > +	}
> > +
> > +	/* catch ctrl-c to shutdown cleanly */
> > +	signal(SIGINT, stream_close);
> > +
> > +	err = play_sample(bat, pcm, buffer, bufbytes);
> > +	if (err < 0) {
> > +		retval_play = err;
> > +		goto exit4;
> > +	}
> > +
> > +exit4:
> > +	if (bat->playback.file)
> > +		fclose(bat->fp);
> > +exit3:
> > +	free(buffer);
> > +exit2:
> > +	pcm_close(pcm);
> > +exit1:
> > +	pthread_exit(&retval_play);
> > +}
> > +
> > +/**
> > + * Capture sample
> > + */
> > +static int capture_sample(struct bat *bat, struct pcm *pcm,
> > +		void *buffer, unsigned int bytes)
> > +{
> > +	int err = 0;
> > +	FILE *fp = NULL;
> > +	unsigned int bytes_read = 0;
> > +	unsigned int bytes_count = bat->frames * bat->frame_size;
> > +
> > +	remove(bat->capture.file);
> > +	fp = fopen(bat->capture.file, "wb");
> > +	if (fp == NULL) {
> > +		fprintf(bat->err, _("Cannot open file for capture: %s %d\n"),
> > +				bat->capture.file, -errno);
> > +		return -errno;
> > +	}
> > +	/* leave space for file header */
> > +	if (fseek(fp, sizeof(struct wav_container), SEEK_SET) != 0) {
> > +		fclose(fp);
> > +		return -errno;
> > +	}
> > +
> > +	while (bytes_read < bytes_count && is_capturing
> > +			&& !pcm_read(pcm, buffer, bytes)) {
> > +		if (fwrite(buffer, 1, bytes, fp) != bytes)
> > +			break;
> > +
> > +		bytes_read += bytes;
> > +
> > +		bat->periods_played++;
> > +
> > +		if (bat->period_is_limited
> > +				&& bat->periods_played >= bat-
> >periods_total)
> > +			break;
> > +	}
> > +
> > +	err = update_wav_header(bat, fp, bytes_read);
> > +
> > +	fclose(fp);
> > +	return err;
> > +}
> > +
> > +/**
> > + * Record
> > + */
> > +void *record_tinyalsa(struct bat *bat) {
> > +	int err = 0;
> > +	struct pcm_config config;
> > +	struct pcm *pcm;
> > +	void *buffer;
> > +	unsigned int bufbytes;
> > +
> > +	pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, NULL);
> > +
> > +	fprintf(bat->log, _("Entering capture thread (tinyalsa).\n"));
> > +
> > +	retval_record = 0;
> > +
> > +	/* init config */
> > +	err = init_config(bat, &config);
> > +	if (err < 0) {
> > +		retval_record = err;
> > +		goto exit1;
> > +	}
> > +
> > +	/* init device */
> > +	pcm = pcm_open(bat->capture.card_tiny, bat->capture.device_tiny,
> > +			PCM_IN, &config);
> > +	if (!pcm || !pcm_is_ready(pcm)) {
> > +		fprintf(bat->err, _("Unable to open PCM device (%s)!\n"),
> > +				pcm_get_error(pcm));
> > +		retval_record = -EINVAL;
> > +		goto exit1;
> > +	}
> > +
> > +	/* init buffer */
> > +	bufbytes = pcm_frames_to_bytes(pcm, pcm_get_buffer_size(pcm));
> > +	buffer = malloc(bufbytes);
> > +	if (!buffer) {
> > +		retval_record = -ENOMEM;
> > +		goto exit2;
> > +	}
> > +
> > +	/* install signal handler and begin capturing Ctrl-C */
> > +	signal(SIGINT, sigint_handler);
> > +
> > +	pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, NULL);
> > +	pthread_setcanceltype(PTHREAD_CANCEL_DEFERRED, NULL);
> > +	pthread_cleanup_push(close_handle, pcm);
> > +	pthread_cleanup_push(free, buffer);
> > +
> > +	fprintf(bat->log, _("Recording ...\n"));
> > +	err = capture_sample(bat, pcm, buffer, bufbytes);
> > +	if (err != 0) {
> > +		retval_record = err;
> > +		goto exit3;
> > +	}
> > +
> > +	/* Normally we will never reach this part of code (unless error in
> > +	 * previous call) (before exit3) as this thread will be cancelled
> > +	 *  by end of play thread. Except in single line mode. */
> > +	pthread_cleanup_pop(0);
> > +	pthread_cleanup_pop(0);
> > +	pthread_exit(&retval_record);
> > +
> > +exit3:
> > +	free(buffer);
> > +exit2:
> > +	pcm_close(pcm);
> > +exit1:
> > +	pthread_exit(&retval_record);
> > +}
> > diff --git a/bat/tinyalsa.h b/bat/tinyalsa.h new file mode 100644
> > index 0000000..70e4749
> > --- /dev/null
> > +++ b/bat/tinyalsa.h
> > @@ -0,0 +1,23 @@
> > +/*
> > + * Copyright (C) 2013-2015 Intel Corporation
> > + *
> > + * This program is free software; you can redistribute it and/or
> > +modify
> > + * it under the terms of the GNU General Public License as published
> > +by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + */
> > +
> > +extern int retval_play;
> > +extern int retval_record;
> > +
> > +extern int is_capturing;
> > +extern int is_playing;
> > +
> > +void *playback_tinyalsa(struct bat *); void *record_tinyalsa(struct
> > +bat *);
> > diff --git a/configure.ac b/configure.ac index f6f8103..87dd237 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -73,6 +73,9 @@ if test x$bat = xtrue; then
> >    dnl Check for libfftw3
> >    have_libfftw3="yes"
> >    AC_CHECK_LIB([fftw3], [fftw_malloc], , [have_libfftw3="no"])
> > +  dnl Check for libtinyalsa
> > +  have_libtinyalsa="yes"
> > +  AC_CHECK_LIB([tinyalsa], [pcm_open], , [have_libtinyalsa="no"])
> >    AC_CHECK_LIB([m], [sqrtf], , [AC_MSG_ERROR([Error: Need sqrtf])])
> >    AC_CHECK_LIB([pthread], [pthread_create], , [AC_MSG_ERROR([Error:
> need PTHREAD library])])
> >    FFTW_CFLAGS="$CFLAGS"
> > @@ -86,6 +89,7 @@ if test x$bat = xtrue; then
> >
> >  fi
> >  AM_CONDITIONAL(HAVE_LIBFFTW3, test "$have_libfftw3" = "yes")
> > +AM_CONDITIONAL(HAVE_LIBTINYALSA, test "$have_libtinyalsa" = "yes")
> >
> >  dnl Check for librt
> >  LIBRT=""
> > --
> > 2.5.0
> >
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> >
