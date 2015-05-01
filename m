From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: Assert in pcm_params.c
Date: Fri, 1 May 2015 08:36:47 +0100
Message-ID: <201505010836.47714.gineera@aspect135.co.uk>
References: <201504180908.47022.gineera@aspect135.co.uk>
 <201504201217.36477.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_P0yQVF9SEgVElvm"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.ip04ir2.opaltelecom.net (out1.ip04ir2.opaltelecom.net
 [62.24.128.240])
 by alsa0.perex.cz (Postfix) with ESMTP id D68962606AB
 for <alsa-devel@alsa-project.org>; Fri,  1 May 2015 09:37:16 +0200 (CEST)
In-Reply-To: <201504201217.36477.gineera@aspect135.co.uk>
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_P0yQVF9SEgVElvm
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 20 April 2015 12:17, Alan Horstmann wrote:
> On Saturday 18 April 2015 09:08, Alan Horstmann wrote:
> > The following assert is being hit in pcm_params.c:
> >
> > "pcm_params.c:2249: snd1_pcm_hw_params_slave: Assertion `err >=3D 0'
> > failed."
> >
> > This is from a developer using Portaudio in his own application; I have
> > yet to ascertain full details, but it is trying successive sample rates
> > to see which are valid.
>
> Further info: this occurs with an Intel motherboard/soundcard, attempting
> to open and config the stream at 44100 using front, surround or hdmi pcm,
> having previously opened and tried at a lower, not-supported samplerate,
> and closed. AFAIK other pcms work OK.
>
> The assert is hit with all current Debian and Ubuntu distros, for example
>      Debian 8 (jessie) 32 bit:  kernel 3.16.0-4-686-pae (Alsa 1.0.28)
> but is not seen with Fedora 20 or OpenSuse 12.1 (do they have asserts
> off?).
>
> > Does this point to a flaw in the configuration or possibly a bug in
> > Alsa-lib or can it occur just as a result of misuse of the Alsa API?
>
> I will try to conceive some more tests.  How can we debug this further?

A minimal self-contained demo program ('test-format') has been developed an=
d=20
is attached, that demonstrates the issue 100% on the reporters machine=20
(HDA-Intel, 6-ch I believe).  The output is:

root@Xeon:/home/patest# ./test-format=20
Testing device front
Num channels 6
Testing rate: 22050 =A0 Result:...Invalid Sample Rate
Testing rate: 32000 =A0 Result:...Invalid Sample Rate
test-format: pcm_params.c:2249: snd1_pcm_hw_params_slave: Assertion `err >=
=3D
0' failed.
Testing rate: 44100 =A0 Aborted

Alsa-info is at:

http://www.alsa-project.org/db/?f=3D19dfeee29f73007e61a00a8fabe3c958f7cb8e87

This apparently happens with or without Pulseaudio running, with just the=20
single 44100 rate, and also with surround devices.  Also, on all current=20
Debian and Ubuntu - we have focused on Jessie.

I do not have a machine with similar hardware, so cannot duplicate the=20
results.

Any comments, ideas etc would be appreciated.

Regards

Alan

--Boundary-00=_P0yQVF9SEgVElvm
Content-Type: text/x-csrc;
  charset="iso-8859-1";
  name="test_format.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="test_format.c"

/*
 * test_format.c
 *
 * A minimal Alsa-Linux parameter test program derived crudely from Portaudio source code
 *
 * Compile from the command-line:  'gcc -Wall -Wextra -o test-format test_format.c -lasound'
 *
 * Alan Horstmann  30th April 2015
 */

/*
 * PortAudio Portable Real-Time Audio Library
 * Latest Version at: http://www.portaudio.com
 * ALSA implementation by Joshua Haberman and Arve Knudsen
 *
 * Copyright (c) 2002 Joshua Haberman <joshua@haberman.com>
 * Copyright (c) 2005-2009 Arve Knudsen <arve.knudsen@gmail.com>
 * Copyright (c) 2008 Kevin Kofler <kevin.kofler@chello.at>
 * Copyright (c) 2014-2015 Alan Horstmann <gineera@aspect135.co.uk>
 *
 * Based on the Open Source API proposed by Ross Bencina
 * Copyright (c) 1999-2002 Ross Bencina, Phil Burk
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
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR
 * ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
 * CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */


#define ALSA_PCM_NEW_HW_PARAMS_API
#define ALSA_PCM_NEW_SW_PARAMS_API
#include <alsa/asoundlib.h>
#undef ALSA_PCM_NEW_HW_PARAMS_API
#undef ALSA_PCM_NEW_SW_PARAMS_API


/* Parameters of the particular test - change to suit */
#define TEST_ALSA_FORMAT SND_PCM_FORMAT_S16
#define TEST_SAMPLE_RATES {22050, 32000, 44100, 48000, 96000, 0} /* An array initialisation for test rates, zero terminate */
#define TEST_HOST_CHANNELS 6
#define TEST_HOST_DEVICE_NAME "front" //"surround40" //"surround51"
#define TEST_STREAM_DIRECTION StreamDirection_Out

#define RATE_MAX_DEVIATE_RATIO 100


/* Extracts from portaudio.h: */
typedef int PaError;
typedef enum PaErrorCode
{
    paNoError = 0,
    paUnanticipatedHostError = -9999,
    paInvalidChannelCount,
    paInvalidSampleRate,
    paSampleFormatNotSupported,
    paBadIODeviceCombination,
    paDeviceUnavailable,
    paIncompatibleStreamHostApi,
} PaErrorCode;

typedef int PaDeviceIndex;
typedef double PaTime;
typedef unsigned long PaSampleFormat;

typedef struct PaStreamParameters
{
    PaDeviceIndex device;
    int channelCount;
    PaSampleFormat sampleFormat;
    PaTime suggestedLatency;
    void *hostApiSpecificStreamInfo;

} PaStreamParameters;

typedef enum
{
    StreamDirection_In,
    StreamDirection_Out
} StreamDirection;

typedef struct PaAlsaStreamInfo
{
    unsigned long size;
    int hostApiType;
    unsigned long version;

    const char *deviceString;
}
PaAlsaStreamInfo;


/* Local functions derived from pa_linux_alsa.c: */
int Alsa_OpenPcm( snd_pcm_t **pcmp, const char *name, snd_pcm_stream_t stream, int mode, int waitOnBusy )
{
    int ret, tries = 0, maxTries = waitOnBusy ? 100 : 0;

    ret = snd_pcm_open( pcmp, name, stream, mode );

    for( tries = 0; tries < maxTries && -EBUSY == ret; ++tries )
    {
        usleep( 10000 );
        ret = snd_pcm_open( pcmp, name, stream, mode );
        if( -EBUSY != ret )
        {
            printf( "%s: Successfully opened initially busy device after %d tries\n", __FUNCTION__, tries );
        }
    }
    if( -EBUSY == ret )
    {
        printf( "%s: Failed to open busy device '%s'\n", __FUNCTION__, name );
    }
    else
    {
        if( ret < 0 )
            printf( "%s: Opened device '%s' ptr[%p] - result: [%d:%s]\n", __FUNCTION__, name, *pcmp, ret, snd_strerror(ret) );
    }

    return ret;
}


static PaError AlsaOpen( const PaStreamParameters *params, StreamDirection streamDir, snd_pcm_t **pcm )
{
    PaError result = paNoError;
    int ret;
    const char* deviceName = NULL;
    PaAlsaStreamInfo *streamInfo = (PaAlsaStreamInfo *)params->hostApiSpecificStreamInfo;

    if( !streamInfo )
    {
        deviceName = TEST_HOST_DEVICE_NAME;
    }
    else
        deviceName = streamInfo->deviceString;

    //printf( "%s: Opening device %s\n", __FUNCTION__, deviceName );
    if( (ret = Alsa_OpenPcm( pcm, deviceName, streamDir == StreamDirection_In ? SND_PCM_STREAM_CAPTURE : SND_PCM_STREAM_PLAYBACK,
                    SND_PCM_NONBLOCK, 1 )) < 0 )
    {
        /* Not to be closed */
        *pcm = NULL;
        if( ret < 0 )
            return ( -EBUSY == ret ? paDeviceUnavailable : paBadIODeviceCombination );
    }
    if( snd_pcm_nonblock( *pcm, 0 ) )
        return paUnanticipatedHostError;

    return result;
}


/* Set the stream sample rate to a nominal value requested; allow only a defined tolerance range */
int Alsa_SetApproximateSampleRate( snd_pcm_t *pcm, snd_pcm_hw_params_t *hwParams, double sampleRate )
{
    PaError result = paNoError;
    unsigned int reqRate, setRate, deviation;

    assert( pcm && hwParams );

    /* The Alsa sample rate is set by integer value; also the actual rate may differ */
    reqRate = setRate = (unsigned int) sampleRate;

    if( snd_pcm_hw_params_set_rate_near( pcm, hwParams, &setRate, NULL ) < 0 )
        return paUnanticipatedHostError;
    /* The value actually set will be put in 'setRate' (may be way off); check the deviation as a proportion
     * of the requested-rate with reference to the max-deviate-ratio (larger values allow less deviation) */
    deviation = abs( setRate - reqRate );
    if( deviation > 0 && deviation * RATE_MAX_DEVIATE_RATIO > reqRate )
        result = paInvalidSampleRate;

    return result;
}


static PaError TestParameters( const PaStreamParameters *parameters, double sampleRate, StreamDirection streamDir )
{
    PaError result = paNoError;
    snd_pcm_t *pcm = NULL;
    unsigned int numHostChannels;
    snd_pcm_format_t alsaFormat = TEST_ALSA_FORMAT;
    snd_pcm_hw_params_t *hwParams;

    snd_pcm_hw_params_alloca( &hwParams );

    if( !parameters->hostApiSpecificStreamInfo )
    {
        numHostChannels = TEST_HOST_CHANNELS;
    }
    else
        numHostChannels = parameters->channelCount;

    if( AlsaOpen( parameters, streamDir, &pcm ) < 0)
    {
        result = paUnanticipatedHostError;
        printf( "%s: AlsaOpen failed\n", __FUNCTION__ );
        goto error;
    }

    snd_pcm_hw_params_any( pcm, hwParams );

    if( Alsa_SetApproximateSampleRate( pcm, hwParams, sampleRate ) < 0 )
    {
        result = paInvalidSampleRate;
        goto error;
    }

    if( snd_pcm_hw_params_set_channels( pcm, hwParams, numHostChannels ) < 0 )
    {
        result = paInvalidChannelCount;
        goto error;
    }

    /* Some specific hardware (reported: Audio8 DJ) can fail with assertion during this step. */
    if( snd_pcm_hw_params_set_format( pcm, hwParams, alsaFormat ) < 0 )
        return paSampleFormatNotSupported;

    {
        /* It happens that this call fails because the device is busy */
        int ret = 0;
        if( ( ret = snd_pcm_hw_params( pcm, hwParams ) ) < 0 )
        {
            if( -EINVAL == ret )
            {
                /* Don't know what to return here */
                result = paBadIODeviceCombination;
                goto error;
            }
            else if( -EBUSY == ret )
            {
                result = paDeviceUnavailable;
                printf( "%s: Device is busy\n", __FUNCTION__ );
            }
            else
            {
                result = paUnanticipatedHostError;
            }

            if( ret < 0 )
                return result;
        }
    }

end:
    if( pcm )
    {
        snd_pcm_close( pcm );
    }
    return result;

error:
    goto end;
}



/* This will test each of the listed sample rates at the given format, device and num channels */
int main()
{
    PaStreamParameters strParams;
    PaError testResult = paNoError;
    char *testMessg;
    int i = 0, testRates[] = TEST_SAMPLE_RATES;

    strParams.hostApiSpecificStreamInfo = NULL;
    strParams.channelCount = TEST_HOST_CHANNELS;

    printf( "Testing device %s\n", TEST_HOST_DEVICE_NAME );
    printf( "Num channels %u\n", TEST_HOST_CHANNELS );

    while( testRates[i] > 0 )
    {
        printf( "Testing rate: %i   ", testRates[i] );
        testResult = TestParameters( &strParams, testRates[i], TEST_STREAM_DIRECTION);

        switch( testResult )
        {
            case paNoError: testMessg = "Success!!!"; break;
            case paInvalidSampleRate: testMessg = "Invalid Sample Rate"; break;
            case paInvalidChannelCount: testMessg = "Invalid Num Channels"; break;
            case paSampleFormatNotSupported: testMessg = "Invalid Format"; break;
            default: testMessg = "Unexpected Result???";
        }
        printf("Result:...%s\n", testMessg );

        i++;
    }

    return testResult;
}

--Boundary-00=_P0yQVF9SEgVElvm
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--Boundary-00=_P0yQVF9SEgVElvm--
