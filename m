From: David Stuart <dave@sipquest.com>
Subject: Could use some tips with example program
Date: Mon, 19 May 2003 13:26:02 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EC913AA.707@sipquest.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080004000903050006070604"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080004000903050006070604
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Greetings all,

I've been trying to learn about ALSA this weekend. After reading a few 
HOWTOs and FAQs, I decided  to implement a simple program. Rather than 
cut n' paste some of the examples, I tried to write a small one myself. 
Unfortunately I'm running into some problems, and I'm not sure if my 
approach is even correct. Basically I would like to just read stuff from 
the capture device, and send it straight into the playback device.

Should be simple, but I find that each example I look at is different, 
and uses a some different hardware /software parameters to achieve the 
same thing..

Anyway, was hoping if some of you are so inclined, could you eyeball my 
program and give me some tips? I have a feeling I'm making lots of 
mistakes (due to misunderstanding some key concepts, probably). It's 
really quite a short program..

--------------080004000903050006070604
Content-Type: text/plain;
 name="alsatest.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsatest.c"

#include <assert.h>
#include <stdlib.h>
#include <signal.h>
#include <unistd.h>
#include <alsa/asoundlib.h>

#define BUF_SIZE 1024

static snd_pcm_t *phandle = NULL; /* Handle for the playback pcm device */
static snd_pcm_t *chandle = NULL; /* Handle for the capture pcm device */
static short buf[BUF_SIZE];

/* print out errno and exit */
void die( char *message, int err )
{
	fprintf( stderr, "%s: %s\n", message, snd_strerror( err ));
	exit( err );
}

/* sets the hardware parameters on the pcm handle */
void set_hw_params( snd_pcm_t *handle, snd_pcm_hw_params_t *hw_params, snd_pcm_access_t access )
{
	int err = 0;

	/* initialize hw param structure */
	err = snd_pcm_hw_params_any( handle, hw_params );
	if( err < 0 )
		die( "snd_pcm_hw_params_any", err );

	/* set the read/write format */
	err = snd_pcm_hw_params_set_access( handle, hw_params, access );
	if( err < 0 )
		die( "snd_pcm_hw_params_set_access", err );

	/* set the sample format */
	err = snd_pcm_hw_params_set_format( handle, hw_params, SND_PCM_FORMAT_S16 );
	if( err < 0 )
		die( "snd_pcm_hw_params_set_format", err );
	
	/* set the stream reate */
	err = snd_pcm_hw_params_set_rate_near( handle, hw_params, 44100, 0 );
	if( err < 0 )
		die( "snd_pcm_hw_params_set_rate_near", err );

	/* set the number of channels (mono vs. stereo) */
	err = snd_pcm_hw_params_set_channels( handle, hw_params, 1 );
	if( err < 0 )
		die( "snd_pcm_hw_params_set_channels", err );

	err = snd_pcm_hw_params( handle, hw_params );
	if( err < 0 )
		die( "snd_pcm_hw_params", err );
}

/* Asynchronous handler for the capture
void capture_callback( snd_async_handler_t *handler )
{
	if( snd_pcm_readi( chandle, buf, BUF_SIZE ) != BUF_SIZE )
		die( "snd_pcm_readi" );

	printf( "captured %d shorts of data\n", BUF_SIZE );

	if( snd_pcm_writei( phandle, buf, BUF_SIZE ) != BUF_SIZE )
		die( "snd_pcm_writei" );

	printf( "wrote %d shorts of data\n", BUF_SIZE );
}
*/

/* Handler for exiting the application */
void handle_sigint(int signal)
{
	if( phandle != NULL ) snd_pcm_close(phandle);
	if( chandle != NULL ) snd_pcm_close(chandle);
}

/* The basic idea here is to take the capture output and put it straight
 * into the playback device. This should give us a "real-world" approximation
 * of the latency
 */
int main( int argc, char **argv )
{
	int err;
	char *pdevice;
	char *cdevice;
	struct sigaction actionStruct;
	snd_async_handler_t *handler;

	snd_pcm_stream_t pstream = SND_PCM_STREAM_PLAYBACK;
	snd_pcm_stream_t cstream = SND_PCM_STREAM_CAPTURE;

	snd_pcm_hw_params_t *hw_params;

	/* Check for the device */
	if( argc != 3 )
	{
		fprintf( stderr, "Please supply the playback and capture device to use\n" );
		exit( 1 );
	}

	pdevice = argv[1];
	cdevice = argv[2];


	/* Make sure the buffer is clean */
	memset( buf, 0, BUF_SIZE * sizeof( short ));

	/* open pcm handle for playback */
	err = snd_pcm_open( &phandle, pdevice, pstream, 0 );
	if( err < 0 )
		die( "snd_pcm_open", err );

	/* open pcm handle for capture */
	err = snd_pcm_open( &chandle, cdevice, cstream, 0 );
	if( err < 0 )
		die( "snd_pcm_open", err );

	/* set all hw params on the playback device */
	err = snd_pcm_hw_params_malloc( &hw_params );
	if( err < 0 )
		die( "snd_pcm_hw_params_malloc", err );

	set_hw_params( phandle, hw_params, SND_PCM_ACCESS_RW_INTERLEAVED );
	snd_pcm_hw_params_free( hw_params );

	/* set all the hw params on the capture device */
	err = snd_pcm_hw_params_malloc( &hw_params );
	if( err < 0 )
		die( "snd_pcm_hw_params_malloc", err );

	set_hw_params( chandle, hw_params, SND_PCM_ACCESS_RW_INTERLEAVED );
	snd_pcm_hw_params_free( hw_params );

	/* If we get past this point, install a signal handler to handle the
	 * cleanup */
	actionStruct.sa_handler = handle_sigint;
	err = sigaction( SIGINT, &actionStruct, NULL );
	if( err < 0 )
		die( "sigaction", err );

	/* Prepare both handles for capture and playback */
	err = snd_pcm_prepare( phandle );
	if( err < 0 )
		die( "snd_pcm_capture", err );

	err = snd_pcm_prepare( chandle );
	if( err < 0 )
		die( "snd_pcm_capture", err );

	/* set the callback for the capture */
	/*
	if( snd_async_add_pcm_handler( &handler, chandle, capture_callback, NULL ) < 0 )
		die( "snd_async_add_pcm_handler" );
		*/

	while(1) {

		/* read BUF_SIZE shorts from the capture device and write them
		 * to the playback device 
		 */
		err = snd_pcm_readi( chandle, buf, BUF_SIZE );
		if( err < 0 )
			die( "snd_pcm_readi", err );

		/*
		 * Try to play back the buffer that we just read. This doesn't seem
		 * to work, I'm not sure why?
		 */
		err = snd_pcm_writei( phandle, buf, BUF_SIZE );
		if( err < 0 )
		{
			if( err == -EPIPE )
			{
				fprintf( stderr, "buffer underrun\n" );
				err = snd_pcm_prepare( phandle );
				if( err < 0 )
					die( "snd_pcm_prepare", err );
			}
			else
				die( "snd_pcm_writei", err );
		}
	}
	/*pause();*/
	return 0;
}

--------------080004000903050006070604--



-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge
