From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Programming ALSA sound device.
Date: Fri, 17 Sep 2010 10:15:46 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1009171013250.6226@eeebox2.perex-int.cz>
References: <AANLkTikVq+q9uuprpCNZRB30-6LnaXEAe98xHm-gaA-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 7664710390A
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Sep 2010 10:15:47 +0200 (CEST)
In-Reply-To: <AANLkTikVq+q9uuprpCNZRB30-6LnaXEAe98xHm-gaA-Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Bankim Bhavsar <bankim.bhavsar@gmail.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 16 Sep 2010, Bankim Bhavsar wrote:

> Producer thread writes sound bytes worth 10 ms every 10 ms to a ring buffer.
> Consumer thread is responsible for writing sound bytes to ALSA sound
> device in a strictly non-blocking fashion.
> Consumer thread checks snd_pcm_avail/snd_pcm_avail_update, fetches
> minimum of sound bytes available in ring buffer and
> availFrames(returned by snd_pcm_avail_update) and writes to sound
> device using snd_pcm_writei().
> Consumer thread polls every 20 ms. However on consumer thread
> snd_pcm_avail/snd_pcm_avail_update() returns 0 at least 3-4 times
> consecutively (total 60-80 ms) and on every 5th-6th poll
> snd_pcm_avail/snd_pcm_avail_update returns full buffer size
> occasionally reporting an under-run. On an average, under-run is
> reported at least 10-15 times a minute which is not desirable.
>
> Following are the hardware and software parameter settings.
>
> hardware params:
>   16-bit 44100 stereo
>   buffer time 200 ms
>   period time 25 ms
>
> software params:
>   start_threshold: full buffer size
>   no setting for avail_min
>
> Alternatively I've tried using wait_for_poll() technique as mentioned
> in the example.
> http://www.alsa-project.org/alsa-doc/alsa-lib/_2test_2pcm_8c-example.html
> However poll() unblocks very rapidly and producer ring buffer doesn't
> have enough bytes.
>
> What's the best technique for PCM playback for such use cases? Is it
> okay to skip calling snd_pcm_avail/snd_pcm_avail_update and directly
> attempt writing to ALSA sound device instead?
> Let me know if more information is required.

Show us snd_pcm_dump() output for your ALSA PCM handle and eventually, try 
to compare your code with alsa-lib/test/latency.c what you're doing wrong.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
