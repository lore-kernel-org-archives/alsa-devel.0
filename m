From: Nick Harezga <nharezga@mitre.org>
Subject: Issue when upgrading from 1.0.22 to 1.0.25
Date: Thu, 1 Nov 2012 08:49:09 -0400
Message-ID: <1351774149.2476.24.camel@winterfell>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-i4DWDg/2bojPrHZSrvB7"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpksrv1.mitre.org (smtpksrv1.mitre.org [198.49.146.77])
 by alsa0.perex.cz (Postfix) with ESMTP id A0E8B2617B0
 for <alsa-devel@alsa-project.org>; Thu,  1 Nov 2012 13:47:08 +0100 (CET)
Received: from smtpksrv1.mitre.org (localhost.localdomain [127.0.0.1])
 by localhost (Postfix) with SMTP id 4D3291F0AC5
 for <alsa-devel@alsa-project.org>; Thu,  1 Nov 2012 08:47:07 -0400 (EDT)
Received: from IMCCAS02.MITRE.ORG (imccas02.mitre.org [129.83.29.79])
 by smtpksrv1.mitre.org (Postfix) with ESMTP id 3BD061F0AC4
 for <alsa-devel@alsa-project.org>; Thu,  1 Nov 2012 08:47:07 -0400 (EDT)
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

--=-i4DWDg/2bojPrHZSrvB7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

I am attempting to upgrade from Ubuntu version 10.04 to version 12.04.
Version 10.04 has ALSA version 1.0.22 and version 12.04 has ALSA 1.0.25.
I have a simple test application that captures microphone input and then
plays the audio through the speaker. When run with ALSA 1.0.22 the
program works as expected. When I run the program with ALSA 1.0.25, I
get a bad pipe error indicating buffer underrun when calling writes.
Both systems have the same hardware (Dell Latitude E6400 laptop).

I tried looking through the change logs to determine if there were any
obvious changes that stood out to me, but couldn't find anything. I have
attached my code. Any suggestions?

Program is compiled using "g++ audio_test.cpp -o audio_test -lasound"

Audio sample rate: 8000
Buffer size: 1800
Format: Signed 16bit LE, interleaved

--=-i4DWDg/2bojPrHZSrvB7
Content-Disposition: attachment; filename="audio_test.cpp"
Content-Type: text/x-c++src; name="audio_test.cpp"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

#include <alsa/asoundlib.h>
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>

#define BUFFER_SIZE			1800

int main( int argc, char* argv[] )
{
	//Speaker

	snd_pcm_t* pcm_handle;
	snd_pcm_t* cap_handle;
	snd_pcm_stream_t stream = SND_PCM_STREAM_PLAYBACK;
	snd_pcm_stream_t receive = SND_PCM_STREAM_CAPTURE;
	snd_pcm_hw_params_t *hwparams;
	char *pcm_name;
	pcm_name = strdup( "default" );

	snd_pcm_hw_params_alloca( &hwparams );

	if( snd_pcm_open( &pcm_handle, pcm_name, stream, 0 ) < 0 )
	{
		fprintf( stderr, "Error opening PCM device %s\n", pcm_name );
		return -1;
	}
	if( snd_pcm_open( &cap_handle, pcm_name, receive, 0 ) < 0 )
	{
		fprintf( stderr, "Error opening PCM device %s\n", pcm_name );
		return -1;
	}

	if( snd_pcm_hw_params_malloc( &hwparams ) < 0 )
	{
		fprintf( stderr, "cannot allocate hardware parameter structure\n" );
		return -1;
	}

	if( snd_pcm_hw_params_any( pcm_handle, hwparams ) < 0 )
	{
		fprintf( stderr, "cannot initialize hardware parameter structure\n" );
		return -1;
	}
	if( snd_pcm_hw_params_any( cap_handle, hwparams ) < 0 )
	{
		fprintf( stderr, "cannot initialize hardware parameter structure\n" );
		return -1;
	}

	int rate = 8000;
	unsigned int exact_rate;
	unsigned int periods = 2;
	int chan = 1;
	int err;

	if( err = ( snd_pcm_hw_params_set_access( pcm_handle, hwparams,
		SND_PCM_ACCESS_RW_INTERLEAVED ) < 0 ) )
	{
		fprintf( stderr, "Error setting access (%s).\n", snd_strerror( err ) );
		return -1;
	}
	if( err = ( snd_pcm_hw_params_set_access( cap_handle, hwparams,
		SND_PCM_ACCESS_RW_INTERLEAVED ) < 0 ) )
	{
		fprintf( stderr, "Error setting access (%s).\n", snd_strerror( err ) );
		return -1;
	}

	if( snd_pcm_hw_params_set_format( pcm_handle, hwparams, 
		SND_PCM_FORMAT_S16_LE ) < 0 )
	{
		fprintf( stderr, "Error setting rate.\n" );
		return -1;
	}
	if( snd_pcm_hw_params_set_format( cap_handle, hwparams, 
		SND_PCM_FORMAT_S16_LE ) < 0 )
	{
		fprintf( stderr, "Error setting rate.\n" );
		return -1;
	}

	exact_rate = rate;
	if( snd_pcm_hw_params_set_rate_near( pcm_handle, hwparams, &exact_rate, 
		0 )	< 0 )
	{
		fprintf( stderr, "Error setting rate.\n" );
		return -1;
	}
	if( rate != exact_rate )
	{
		fprintf( stderr, "The rate %d Hz is not supported by your hardware.\n " 
				" ==> Using %d Hz instead.\n", rate, exact_rate );
	}
	exact_rate = rate;
	if( snd_pcm_hw_params_set_rate_near( cap_handle, hwparams, &exact_rate, 
		0 )	< 0 )
	{
		fprintf( stderr, "Error setting rate.\n" );
		return -1;
	}

	if( rate != exact_rate )
	{
		fprintf( stderr, "The rate %d Hz is not supported by your hardware.\n " 
				" ==> Using %d Hz instead.\n", rate, exact_rate );
	}

	if( snd_pcm_hw_params_set_channels( pcm_handle, hwparams, chan ) < 0 )
	{
		fprintf( stderr, "Error setting channels.\n" );
		return -1;
	}
	if( snd_pcm_hw_params_set_channels( cap_handle, hwparams, chan ) < 0 )
	{
		fprintf( stderr, "Error setting channels.\n" );
		return -1;
	}

	if( snd_pcm_hw_params_set_periods_near( pcm_handle, hwparams, &periods, 0 )
		< 0 )
	{
		fprintf( stderr, "Error setting periods.\n" );
		return -1;
	}
	if( snd_pcm_hw_params_set_periods_near( cap_handle, hwparams, &periods, 0 )
		< 0 )
	{
		fprintf( stderr, "Error setting periods.\n" );
		return -1;
	}

	int frameSize = chan * 2;
	snd_pcm_uframes_t frme = BUFFER_SIZE / frameSize * periods;
	if( snd_pcm_hw_params_set_buffer_size_near( pcm_handle, hwparams, &frme ) 
		< 0 )
	{
		fprintf( stderr, "Error setting buffersize.\n" );
		return -1;
	}

	if( BUFFER_SIZE != ( int )( frme * frameSize / periods ) )
	{
		printf( "asked for %d, got %d\n", BUFFER_SIZE, 
			( int )( frme * frameSize / periods ) );
	}

	frme = BUFFER_SIZE / frameSize * periods;

	if( snd_pcm_hw_params_set_buffer_size_near( cap_handle, hwparams, &frme ) 
		< 0 )
	{
		fprintf( stderr, "Error setting buffersize.\n" );
		return -1;
	}
	if( BUFFER_SIZE != ( int )( frme * frameSize / periods ) )
	{
		printf( "asked for %d, got %d\n", BUFFER_SIZE, 
			( int )( frme * frameSize / periods ) );
	}

	if( snd_pcm_hw_params( pcm_handle, hwparams ) < 0 )
	{
		fprintf( stderr, "Error setting HW params.\n" );
		return -1;
	}
	if( snd_pcm_hw_params( cap_handle, hwparams ) < 0 )
	{
		fprintf( stderr, "Error setting HW params.\n" );
		return -1;
	}

	unsigned char *data;
	int frames;

	data = ( unsigned char* )malloc( BUFFER_SIZE );
	frames = BUFFER_SIZE/frameSize;

	while( true )
	{
		if( ( pcmreturn = snd_pcm_readi( cap_handle, data, frames ) ) < 0 )
		{
			snd_pcm_prepare( cap_handle );
			printf( "read error: %d\n", pcmreturn );
		}
		else
		{
			if( ( pcmreturn = snd_pcm_writei( pcm_handle, data, frames ) ) 
				< 0 )
			{
				printf( "write error: %d\n", pcmreturn );
			}
		}
	}

	snd_pcm_drop( pcm_handle );
	snd_pcm_drain( pcm_handle );

	return 0;
}

--=-i4DWDg/2bojPrHZSrvB7
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--=-i4DWDg/2bojPrHZSrvB7--
