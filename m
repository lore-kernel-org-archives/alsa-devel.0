From: "Paul Adolph" <padolph@gmail.com>
Subject: Re: Async behavior and -EAGAIN on write?
Date: Sun, 1 Jun 2008 20:15:05 -0700
Message-ID: <fe9483990806012015y5144ecb2h646adaf29eba8e10@mail.gmail.com>
References: <fe9483990805301401h7d29aebdm4eeb8ccd5899687@mail.gmail.com>
	<75b66ecd0805301853n750434ex1ad2c7dfa94ecac9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-bounces@lists.sourceforge.net>
In-Reply-To: <75b66ecd0805301853n750434ex1ad2c7dfa94ecac9@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=alsa-user>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-user-bounces@lists.sourceforge.net
Errors-To: alsa-user-bounces@lists.sourceforge.net
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@alsa-project.org, alsa-user@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>> For playback I am using the ALSA callback to wake up a thread that
>> then feeds the ALSA ring buffer with a period-worth of samples using
>> snd_pcm_writei(). I've set snd_pcm_sw_params_set_avail_min() to one
>> period. The problem is that most of the time when my thread wakes up
>> and tries to write the data, snd_pcm_writei() fails with -EAGAIN, and
>> I must retry until it works.
>>
>> Presumably this write failure is because there is not enough space in
>> the ring buffer, but then why did the ALSA callback fire in the first
>> place? As it stands my retries are eating needless amounts of CPU.
>>
>
> What does snd_pcm_avail_update return if you call it before
> snd_pcm_writei in your callback?

Taking the sleep out of my thread so I respond to the ALSA callback
wakeups as often as possible, I found that snd_pcm_avail_update()
returns very small values, usually less than 1/2 the period size and
sometimes even 0!  It seems as if I'm getting callbacks whenever ALSA
feels like giving them. This behavior does not seem to change at all
even with different settings of snd_pcm_sw_params_set_avail_min()! I
must be missing some key thing in all this.

Here are some of the readings. This is with
snd_pcm_sw_params_set_avail_min(period_size) and period_size = 470
frames.
avail = 68
avail = 202
avail = 336
avail = 0
avail = 134

>What period and buffer sizes do you use?

I am using set_buffer/period_time_near and read back the actual
values. I get the following with the settings I'm using.
  buffer_size  : 7526 frames
  period_size  : 470 frames

I'm set to 22050 sampling rate, 16-bit signed interleaved samples.

> FYI, you should seriously consider using poll() rather than the
> async/callback interface.  It's more efficient than signals and more
> compatible with various IO plugins like pulseaudio.

Yes - I'm looking into this for sure. This async mode has caused me
lots of problems. My main issue is that I'm almost out of time to
spend on this part of the project. :-(

Thanks for your help.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
