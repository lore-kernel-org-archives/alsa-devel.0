From: Mikael Magnusson <mikaelmagnusson@glocalnet.net>
Subject: Bug in emu10k1 multichannel support
Date: Mon, 31 Jan 2005 17:09:28 +0100
Message-ID: <41FE5838.4060907@glocalnet.net>
References: <1106091073.24484.60.camel@krustophenia.net>	 <s5hpt01tler.wl@alsa2.suse.de> <1106970885.3051.88.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060105070101070406040009"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1106970885.3051.88.camel@krustophenia.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060105070101070406040009
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Lee Revell wrote:
...
> OK, I have posted the latest version:
> 
> http://www.alsa-project.org/~rlrevell/emu10k1-multichannel-v007.patch
> 
> All the known bugs I mentioned have been fixed.  I would like to test
> this version a while before signing off on it, then it should be ready
> to merge.  Since this patch touches almost every file in the driver, I
> can split it up and post it as a series of patches if necessary.
> 
> The mixer controls for multichannel PCM have been fixed and moved to
> IFACE_PCM.  My solution was to use the same emu10k1_pcm_mixer_t
> structure internally as for regular PCM substreams, but only the "mono"
> component is exposed to userspace.
> 
...

I'm having problems with emu10k1-multichannel-v008.patch. I have made a 
test program that demonstrates the bug. The program works alone, but the 
bug is triggered when I play a song in xmms, and at the same time run 
the test program.

The test program is based on patest_sine.c in PortAudio V18.1. It 
repeatedly plays a sine signal for one second. When playing a stereo 
stream it fails to open the oss device the sixth time. And when playing 
a mono stream it fails to open the device the eighth time.

Running the test program again doesn't work at all. I have to stop xmms 
to reset the bug.

Output from test program and PostAudio library:

Stereo stream
-------------
PortAudio Test: output sine wave. SR = 44100, BufSize = 64, devID = 0
Pa_SetupDeviceFormat: could not SNDCTL_DSP_CHANNELS
An error occured while using the portaudio stream
Error number: -10000
Error message: Host error.
PortAudio Test: output sine wave. SR = 44100, BufSize = 64, devID = 0
Pa_QueryDevice: could not get format info
Pa_SetupDeviceFormat: could not SNDCTL_DSP_SETFMT
An error occured while using the portaudio stream
Error number: -10000
Error message: Host error.
PortAudio Test: output sine wave. SR = 44100, BufSize = 64, devID = 0
Pa_QueryDevice: could not get format info
Pa_SetupDeviceFormat: could not SNDCTL_DSP_SETFMT
An error occured while using the portaudio stream
Error number: -10000
Error message: Host error.

Mono stream
-----------
Pa_QueryDevice: no supported sample rate (or SNDCTL_DSP_SPEED ioctl call 
failed). Force 44100 Hz
Pa_SetupDeviceFormat: could not SNDCTL_DSP_SETFMT
An error occured while using the portaudio stream
Error number: -10000
Error message: Host error.
PortAudio Test: output sine wave. SR = 44100, BufSize = 64, devID = 0
Pa_QueryDevice: could not get format info
Pa_SetupDeviceFormat: could not SNDCTL_DSP_SETFMT
An error occured while using the portaudio stream
Error number: -10000
Error message: Host error.


The log also contains several "kernel: first==last, number X, next free 
Y!", where X is 1 or 2, and Y 12,16,26,32,36 or 44.

I hope this helps.

Regards,
Mikael Magnusson

--------------060105070101070406040009
Content-Type: text/x-csrc;
 name="patest.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patest.c"

/*
 * $Id: patest_sine.c,v 1.2.4.1 2003/02/11 21:41:32 philburk Exp $
 * patest_sine.c
 * Play a sine wave using the Portable Audio api for several seconds.
 *
 * Authors:
 *    Ross Bencina <rossb@audiomulch.com>
 *    Phil Burk <philburk@softsynth.com>
 *
 * This program uses the PortAudio Portable Audio Library.
 * For more information see: http://www.audiomulch.com/portaudio/
 * Copyright (c) 1999-2000 Ross Bencina and Phil Burk
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files
 * (the "Software"), to deal in the Software without restriction,
 * including without limitation the rights to use, copy, modify, merge,
 * publish, distribute, sublicense, and/or sell copies of the Software,
 * and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * Any person wishing to distribute modifications to the Software is
 * requested to send the modifications to the original developer so that
 * they can be incorporated into the canonical version.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR
 * ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
 * CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 */
#include <stdio.h>
#include <math.h>
#include "portaudio.h"

#define NUM_SECONDS   (1)
#define SAMPLE_RATE   (44100)
#define AMPLITUDE     (0.9)
#define FRAMES_PER_BUFFER  (64)
#define OUTPUT_DEVICE Pa_GetDefaultOutputDeviceID()
//#define OUTPUT_DEVICE (2)

#ifndef M_PI
#define M_PI  (3.14159265)
#endif

#define TABLE_SIZE   (200)
typedef struct
{
    float sine[TABLE_SIZE];
    int left_phase;
    int right_phase;
}
paTestData;

/* This routine will be called by the PortAudio engine when audio is needed.
** It may called at interrupt level on some machines so don't do anything
** that could mess up the system like calling malloc() or free().
*/
static int patestCallback(   void *inputBuffer, void *outputBuffer,
                             unsigned long framesPerBuffer,
                             PaTimestamp outTime, void *userData )
{
    paTestData *data = (paTestData*)userData;
    float *out = (float*)outputBuffer;
    unsigned long i;
    int finished = 0;
    (void) outTime; /* Prevent unused variable warnings. */
    (void) inputBuffer;
    for( i=0; i<framesPerBuffer; i++ )
    {
        *out++ = data->sine[data->left_phase];  /* left */
//        *out++ = data->sine[data->right_phase];  /* right */
        data->left_phase += 1;
        if( data->left_phase >= TABLE_SIZE ) data->left_phase -= TABLE_SIZE;
        data->right_phase += 3; /* higher pitch so we can distinguish left and right. */
        if( data->right_phase >= TABLE_SIZE ) data->right_phase -= TABLE_SIZE;
    }
    return finished;
}

/*******************************************************************/
int play(void)
{
    PortAudioStream *stream;
    PaError err;
    paTestData data;
    int i;
    printf("PortAudio Test: output sine wave. SR = %d, BufSize = %d, devID = %d\n",
    	SAMPLE_RATE, FRAMES_PER_BUFFER, OUTPUT_DEVICE);
    /* initialise sinusoidal wavetable */
    for( i=0; i<TABLE_SIZE; i++ )
    {
        data.sine[i] = (float) (AMPLITUDE * sin( ((double)i/(double)TABLE_SIZE) * M_PI * 2. ));
    }
    data.left_phase = data.right_phase = 0;
    err = Pa_Initialize();
    if( err != paNoError ) goto error;
    err = Pa_OpenStream(
              &stream,
              paNoDevice,/* default input device */
              0,              /* no input */
              paFloat32,  /* 32 bit floating point input */
              NULL,
              OUTPUT_DEVICE,
              1,          /* stereo output */
              paFloat32,      /* 32 bit floating point output */
              NULL,
              SAMPLE_RATE,
              FRAMES_PER_BUFFER,
              0,              /* number of buffers, if zero then use default minimum */
              paClipOff,      /* we won't output out of range samples so don't bother clipping them */
              patestCallback,
              &data );
    if( err != paNoError ) goto error;
    err = Pa_StartStream( stream );
    if( err != paNoError ) goto error;
    printf("Play for %d seconds.\n", NUM_SECONDS ); fflush(stdout);
    Pa_Sleep( NUM_SECONDS * 1000 );

    err = Pa_StopStream( stream );
    if( err != paNoError ) goto error;
    err = Pa_CloseStream( stream );
    if( err != paNoError ) goto error;
    Pa_Terminate();
    printf("Test finished.\n");
    return err;
error:
    Pa_Terminate();
    fprintf( stderr, "An error occured while using the portaudio stream\n" );
    fprintf( stderr, "Error number: %d\n", err );
    fprintf( stderr, "Error message: %s\n", Pa_GetErrorText( err ) );
    return err;
}


int main()
{
    int i;

    for (i = 0; i < 10; i++) {
	play();
    }
    getchar();
}

--------------060105070101070406040009--


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
