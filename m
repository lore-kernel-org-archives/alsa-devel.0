From: Steve deRosier <derosier@pianodisc.com>
Subject: Re: How to tell how many frames gone to PCM
Date: Wed, 27 Apr 2005 09:43:00 -0700
Message-ID: <426FC114.6000800@pianodisc.com>
References: <426EA20A.70403@pianodisc.com> <ad2655cb0504270201165f9859@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <ad2655cb0504270201165f9859@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <james.dutton@gmail.com>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

> 
> You might want the "snd_pcm_delay()" function.
> This will return a count of frames in the buffer that have not yet
> reached the ADC.
> E.g.
> snd_pcm_write()   <- Write 1024 frames to the buffer.
> snd_pcm_delay()  <- If this returns 500, it means that 525 frames have
> already been played out of the speakers.
> 
> The snd_pcm_delay() function was introduced into alsa to help
> audio/video application do lip sync. We could therefore calculate that
> if we write a frame to the buffer now, it will reach the speakers in
> exactly snd_pcm_delay() frames time.
> 
> Does this help you?

I've got it implemented in my system, but actually it doesn't solve the problem (and actually exasperates it).

See, we calculate the midi times based on the "sample" time that the midi msg arrives at.

So, for example:

Our AlsaSender task receives a right and left audio sample (the two together I suppose is called a frame), and the last MIDI byte of a message.  It keeps a counter of how many audio frames are received at this point.  It sends the audio frame to alsa (actually the CDSP function buffers up PERIOD_SIZE number of samples before it does the ..._writei() in order to not cause excessive function call overhead).  It calculates the MIDI timestamp based on the number of samples it has sent off:

snd_seq_real_time_t time;
unsigned long long int iTime = (((mPlayedSampleCount*10*P_MILLION)/441);
time.tv_sec = iTime/P_BILLION;
time.tv_nsec = iTime%P_BILLION;

snd_seq_ev_set_source(&event, mPort);
snd_seq_ev_set_subs(&event);
snd_seq_ev_schedule_real(&event, mQueue, 0, &time);
snd_seq_event_output(hSeq, &event);
snd_seq_drain_output(hSeq);

Our audio source is CD, so 44100 is the correct speed for the calculation (non-significant zeros canceled off in the calculation).

Anything obviously wrong with my approach?

Thanks,
- Steve


-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
