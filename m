From: Enno Fennema <ennofennema@tele2.nl>
Subject: Re: snd_pcm_wait function (really snd_pcm_draiin)
Date: Fri, 16 Nov 2012 17:27:07 +0100
Message-ID: <50A6695B.6080202@tele2.nl>
References: <50A0A3FE.4090901@tele2.nl>	<50A0A709.1050307@ladisch.de>	<CA+7tXihDCpmvVpPCErz5WrZ8BtZTB+orp=W77dgXwwFsaX9eeQ@mail.gmail.com>	<CAHU0+dQvuNAY8U735GY2n_kA2F3+1ooobKRrtOt2KTwSBF12dg@mail.gmail.com>	<CA+7tXihLxEsMFBhx5gnXUMbCyTD+tfAWQGYLxavC3YUNMb0JfQ@mail.gmail.com>
 <CAHU0+dTL=rc6gMc49cWiUL3rL2_92myqYrReCUbK3hVy4BB=DA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080009090403010209030906"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from swip.net (mailfe07.tele2.nl [212.247.154.206])
 by alsa0.perex.cz (Postfix) with ESMTP id 430A926509E
 for <alsa-devel@alsa-project.org>; Fri, 16 Nov 2012 17:25:24 +0100 (CET)
In-Reply-To: <CAHU0+dTL=rc6gMc49cWiUL3rL2_92myqYrReCUbK3hVy4BB=DA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Sanz <daniellsanz2@gmail.com>
Cc: alsa-devel@alsa-project.org, Trent Piepho <tpiepho@gmail.com>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080009090403010209030906
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 11/16/12 11:41, Daniel Sanz wrote:
> Thanks, Trent, I've been playing a bit with snd_pcm_drain,
> snd_pcm_writei, blocking mode, non-blocking mode, etc. but even if I
> ...

I wanted to play a short sound and release the pcm. It works with a 
non-block drain as Clemens suggested.

I noticed using gettimeofday() around drain() that it takes a bit over 2 
seconds. Rather long for a sound that only takes 0.1 sec.
Not draining aand a usleep() for 0.1 sec plays the full time and 
releases the cpm quicker. As you see in attached example I don't bother 
with periods either.

Not exactly your question but I have given up on drainage for my current 
application.

Regards,
Enno Fennema

--------------080009090403010209030906
Content-Type: text/x-csrc;
 name="drain.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="drain.c"

#include <alsa/asoundlib.h>
#include <math.h>

int main(int argc, char** argv) {
  int err, i, n;
  snd_pcm_t *handle;
  int16_t buffer[500];

  for( i = 0; i < 500; i++ ) {		// put 500 samples in buffer
    double omega = (double)(i % 50) * 2.0 * M_PI / 50;
    buffer[i] = sin(omega) * 2500;
  }
  snd_pcm_open(&handle, "default", SND_PCM_STREAM_PLAYBACK, 0);
  snd_pcm_set_params(handle, SND_PCM_FORMAT_S16, 
		     SND_PCM_ACCESS_RW_INTERLEAVED, 
		     1, 22000, 0, 50000 );
  snd_pcm_start(handle);

  n = 2200;		
  while( n > 500 ) {
    err = snd_pcm_writei(handle, buffer, 500);
    if( err < 0 )
      printf("Error %d : %s\n", err, snd_strerror(err));
    n -= err;
  }
  err = snd_pcm_writei(handle, buffer, n);

#if 0
  snd_pcm_nonblock(handle, 0);	// ** 1 - nonblock; 0 - Do block
  snd_pcm_drain(handle);
#else
  usleep(100000);
#endif
  return 0;
}

--------------080009090403010209030906
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------080009090403010209030906--
