From: Guilhem Tardy <guilhem_tardy@yahoo.com>
Subject: Re: playback in multiple period_size?
Date: Thu, 12 Dec 2002 14:34:39 -0800 (PST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021212223439.42238.qmail@web11505.mail.yahoo.com>
References: <Pine.LNX.4.33.0212122255220.3487-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0212122255220.3487-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> > Is the application supposed to always add silence at the end to ensure that
> > a multiple of period_size has been written?
> 
> It looks like a bug. Could you send me a little C code which triggers this 
> problem?

Sure, the code is below. Everything is alright until the I drain() before
close(). As it happens, drain() only returns seconds later, with an error.

Thanks,
Guilhem.


#include <stdio.h>
#include <sys/time.h>
#include <stdlib.h>
#include <alsa/asoundlib.h>
#include
"/usr/src/download/alsa-driver-0.9.0rc6/alsa-kernel/pci/pci2103/pci2103-ioctls.h"


#define BUFBYTES	512
#define SIMULBYTES	160000


void About(void)
{
	fprintf (stderr, "Syntax: test_write [-8|-16|-U|-A] [device] [file.raw]\n");
	exit (-1);
}


void writei_func(snd_pcm_t *handle, char *data, snd_pcm_uframes_t count)
{
	int ret;

	while (count > 0) {
		ret = snd_pcm_writei (handle, data, count);
		if (ret < 0) {
			fprintf(stderr, "write to audio interface failed (%s)",
				snd_strerror (ret));
			exit (-1);
		}
		if (ret > 0) {
			count -= ret;
			data += snd_pcm_samples_to_bytes(handle, ret);
		}
	}
}


main (int argc, char *argv[])
{
	int i;
	int err;
	int card, dev;
	char card_id[32];
	char dev_id[32];
	const char *str_result;
	snd_ctl_t *ctl_handle;
	snd_ctl_card_info_t *card_info;
	snd_hwdep_info_t *hwdep_info;
	snd_hwdep_iface_t iface;
	snd_hwdep_t *hwdep;
	snd_pcm_format_t format;
	snd_pcm_t *playback_handle;
	snd_pcm_hw_params_t *hw_params;
	snd_pcm_uframes_t min_align;
	snd_pcm_sw_params_t *sw_params;
	char buf[BUFBYTES];
	int fd, bytes, samples, size, isPCI2103 = 0;


	printf("argc=%d [\"%s\", \"%s\", \"%s\"]\n", argc, argv[1], argv[2], argv[3]);

	if (argc < 3) {
		fprintf (stderr, "Not enough arguments!!!\n");
		About();
	}

	if (argc > 4) {
		fprintf (stderr, "Too many arguments!!!\n");
		About();
	}

	if (!strcmp(argv[1],"-8"))
	  format = SND_PCM_FORMAT_S8;
	else if (!strcmp(argv[1],"-16"))
	  format = SND_PCM_FORMAT_S16_LE;
	else if (!strcmp(argv[1],"-U"))
	  format = SND_PCM_FORMAT_MU_LAW;
	else if (!strcmp(argv[1],"-A"))
	  format = SND_PCM_FORMAT_G726_16KBPS;
	else {
		fprintf (stderr, "Unknown format!!!\n");
		About();
	}

	card = atoi(argv[2]+3);
	if (card < 0 || card > 31) {
		fprintf (stderr, "Wrong argument '%d' in '%s'\n", card, argv[2]);
		exit (-1);
	}

	////////////////////////////////////////////
	// Open the CTL device

	// Get control handle for selected card
	sprintf(card_id, "hw:%i", card);
	if ((err = snd_ctl_open(&ctl_handle, card_id, 0)) < 0) {
		fprintf (stderr, "control open (%s): %s\n", card_id, snd_strerror(err));
		exit (-1);
	}

	if ((err = snd_ctl_card_info_malloc(&card_info)) < 0) {
		fprintf (stderr, "cannot allocate card info structure (%s)\n",
			 snd_strerror (err));
		exit (-1);
	}

	// Read control info from card
	if ((err = snd_ctl_card_info(ctl_handle, card_info)) < 0) {
		fprintf (stderr, "control hardware info (%s): %s\n", card_id,
			 snd_strerror(err));
		exit (-1);
	}

	// We would prefer a PCI2103 card!!!
	str_result = snd_ctl_card_info_get_driver(card_info);
	if (strcmp(str_result, "PCI2103")) {
		fprintf (stderr, "driver (%s): not a PCI2103 type card\n", str_result);
	}
	else
	  isPCI2103 = 1;

	snd_ctl_card_info_free(card_info);

	// Find hardware dependant device
	dev = -1;
	while (1) {
		if ((err = snd_ctl_hwdep_next_device(ctl_handle, &dev)) < 0) {
			fprintf (stderr, "hwdep next device (%s): %s\n", card_id,
				 snd_strerror(err));
			break;
		}
		if (dev < 0) // no more device
		  break;

		sprintf(dev_id, "hw:%i,%i", card, dev);
		if (strcmp(dev_id, argv[2])) // wrong device
		  continue;

		if ((err = snd_hwdep_info_malloc(&hwdep_info)) < 0) {
			fprintf (stderr, "cannot allocate hwdep info structure (%s)\n",
				 snd_strerror (err));
			exit (-1);
		}

		snd_hwdep_info_set_device(hwdep_info, dev);

		if ((err = snd_ctl_hwdep_info(ctl_handle, hwdep_info)) < 0) {
			if (err != -ENOENT) {
				fprintf (stderr, "control hwdep info (%s): %s\n", card_id,
snd_strerror(err));
				exit (-1);
			}
			continue;
		}

		iface = snd_hwdep_info_get_iface(hwdep_info);

		snd_hwdep_info_free(hwdep_info);

		if (iface == SND_HWDEP_IFACE_PCI2103) {
			////////////////////////////////////////////////////////
			// Open the HWDEP device, and test special APIs

			if ((err = snd_hwdep_open(&hwdep, dev_id, SND_HWDEP_OPEN_DUPLEX)) < 0) {
				fprintf (stderr, "cannot open hwdep '%s' (%s)\n",
					 dev_id, snd_strerror (err));
				exit (-1);
			}

			if ((err = snd_hwdep_ioctl(hwdep, PCI2103_SNDIOC_AES_ENABLE, (void *) 1)) <
0) {
				fprintf (stderr, "cannot enable AES (%s)\n",
					 snd_strerror (err));
				exit (-1);
			}

			if ((err = snd_hwdep_ioctl(hwdep, PCI2103_SNDIOC_AES_ENABLE, (void *) 0)) <
0) {
				fprintf (stderr, "cannot disable AES (%s)\n",
					 snd_strerror (err));
				exit (-1);
			}

			if ((err = snd_hwdep_close(hwdep)) < 0) {
				fprintf (stderr, "cannot close hwdep (%s)\n",
					 snd_strerror (err));
				exit (-1);
			}
		}
	}

	snd_ctl_close(ctl_handle);

	////////////////////////////////////////////
	// Open the PCM device

	if ((err = snd_pcm_open (&playback_handle, argv[2], SND_PCM_STREAM_PLAYBACK,
0)) < 0) {
		fprintf (stderr, "cannot open audio device %s (%s)\n", 
			 argv[2],
			 snd_strerror (err));
		exit (-1);
	}

	if ((err = snd_pcm_hw_params_malloc (&hw_params)) < 0) {
		fprintf (stderr, "cannot allocate hardware parameter structure (%s)\n",
			 snd_strerror (err));
		exit (-1);
	}

	if ((err = snd_pcm_hw_params_any (playback_handle, hw_params)) < 0) {
		fprintf (stderr, "cannot initialize hardware parameter structure (%s)\n",
			 snd_strerror (err));
		exit (-1);
	}

	if ((err = snd_pcm_hw_params_set_access (playback_handle, hw_params,
SND_PCM_ACCESS_RW_INTERLEAVED)) < 0) {
		fprintf (stderr, "cannot set access type (%s)\n",
			 snd_strerror (err));
		exit (-1);
	}

	if ((err = snd_pcm_hw_params_set_format (playback_handle, hw_params, format))
< 0) {
		fprintf (stderr, "cannot set sample format (%s)\n",
			 snd_strerror (err));
		exit (-1);
	}

	if ((err = snd_pcm_hw_params_set_rate_near (playback_handle, hw_params, 8000,
0)) < 0) {
		fprintf (stderr, "cannot set sample rate (%s)\n",
			 snd_strerror (err));
		exit (-1);
	}

	if ((err = snd_pcm_hw_params_set_channels (playback_handle, hw_params, 1)) <
0) {
		fprintf (stderr, "cannot set channel count (%s)\n",
			 snd_strerror (err));
		exit (-1);
	}

	if ((err = snd_pcm_hw_params (playback_handle, hw_params)) < 0) {
		fprintf (stderr, "cannot set parameters (%s)\n",
			 snd_strerror (err));
		exit (-1);
	}

 	if ((err = snd_pcm_hw_params_get_min_align (hw_params, &min_align)) < 0) {
		fprintf (stderr, "cannot get minimum transfer align value (%s)\n",
			 snd_strerror (err));
		exit (-1);
	}

	snd_pcm_hw_params_free (hw_params);

	if ((err = snd_pcm_sw_params_malloc (&sw_params)) < 0) {
		fprintf (stderr, "cannot allocate software parameter structure (%s)\n",
			 snd_strerror (err));
		exit (-1);
	}

	snd_pcm_sw_params_current(playback_handle, sw_params);

	if ((err = snd_pcm_sw_params_set_xfer_align(playback_handle, sw_params,
min_align)) < 0) {
		fprintf (stderr, "cannot set xfer_align (%s)\n",
			 snd_strerror (err));
		exit (-1);
	}

	if ((err = snd_pcm_sw_params(playback_handle, sw_params)) < 0) {
		fprintf (stderr, "unable to install sw params (%s)\n",
			 snd_strerror (err));
		exit (-1);
	}

	snd_pcm_sw_params_free (sw_params);

	////////////////////////////////////////////
	// Play some tune

	samples = snd_pcm_bytes_to_samples(playback_handle, BUFBYTES);
	samples -= samples % min_align;
	bytes = snd_pcm_samples_to_bytes(playback_handle, samples);

	if (argc == 4) {
		fd = open(argv[3], 0);
		if (fd >= 0) {
			i = 0;
			printf("Now playing from a file in chunks of %d samples (%d bytes)\n",
samples, bytes);
			while ((size = read(fd, buf, bytes)) > 0) {
fprintf(stderr, ".");
fflush(stderr);
				samples = snd_pcm_bytes_to_samples(playback_handle, size);
				samples -= samples % min_align;
				writei_func(playback_handle, buf, samples);
			}
fprintf(stderr, "\n");
fflush(stderr);
			close(fd);
		}
	}
	else {
		for ( i = 0; i < bytes; ++i )
		  buf[i] = 0xFF;

		printf("Now playing a simulated sound in chunks of %d samples (%d
bytes)...\n", samples, bytes);
		for (i = 0; i < SIMULBYTES; i+=bytes)
		  writei_func(playback_handle, buf, samples);
	}

	snd_pcm_drain (playback_handle);
	printf( "Playing is now finished.\n" );

	snd_pcm_close (playback_handle);
	exit (0);
}


__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
