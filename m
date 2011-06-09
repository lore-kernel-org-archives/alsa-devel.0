From: =?ISO-8859-1?Q?Andr=E9_Prado?= <andreprado88@gmail.com>
Subject: Problem capturing from sound board
Date: Thu, 9 Jun 2011 14:37:19 -0300
Message-ID: <BANLkTi=nQoq7NOAA8ry74W7egQxn9TFpDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) by alsa0.perex.cz (Postfix) with ESMTP id F35342441E
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Jun 2011 19:37:21 +0200 (CEST)
Received: by pzk26 with SMTP id 26so894457pzk.38
	for <alsa-devel@alsa-project.org>; Thu, 09 Jun 2011 10:37:19 -0700 (PDT)
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

Hello i am trying to do a simple program in order to capture the input
from the microphone in my OnBoard HDA Intel sound board.
However it doesnt work and gives me a segmentation fault. Any help is
appreciated.

#include <stdio.h>
#include <string.h>
#include <alsa/asoundlib.h>

int main(int argc, char** argv)
{
    register int err;
    int cardNum, totalCards;

    totalCards =3D 0;

    cardNum =3D -1;

    short buf[128];

    while(1)
    {
	snd_ctl_t *cardHandle;

    printf("\n***********\n");
   //Number of boards	=


    if ((err =3D snd_card_next(&cardNum)) < 0)
        {
	    printf("%s\n", snd_strerror(err));
	    break;
	}

    if(cardNum<0)
    {
        break;
    }

    ++totalCards;

    char str[64];

    sprintf(str, "hw:%i", cardNum); (IS THIS THE RIGHT WAY TO NAME MY DEVIC=
E?)


    snd_pcm_t *capture_handle;
    snd_pcm_hw_params_t *hw_params;



    if(err =3D snd_pcm_open( &capture_handle, str,
SND_PCM_STREAM_CAPTURE, 0 ) < 0 )
        {
	    printf("  %s\n", snd_strerror(err));
	    break;
	}

    snd_pcm_hw_params_malloc (&hw_params);
    snd_pcm_hw_params_any(capture_handle, hw_params);

    if(err =3D snd_pcm_hw_params_set_access(capture_handle, hw_params,
SND_PCM_ACCESS_RW_INTERLEAVED) < 0)
        printf("Nao e setar o acesso: %s\n", snd_strerror(err));

    unsigned int num_canais =3D 0;
    int ret;

    if(err =3D snd_pcm_hw_params_get_channels_max(hw_params, &num_canais) <=
 0)
        printf(" Nao e conseguir o numero de canais: %s\n", snd_strerror(er=
r));

    printf("Numero de canais: %i\n",num_canais);

    // Configurando hardware

    // Resampling

    printf("Fim preparacao");
    unsigned int resample =3D 1;

    if (err =3D snd_pcm_hw_params_set_rate_resample(capture_handle,
hw_params, resample)<0)
        printf("Erro setando o sample: %s\n", snd_strerror(err));
    // Formato Little endian 16 bits
    snd_pcm_hw_params_set_format (capture_handle, hw_params,
SND_PCM_FORMAT_S16_LE);

    // Stereo
    if (err =3D snd_pcm_hw_params_set_channels (capture_handle, hw_params, =
2) < 0)
	printf("Erro setando o numero de canais: %s\n", snd_strerror(err));

    // Playback Rate
    unsigned int actualRate =3D 44100;
    if (err =3D snd_pcm_hw_params_set_rate_near (capture_handle,
hw_params, &actualRate, 0) < 0)
	printf("Erro setando o rate de playback: %s\n", snd_strerror(err));

    // Setando os valores configurados no hardware.
    if (err =3D snd_pcm_hw_params (capture_handle, hw_params) < 0 )
	printf("Erro setando o hardware: %s\n", snd_strerror(err));

    // Tamanho do buffer recebido apos configurar o hardware
    snd_pcm_uframes_t bufferSize;
    snd_pcm_hw_params_get_buffer_size( hw_params, &bufferSize );
    //printf( "Init: Buffer size =3D %s", bufferSize);
    //_playbackFrames =3D bufferSize;

    printf( "\nBits significantes para amostra linear =3D %i\n",
snd_pcm_hw_params_get_sbits(hw_params));




    // Preparando para leitura
    int i=3D0;
    int d=3D0;

    if ((err =3D snd_pcm_prepare (capture_handle)) < 0)
  	printf("cannot prepare audio interface for use (%s)\n",snd_strerror(err)=
);
		=

			=


    snd_pcm_hw_params_free (hw_params);

//    if ((err =3D snd_pcm_readi (capture_handle, buf, 128)) !=3D 128)
  //   printf( "read from audio interface failed (%s)\n", snd_strerror (err=
));
    }
    snd_config_update_free_global();
    }


-- =

Att
Andr=E9
