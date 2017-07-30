From: tsepp2001@t-online.de
Subject: Basic questions
Date: Sun, 30 Jul 2017 12:00:04 +0200
Message-ID: <97e15f1e-2bd6-9eb8-45a8-4cfbd862ede9@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout04.t-online.de (mailout04.t-online.de [194.25.134.18])
 by alsa0.perex.cz (Postfix) with ESMTP id 20B0F266D77
 for <alsa-devel@alsa-project.org>; Sun, 30 Jul 2017 12:00:06 +0200 (CEST)
Received: from fwd18.aul.t-online.de (fwd18.aul.t-online.de [172.20.26.244])
 by mailout04.t-online.de (Postfix) with SMTP id 953DD419A6D6
 for <alsa-devel@alsa-project.org>; Sun, 30 Jul 2017 12:00:06 +0200 (CEST)
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

Hi everybody,

I am new to ALSA-API and would be glad, if someone give me an advice to 
the following questions. Up to now I used Rtaudio for cross compiling 
the player for windows and Linux. But know I need to go more into ALSA...

- Am I right to use async mode to get lowest latency times and using 
pause/play/stop?

- I used the following piece of code. But don't get any output. The 
callback output shows "avail" with very short count of frames...

I write a whole file (raw) to buffer, called buffer_alsa with 6894888 
frames. What is going wrong?

I get this output:

	       Frames:  6894888
  buffer_size (frames):  2048
  buffer_time (frames):  46439
  period_size (frames):  256
    period_time (usec):  5804
       periods (count):  8
Avail:  1540
Avail:  1285
Avail:  1030
Avail:  775
Avail:  520
Avail:  265
Avail:  10
Avail:  2
Avail:  2
Avail:  3
Avail:  2
...

The code follows ...

Best regards
Thomas

-----------------------------

void MyCallback(snd_async_handler_t *pcm_callback)
{
snd_pcm_t *handle = snd_async_handler_get_pcm(pcm_callback);
snd_pcm_sframes_t avail;

//std::cout << "Period_size:  " << period_size << std::endl;

avail = snd_pcm_avail_update(handle);
while (avail >= period_size)
{
     snd_pcm_writei(handle, buffer_alsa , period_size);
     avail = snd_pcm_avail_update(handle);
     std::cout << "      Avail:  " << avail << std::endl;
}
}

//----------------------------------------------------

snd_pcm_hw_params_alloca(&params);

if ((err = snd_pcm_hw_params_any(handle, params)) < 0)
std::cout << "      Error (reading configuration):  " << 
snd_strerror(err) << std::endl;

/* Set parameters */
if ((err = snd_pcm_hw_params_set_access(handle, 
params,SND_PCM_ACCESS_RW_INTERLEAVED)) < 0)
//printf("ERROR: Can't set interleaved mode. %s\n", snd_strerror(err));
std::cout << " Error (can't set interleaved mode):  " << 
snd_strerror(err) << std::endl;

if ((err = snd_pcm_hw_params_set_format(handle, params, FORMAT)) < 0)
//printf("ERROR: Can't set format. %s\n", snd_strerror(err));
std::cout << "           Error (can't set format):  " << 
snd_strerror(err) << std::endl;

if ((err = snd_pcm_hw_params_set_channels(handle, params, 
data.channels)) < 0)
//printf("ERROR: Can't set channels number. %s\n", snd_strerror(err));
std::cout << "  Error (can't set channels number):  " << 
snd_strerror(err) << std::endl;

if ((err = snd_pcm_hw_params_set_rate_near(handle, params, &fs, 0)) < 0)
//printf("ERROR: Can't set rate. %s\n", snd_strerror(err));
std::cout << "             Error (can't set rate):  " << 
snd_strerror(err) << std::endl;

if ((err = snd_pcm_hw_params_set_buffer_size_near(handle, params, 
&buffer_size)) < 0)
std::cout << "      Error (can't set buffer size):  " << 
snd_strerror(err) << std::endl;

if ((err = snd_pcm_hw_params_set_period_size_near (handle, params, 
&period_size, NULL)) < 0)
std::cout << "      Error (can't set period size):  " << 
snd_strerror(err) << std::endl;

/* Write parameters */
if ((err = snd_pcm_hw_params(handle, params)) < 0)
//printf("ERROR: Can't set hardware parameters. %s\n", snd_strerror(err));
std::cout << "   Error (can't set harware params):  " << 
snd_strerror(err) << std::endl;

//---------------------- ------------------------------

// Get Parameters
snd_pcm_hw_params_get_buffer_size(params, &buffer_sz);
std::cout << "               buffer_size (frames):  " << buffer_sz << 
std::endl;

snd_pcm_hw_params_get_buffer_time(params, &buffer_tm, NULL);
std::cout << "               buffer_time (frames):  " << buffer_tm << 
std::endl;

snd_pcm_hw_params_get_period_size(params, &aframes, 0);
std::cout << "               period_size (frames):  " << aframes << 
std::endl;

snd_pcm_hw_params_get_period_time(params, &data.channels, NULL); // tmp 
Zeit in us
std::cout << "                 period_time (usec):  " << data.channels 
<< std::endl;

snd_pcm_hw_params_get_periods(params, &piods, 0);
std::cout << "                    periods (count):  " << piods << std::endl;

// 
----------------------------------------------------------------------------

//snd_pcm_hw_params_free (params);

// --------------------- Hardware-Params End ------------------------------

snd_pcm_sw_params_t *sw_params;

if ((err = snd_pcm_sw_params_malloc (&sw_params)) < 0)
{
std::cout << "   Error (can't allocate sw params):  " << 
snd_strerror(err) << std::endl;
return;
}
if ((err = snd_pcm_sw_params_current(handle, sw_params)) < 0)
{
std::cout << "Error (can't return curr sw config):  " << 
snd_strerror(err) << std::endl;
return;
}

if ((err = snd_pcm_sw_params_set_start_threshold (handle, sw_params, 
buffer_size)) < 0) // 0U oder 4096 ?
{ // This parameter controls the wake up point. If the count of 
available samples is equal or greater than this value, then the 
application will be activated.
std::cout << "Error (can't set start thresh mode):  " << 
snd_strerror(err) << std::endl;
return;
}
/*
if ((err = snd_pcm_sw_params_set_silence_threshold( handle, sw_params, 0 
)) < 0)
{
std::cout << "    Error (can't set silence thres):  " << 
snd_strerror(err) << std::endl;
return;
}
*/
if ((err = snd_pcm_sw_params_set_avail_min (handle, sw_params, 
period_size)) < 0)
{
std::cout << "  Error (can't set min avail count):  " << 
snd_strerror(err) << std::endl;
return;
}
// here are two options for a fix
//snd_pcm_sw_params_set_silence_size( phandle, sw_params, ULONG_MAX );
/*
snd_pcm_uframes_t val;
if ((err = snd_pcm_sw_params_get_boundary(sw_params, &val)) < 0)
{
std::cout << "         Error (can't get boundary):  " << 
snd_strerror(err) << std::endl;
return;
}
if ((err = snd_pcm_sw_params_set_silence_size(handle, sw_params, val)) < 0)
{
std::cout << "          Error (can't set silence):  " << 
snd_strerror(err) << std::endl;
return;
}
*/
if ((err = snd_pcm_sw_params(handle, sw_params)) < 0)
{
std::cout << "        Error (can't set sw params):  " << 
snd_strerror(err) << std::endl;
return;
}
snd_pcm_sw_params_free(sw_params);

// ------------------------- SW-Params End ---------------------------------

if ((err = snd_pcm_prepare(handle)) < 0)
{
std::cout << "        Error (can't prepare audio):  " << 
snd_strerror(err) << std::endl;
return;
}
snd_async_handler_t *pcm_callback;
if ((err = snd_async_add_pcm_handler(&pcm_callback, handle, MyCallback, 
NULL)) < 0)
{
std::cout << "      Error (can't add pcm handler):  " << 
snd_strerror(err) << std::endl;
return;
}
if ((err = snd_pcm_writei(handle, buffer_alsa, 2 * period_size) == -EPIPE))
{
std::cout << "                              Error:  XRUN" << std::endl;
err = snd_pcm_recover(handle, err, 0);
if ((err = snd_pcm_prepare (handle)) < 0)
{
     std::cout << "        Error (can't prepare audio):  " << 
snd_strerror(err) << std::endl;
     return;
}
}
if ((err = snd_pcm_start(handle)) < 0)
{
std::cout << "          Error (can't start audio):  " << 
snd_strerror(err) << std::endl;
return;
}

void MyCallback(snd_async_handler_t *pcm_callback);
