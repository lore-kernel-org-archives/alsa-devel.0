From: Carlo Wood <carlo@alinoe.com>
Subject: Re: I thought it would simple....
Date: Wed, 23 Jul 2003 13:07:50 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030723110750.GA2492@alinoe.com>
References: <20030723065449.40812.qmail@web21508.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="NzB8fVQJ5HfG6fxh"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20030723065449.40812.qmail@web21508.mail.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tsw@johana.com
Cc: alsa development <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I found that a better example for playback is
the 'pcm.c' file that you can find on the alsa site.
It contains many ways to deliver the data (a nice
sine) to your soundcard.  Playing with the parameters
gives some insight (more than reading the overall poor
documentation imho :().

Anyway - I "translated" the one you mention to C++;
it works for me.  I'll include it below.

Compile like:

g++ playback.cc -lasound

For me, this gives a lot of buffer overruns...
pcm.c doesn't suffer from that.

Note that I added:

dir = 0; // ??? According to valgrind, this value is USED (read) for a conditional jump!

Maybe that is a bug of alsa, maybe it is just badly
documented - but to be safe you should set that variable too.

On Tue, Jul 22, 2003 at 11:54:49PM -0700, Tom Watson wrote:
> I am attempting to write a "simple" audio playback program.  Well, I
> thought it would be, but...
> Somehow (thru strace) the 'snd_pcm_writei' call goes and eventually
> does a system 'poll' call, but it doesn't return indicating that a
> write is OK to do.
> I've used similar parameters in 'aplay' and I see that it works.
> 
> The basis of the program I'm writing is the one described in _A
> Tutorial on Using the ALSA API_
> (http://equalarea.com/paul/alsa-audio.html), section entitled "A
> Minimal Playback Program".
> 
> One thing I've noted:  Some of the data printed out by "snd_pcm_dump"
> is different between my program and 'aplay'.  I suspect that there is a
> clue somewhere, but what is the "magic"??
> 
> If necessary, I can provide the 'strace' or the output from
> 'snd_pcm_dump', but in the interest of brevity...
> 
> Any "great clue" would be appreciated.

-- 
Carlo Wood <carlo@alinoe.com>

--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="playback.cc"

#include <alsa/asoundlib.h>
#include <iostream>
#include <cstring>

int main(void)
{
  // Handle for the PCM device.
  snd_pcm_t* pcm_handle;

  // Playback stream.
  snd_pcm_stream_t stream = SND_PCM_STREAM_PLAYBACK;

  // This structure contains information about
  // the hardware and can be used to specify the
  // configuration to be used for the PCM stream.
  snd_pcm_hw_params_t* hwparams;

  // Name of the PCM device, like plughw:0,0.
  // The first number is the number of the soundcard,
  // the second number is the number of the device.
  char const* pcm_name = "plughw:0,0";

  // Allocate the snd_pcm_hw_params_t structure on the stack.
  snd_pcm_hw_params_alloca(&hwparams);

  // Open PCM. The last parameter of this function is the mode.
  // If this is set to 0, the standard mode is used. Possible
  // other values are SND_PCM_NONBLOCK and SND_PCM_ASYNC.
  // If SND_PCM_NONBLOCK is used, read / write access to the
  // PCM device will return immediately. If SND_PCM_ASYNC is
  // specified, SIGIO will be emitted whenever a period has
  // been completely processed by the soundcard.
  if (snd_pcm_open(&pcm_handle, pcm_name, stream, 0) < 0)
  {
    std::cerr << "Error opening PCM device " << pcm_name << std::endl;
    return -1;
  }

  // Init hwparams with full configuration space.
  if (snd_pcm_hw_params_any(pcm_handle, hwparams) < 0)
  {
    std::cerr << "Can not configure this PCM device." << std::endl;
    return -1;
  }

  unsigned int rate = 22050;	// Sample rate.
  int exact_rate;		// Sample rate returned by snd_pcm_hw_params_set_rate_near.
  int dir;			// exact_rate == rate --> dir = 0
				// exact_rate < rate  --> dir = -1
				// exact_rate > rate  --> dir = 1
  int periods = 16;		// Number of periods.
  int periodsize = 1024;	// Periodsize (bytes).

  // Set access type. This can be either
  // SND_PCM_ACCESS_RW_INTERLEAVED or
  // SND_PCM_ACCESS_RW_NONINTERLEAVED.
  // There are also access types for MMAPed
  // access, but this is beyond the scope
  // of this introduction.
  if (snd_pcm_hw_params_set_access(pcm_handle, hwparams, SND_PCM_ACCESS_RW_INTERLEAVED) < 0)
  {
    std::cerr << "Error setting access." << std::endl;
    return -1;
  }

  // Set sample format to 'Signed 16 bit Little Endian'.
  if (snd_pcm_hw_params_set_format(pcm_handle, hwparams, SND_PCM_FORMAT_S16_LE) < 0)
  {
    std::cerr << "Error setting format." << std::endl;
    return(-1);
  }

  // Set sample rate.  If the exact rate is not supported
  // by the hardware, use nearest possible rate.
  dir = 0; // ??? According to valgrind, this value is USED (read) for a conditional jump!
  exact_rate = snd_pcm_hw_params_set_rate_near(pcm_handle, hwparams, rate, &dir);
  if (rate != exact_rate)
  {
    std::cerr << "The rate " << rate << " Hz is not supported by your hardware.\n "
                 "==> Using " << exact_rate << " Hz instead." << std::endl;
  }

  // Set number of channels.
  if (snd_pcm_hw_params_set_channels(pcm_handle, hwparams, 2) < 0)
  {
    std::cerr << "Error setting channels." << std::endl;
    return -1;
  }

  // Set number of periods. Periods used to be called fragments.
  if (snd_pcm_hw_params_set_periods(pcm_handle, hwparams, periods, 0) < 0)
  {
    std::cerr << "Error setting periods." << std::endl;
    return -1;
  }

  // Set buffer size (in frames). The resulting latency is given by
  // latency = periodsize * periods / (rate * bytes_per_frame).
  if (snd_pcm_hw_params_set_buffer_size(pcm_handle, hwparams, (periodsize * periods) >> 2) < 0)
  {
    std::cerr << "Error setting buffersize." << std::endl;
    return -1;
  }

  // Apply HW parameter settings to
  // PCM device and prepare device.
  if (snd_pcm_hw_params(pcm_handle, hwparams) < 0)
  {
    std::cerr << "Error setting HW params." << std::endl;
    return -1;
  }

  unsigned char* data;
  int pcmreturn;
  short s1, s2;
  int frames;

  data = (unsigned char*)malloc(periodsize);
  frames = periodsize >> 2;
  std::cout << "frames = " << frames << '\n';
  for (int l1 = 0; l1 < 100; ++l1)
  {
    for (int l2 = 0; l2 < frames; ++l2)
    {
      s1 = (l2 % 128) * 100 - 5000;  
      s2 = (l2 % 256) * 100 - 5000;  
      data[4 * l2] = (unsigned char)s1;
      data[4 * l2 + 1] = s1 >> 8;
      data[4 * l2 + 2] = (unsigned char)s2;
      data[4 * l2 + 3] = s2 >> 8;
    }
    while ((pcmreturn = snd_pcm_writei(pcm_handle, data, frames)) < 0)
    {
      if (pcmreturn == -EPIPE)
      {
	std::cout << "<<<<<<<<<<<<<<< Buffer Underrun >>>>>>>>>>>>>>>" << std::endl;
	snd_pcm_prepare(pcm_handle);
      }
      else
      {
        std::cout << "snd_pcm_writei: " << strerror(-pcmreturn) << '\n';
        break;
      }
    }
    std::cout << "pcmreturn = " << pcmreturn << '\n';
  }

  return 0;
}

--NzB8fVQJ5HfG6fxh--


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
