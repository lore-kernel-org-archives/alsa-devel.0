From: "Men Muheim" <muheim@gmx.ch>
Subject: RE: read time information
Date: Mon, 18 Nov 2002 10:55:56 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <003301c28ee8$b0bf0220$461d8481@profi>
References: <E18Chwc-0003K5-00@sc8-sf-list1.sourceforge.net>
Reply-To: <men@ife.ee.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E18Chwc-0003K5-00@sc8-sf-list1.sourceforge.net>
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

Two machines that are only connected through Ethernet should generate an
impulse signal at a well defined global time. I want to measure the
jitter between the two impulse signals. 

For that purpose I have implemented an application with two threads. One
thread is finding a mapping between the global time and the audio sample
clock (a clock which is directly related to the playout of audio
samples, e.g. a counter of currently played samples) by periodically
measuring the current sample clock. Therefore an API method such as 

snd_timer_info_get_ticks(...)
or
snd_pcm_delay(...)
or
snd_pcm_status_get_tstamp(...)

is needed.

The second thread generates an impulse at given sample clock. Therefore
it must know, which sample clock corresponds to what offset in the
snd_pcm_channel_area_t. 

How do you think I could achieve that with the given API?


Regards, Men



PS: I was talking of ADAT synch, because in normal play mode the ADAT
synch counts the number of samples currently played out.


> -----Original Message-----
> From: alsa-devel-admin@lists.sourceforge.net [mailto:alsa-devel-
> admin@lists.sourceforge.net] On Behalf Of Paul Davis
> Sent: Freitag, 15. November 2002 16:03
> To: men@ife.ee.ethz.ch
> Cc: alsa-devel@lists.sourceforge.net
> Subject: Re: [Alsa-devel] read time information
> 
> >For synchronization purpose I need the current time of my sound card
> >(information on the sample that is currently played out might be
> >sufficient / ADAT-Synch timecode) I did anticipate that the functions
> 
> the code to read the ADAT sync timecode is written, but is not
> "exported" to a usable part of the ALSA API. it will likely show up as
> a readable PCM "control".
> 
> >snd_pcm_hwsynch(...)
> 
> never heard of that function. you learn something new every day :)
> 
> >snd_pcm_delay(...)
> >
> >must be used to get the current sample positions of the DAC/ADC. But
> >these functions do not seem to work on my system (alsa-0.9.0rc5 and
an
> >RME9652 sound card). Besides that I want to read the ADAT-Synch
timecode
> >instead of the buffer relative sample offset.
> 
> they are two completely different things. one is not a substitute for
> the other.
> 
> >Therefore I was looking for another solution to get the time. I tried
to
> >use the ALSA timer interface
>
>(http://www.alsa-project.org/alsa-doc/alsa-lib/_2test_2timer_8c-example
.
> >html#example_test_timer). But unfortunately I am getting a "timer
time
> >out!", which means that
> >
> >snd_timer_poll_descriptors(...)
> >
> >did fail. Is the timer interface implemented for the By the RME9652?
By
> >the way I do not understand how the sample number to the read time do
> >correlate with each other.
> 
> the "timer" interface is part of the core of the ALSA drivers, its not
> specific to any particular driver. i have no idea how to use it
> however, and its not documented anywhere except for a few messages in
> the archives of this list and/or alsa-user.
> 
> but first you need to define what it is that you are trying to
> do. bringing the ADAT sync timecode into the picture greatly confuses
> things because this has nothing to do with the other functions you are
> describing. ADAT sync time can move backwards, can speed up, slow down
> etc.
> 
> >I would appreciate any help with this because if I cannot solve this
> >problem, I have to move to Windows ASIO (what a pitty!) ASIO provides
> >the functions
> >
> >ASIOGetSamplePosition(...)
> >bufferSwitchTimeInfo(...)
> >
> >which do exactly what I need.
> 
> and what is it that you need? what are you trying to do?



> 
> --p
> 
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by: To learn the basics of securing
> your web site with SSL, click here to get a FREE TRIAL of a Thawte
> Server Certificate: http://www.gothawte.com/rd524.html
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel



-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
