From: Ben Hutchings <ben@decadent.org.uk>
Subject: Crackling in USB audio capture
Date: Wed, 25 Mar 2009 22:35:53 +0000
Message-ID: <20090325223553.GO3051@decadent.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5830152557039547077=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from shadbolt.e.decadent.org.uk (shadbolt.e.decadent.org.uk
	[88.96.1.126]) by alsa0.perex.cz (Postfix) with ESMTP id 45397243F1
	for <alsa-devel@alsa-project.org>; Wed, 25 Mar 2009 23:35:54 +0100 (CET)
Received: from womble by shadbolt.decadent.org.uk with local (Exim 4.69)
	(envelope-from <ben@decadent.org.uk>) id 1LmbhR-0007gT-Ph
	for alsa-devel@alsa-project.org; Wed, 25 Mar 2009 22:35:53 +0000
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============5830152557039547077==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IbVRjBtIbJdbeK1C"
Content-Disposition: inline


--IbVRjBtIbJdbeK1C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm writing an ALSA application that captures audio.  It worked OK with
PCI sound cards but is somehow getting regular faint clicking/crackling
with a USB audio device (TI/Burr-Brown PCM2902).  Source code is below.
What am I doing wrong?

This is trying to use a period size near 1602 frames, but choosing other
period sizes makes no difference.  Also, JACK doesn't seem to have the
same problem, so this does appear to be an application bug.

Ben.

/* Copyright 2007-2009 Ben Hutchings.
 * Licenced under GNU GPL version 2 or later.
 */

#include <assert.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <fcntl.h>
#include <getopt.h>
#include <sys/types.h>
#include <unistd.h>
#include <netinet/in.h>

#include <asoundlib.h>

#include "config.h"
#include "dif.h"
#include "protocol.h"
#include "socket.h"

static struct option options[] =3D {
    {"host",   1, NULL, 'h'},
    {"port",   1, NULL, 'p'},
    {"system", 1, NULL, 's'},
    {"rate",   1, NULL, 'r'},
    {"delay",  1, NULL, 'd'},
    {"help",   0, NULL, 'H'},
    {NULL,     0, NULL, 0}
};

static char * mixer_host =3D NULL;
static char * mixer_port =3D NULL;

static void handle_config(const char * name, const char * value)
{
    if (strcmp(name, "MIXER_HOST") =3D=3D 0)
    {
	free(mixer_host);
	mixer_host =3D strdup(value);
    }
    else if (strcmp(name, "MIXER_PORT") =3D=3D 0)
    {
	free(mixer_port);
	mixer_port =3D strdup(value);
    }
}

static void usage(const char * progname)
{
    fprintf(stderr,
	    "\
Usage: %s [-h HOST] [-p PORT] [-s ntsc|pal] \\\n\
           [-r 48000|32000|44100] [-d DELAY] [DEVICE]\n",
	    progname);
}

struct transfer_params {
    snd_pcm_t *              pcm;
    snd_pcm_uframes_t        hw_sample_count;
    const struct dv_system * system;
    enum dv_sample_rate      sample_rate_code;
    snd_pcm_uframes_t        delay_size;
    int                      sock;
};

void dv_buffer_fill_dummy(uint8_t * buf, const struct dv_system * system);

static void transfer_frames(struct transfer_params * params)
{
    static uint8_t buf[DIF_MAX_FRAME_SIZE];
    static const unsigned channel_count =3D 2;
    unsigned avail_count =3D 0;
    unsigned serial_num =3D 0;

    const snd_pcm_uframes_t buffer_size =3D
	(params->delay_size >=3D 2000 ? params->delay_size : 2000)
	+ params->hw_sample_count - 1;
    int16_t * samples =3D malloc(sizeof(int16_t) * channel_count * buffer_s=
ize);

    dv_buffer_fill_dummy(buf, params->system);

    for (;;)
    {
	unsigned sample_count =3D=20
	    params->system->sample_counts[params->sample_rate_code].std_cycle[
		serial_num % params->system->sample_counts[params->sample_rate_code].std_=
cycle_len];

	while (avail_count < params->delay_size || avail_count < sample_count)
	{
	    snd_pcm_sframes_t rc =3D snd_pcm_readi(params->pcm,
						 samples + channel_count * avail_count,
						 params->hw_sample_count);
	    if (rc < 0)
	    {
		// Recover from buffer underrun
		if (rc =3D=3D -EPIPE && snd_pcm_prepare(params->pcm) =3D=3D 0)
		{
		    fprintf(stderr, "WARN: Failing to keep up with audio source\n");
		    continue;
		}
		else
		{
		    fprintf(stderr, "ERROR: snd_pcm_readi: %s\n", snd_strerror(rc));
		    exit(1);
		}
	    }
	    avail_count +=3D rc;
	}

	dv_buffer_set_audio(buf, params->sample_rate_code, sample_count, samples);

	if (write(params->sock, buf, params->system->size)
	    !=3D (ssize_t)params->system->size)
	{
	    perror("ERROR: write");
	    exit(1);
	}

	memmove(samples, samples + channel_count * sample_count,
		sizeof(int16_t) * channel_count * (avail_count - sample_count));
	avail_count -=3D sample_count;
	++serial_num;
    }
}

int main(int argc, char ** argv)
{
    /* Initialise settings from configuration files. */
    dvswitch_read_config(handle_config);

    struct transfer_params params;
    char * system_name =3D NULL;
    long sample_rate =3D 48000;
    double delay =3D 0.2;

    /* Parse arguments. */

    int opt;
    while ((opt =3D getopt_long(argc, argv, "h:p:s:r:d:", options, NULL)) !=
=3D -1)
    {
	switch (opt)
	{
	case 'h':
	    free(mixer_host);
	    mixer_host =3D strdup(optarg);
	    break;
	case 'p':
	    free(mixer_port);
	    mixer_port =3D strdup(optarg);
	    break;
	case 's':
	    free(system_name);
	    system_name =3D strdup(optarg);
	    break;
	case 'r':
	    sample_rate =3D strtol(optarg, NULL, 10);
	    break;
	case 'd':
	    delay =3D strtod(optarg, NULL);
	    break;
	case 'H': /* --help */
	    usage(argv[0]);
	    return 0;
	default:
	    usage(argv[0]);
	    return 2;
	}
    }

    if (!mixer_host || !mixer_port)
    {
	fprintf(stderr, "%s: mixer hostname and port not defined\n",
		argv[0]);
	return 2;
    }

    if (!system_name || !strcasecmp(system_name, "pal"))
    {
	params.system =3D &dv_system_625_50;
    }
    else if (!strcasecmp(system_name, "ntsc"))
    {
	params.system =3D &dv_system_525_60;
    }
    else
    {
	fprintf(stderr, "%s: invalid system name \"%s\"\n", argv[0], system_name);
	return 2;
    }

    if (sample_rate =3D=3D 32000)
    {
	params.sample_rate_code =3D dv_sample_rate_32k;
    }
    else if (sample_rate =3D=3D 44100)
    {
	params.sample_rate_code =3D dv_sample_rate_44k1;
    }
    else if (sample_rate =3D=3D 48000)
    {
	params.sample_rate_code =3D dv_sample_rate_48k;
    }
    else
    {
	fprintf(stderr, "%s: invalid sample rate %ld\n", argv[0], sample_rate);
	return 2;
    }

    if (delay >=3D 0.0)
    {
	params.delay_size =3D delay * sample_rate;
    }
    else
    {
	fprintf(stderr, "%s: delays do not work that way!\n", argv[0]);
	return 2;
    }

    if (argc > optind + 1)
    {
	fprintf(stderr, "%s: excess argument \"%s\"\n",
		argv[0], argv[optind + 1]);
	usage(argv[0]);
	return 2;
    }


    const char * device =3D (argc =3D=3D optind) ? "default" : argv[optind];
    int rc;

    /* Prepare to capture and connect a socket to the mixer. */

    printf("INFO: Capturing from %s\n", device);
    rc =3D snd_pcm_open(&params.pcm, device, SND_PCM_STREAM_CAPTURE, 0);
    if (rc < 0)
    {
	fprintf(stderr, "ERROR: snd_pcm_open: %s\n", snd_strerror(rc));
	return 1;
    }

    snd_pcm_hw_params_t * hw_params;
    snd_pcm_hw_params_alloca(&hw_params);
    rc =3D snd_pcm_hw_params_any(params.pcm, hw_params);
    if (rc < 0)
    {
	fprintf(stderr, "ERROR: snd_pcm_hw_params_any: %s\n", snd_strerror(rc));
	return 1;
    }
    rc =3D snd_pcm_hw_params_set_access(params.pcm, hw_params, SND_PCM_ACCE=
SS_RW_INTERLEAVED);
    if (rc >=3D 0)
	rc =3D snd_pcm_hw_params_set_format(params.pcm, hw_params, SND_PCM_FORMAT_=
S16);
    if (rc >=3D 0)
	snd_pcm_hw_params_set_channels(params.pcm, hw_params, 2);
    if (rc >=3D 0)
	snd_pcm_hw_params_set_rate_resample(params.pcm, hw_params, 1);
    if (rc >=3D 0)
	snd_pcm_hw_params_set_rate(params.pcm, hw_params, sample_rate, 0);
    if (rc >=3D 0)
    {
	params.hw_sample_count =3D
	    params.system->sample_counts[params.sample_rate_code].std_cycle[0];
	rc =3D snd_pcm_hw_params_set_period_size_near(params.pcm, hw_params,
						    &params.hw_sample_count, 0);
    }
    if (rc >=3D 0)
    {
	unsigned buffer_time =3D 250000;
	rc =3D snd_pcm_hw_params_set_buffer_time_near(params.pcm, hw_params,
						    &buffer_time, 0);
    }
    if (rc >=3D 0)
	rc =3D snd_pcm_hw_params(params.pcm, hw_params);
    if (rc < 0)
    {
	fprintf(stderr, "ERROR: snd_pcm_hw_params: %s\n", snd_strerror(rc));
	return 1;
    }

    printf("INFO: Connecting to %s:%s\n", mixer_host, mixer_port);
    params.sock =3D create_connected_socket(mixer_host, mixer_port);
    assert(params.sock >=3D 0); /* create_connected_socket() should handle =
errors */
    if (write(params.sock, GREETING_SOURCE, GREETING_SIZE) !=3D GREETING_SI=
ZE)
    {
	perror("ERROR: write");
	exit(1);
    }

    transfer_frames(&params);

    close(params.sock);
    snd_pcm_close(params.pcm);

    return 0;
}

--=20
Ben Hutchings
Editing code like this is akin to sticking plasters on the bleeding stump
of a severed limb. - me, 29 June 1999

--IbVRjBtIbJdbeK1C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQFJyrHJ79ZNCRIGYgcRAtktAJ424kUWh/gsLHqqKyNBPxzG8lHe8ACgwbeG
A6wLVUSFgmAhwBBda7s2HqE=
=fNR7
-----END PGP SIGNATURE-----

--IbVRjBtIbJdbeK1C--

--===============5830152557039547077==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5830152557039547077==--
