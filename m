From: Nyx <keres.nyx@gmail.com>
Subject: Re: Fwd: [Alsa-devel] Read the input of a soundcard
	with ALSA
Date: Wed, 2 May 2007 14:23:13 +0200
Message-ID: <50fdad60705020523w6451a94ahc94533adc256f826@mail.gmail.com>
References: <50fdad60704200820x77d22314x36786198c7872d6@mail.gmail.com>
	<4628FD65.4020407@gmail.com>
	<50fdad60704230718jb9403b3yceaa217dc9a9162d@mail.gmail.com>
	<s5hirbl2a48.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.228])
	by alsa0.perex.cz (Postfix) with ESMTP id 6A6B224407
	for <alsa-devel@alsa-project.org>;
	Wed,  2 May 2007 14:23:22 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id l8so102743nzf
	for <alsa-devel@alsa-project.org>; Wed, 02 May 2007 05:23:19 -0700 (PDT)
In-Reply-To: <s5hirbl2a48.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

OK. I only want to read on the input of soundcard. So I wrote an other
program easier than the first, I write the data in file, but it seems that
it doesn't work...

#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include "alsa/asoundlib.h"
#include <errno.h>

unsigned int rate =3D 44100;
unsigned int nb_channels =3D 2;

int set_hwparams(snd_pcm_t *handle, snd_pcm_hw_params_t *hw_params)
{
    int err;
    int dir=3D0;
    if ((err =3D snd_pcm_hw_params_malloc (&hw_params)) < 0) {
        fprintf (stderr, "cannot allocate hardware parameter structure
(%s)\n", snd_strerror (err));
        exit (1);
    }

    if ((err =3D snd_pcm_hw_params_any (handle, hw_params)) < 0) {
        fprintf (stderr, "cannot initialize hardware parameter structure
(%s)\n", snd_strerror (err));
        exit (1);
    }
    printf("Initialisation des param=E8tres\n");

    if ((err =3D snd_pcm_hw_params_set_access (handle, hw_params,
SND_PCM_ACCESS_RW_INTERLEAVED)) < 0) {
        fprintf (stderr, "cannot set access type (%s)\n", snd_strerror
(err));
        exit (1);
    }
    printf("Access card configuration\n");

    if ((err =3D snd_pcm_hw_params_set_format (handle, hw_params,
SND_PCM_FORMAT_S16_LE)) < 0) {
        fprintf (stderr, "cannot set sample format (%s)\n", snd_strerror
(err));
        exit (1);
    }

    if ((err =3D snd_pcm_hw_params_set_rate_near (handle, hw_params, &rate,
&dir)) < 0) {
        fprintf (stderr, "cannot set sample rate (%s)\n", snd_strerror
(err));
        exit (1);
    }
    if ((err =3D snd_pcm_hw_params_set_channels (handle, hw_params, nb_chan=
n))
< 0) {
        fprintf (stderr, "cannot set channel count (%s)\n", snd_strerror
(err));
        exit (1);
    }

    if ((err =3D snd_pcm_hw_params (handle, hw_params)) < 0) {
        fprintf (stderr, "cannot set parameters (%s)\n", snd_strerror
(err));
        exit (1);
    }
    printf("Parameters recorded\n");

    //snd_pcm_hw_params_free (hw_params);

    if ((err =3D snd_pcm_prepare (handle)) < 0) {
        fprintf (stderr, "cannot prepare audio interface for use (%s)\n",
snd_strerror (err));
        exit (1);
    }
        return 0;
}

int main(int   argc, char *argv[]){
    int err;
    int j;
    printf("Beginning \n");
    snd_pcm_hw_params_t *hw_params_capture, *hw_params_playback;
    short buf[256];
    FILE *file;

    fichier =3D fopen( "/root/Desktop/Test/Audio/Capture.001", "w");
    if (fichier =3D=3D NULL) printf("cannot create file : %i\n", errno);
    else printf("file created\n");

    /*Open soundcard as capture*/
    snd_pcm_t *capture_handle;

    if ((err =3D snd_pcm_open (&capture_handle, "hw:0,0",
SND_PCM_STREAM_CAPTURE, 0)) < 0) {
        fprintf (stderr, "cannot open audio device %s (%s)\n",  argv[1],
 snd_strerror (err));
        exit (1);
    }

   set_hwparams(capture_handle, hw_params_capture);

   for (j =3D 0 ;  j < 256 ; j++) {
            if ((err =3D snd_pcm_readi (capture_handle, buf, 128)) < 0)
printf("cherche pas\n");
            putc(buf[j], file);       //write in file LEFT Channel
            putc(buf[j+1], file);  //write in file RIGHT Channel
            putc(0x0A, file);
    }

    printf("Close File\n");
    fclose(file);
    snd_pcm_close (capture_handle);
    return 0 ;
}


What do you think about this program... ? I searched about an How-to or some
help for capture on a soundcard with ALSA, but I didn't found

Thank you
-- =

K
