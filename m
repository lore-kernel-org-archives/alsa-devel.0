From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: read time information
Date: Fri, 15 Nov 2002 10:03:19 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18Chwc-0003K5-00@sc8-sf-list1.sourceforge.net>
References: <001201c28c91$cc64f470$461d8481@profi>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Fri, 15 Nov 2002 11:28:53 +0100."
             <001201c28c91$cc64f470$461d8481@profi>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: men@ife.ee.ethz.ch
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>For synchronization purpose I need the current time of my sound card
>(information on the sample that is currently played out might be
>sufficient / ADAT-Synch timecode) I did anticipate that the functions 

the code to read the ADAT sync timecode is written, but is not
"exported" to a usable part of the ALSA API. it will likely show up as
a readable PCM "control".

>snd_pcm_hwsynch(...)

never heard of that function. you learn something new every day :)

>snd_pcm_delay(...)
>
>must be used to get the current sample positions of the DAC/ADC. But
>these functions do not seem to work on my system (alsa-0.9.0rc5 and an
>RME9652 sound card). Besides that I want to read the ADAT-Synch timecode
>instead of the buffer relative sample offset.

they are two completely different things. one is not a substitute for
the other.

>Therefore I was looking for another solution to get the time. I tried to
>use the ALSA timer interface
>(http://www.alsa-project.org/alsa-doc/alsa-lib/_2test_2timer_8c-example.
>html#example_test_timer). But unfortunately I am getting a "timer time
>out!", which means that 
>
>snd_timer_poll_descriptors(...)
>
>did fail. Is the timer interface implemented for the By the RME9652? By
>the way I do not understand how the sample number to the read time do
>correlate with each other.

the "timer" interface is part of the core of the ALSA drivers, its not
specific to any particular driver. i have no idea how to use it
however, and its not documented anywhere except for a few messages in
the archives of this list and/or alsa-user.

but first you need to define what it is that you are trying to
do. bringing the ADAT sync timecode into the picture greatly confuses
things because this has nothing to do with the other functions you are
describing. ADAT sync time can move backwards, can speed up, slow down
etc. 

>I would appreciate any help with this because if I cannot solve this
>problem, I have to move to Windows ASIO (what a pitty!) ASIO provides
>the functions
>
>ASIOGetSamplePosition(...)
>bufferSwitchTimeInfo(...) 
>
>which do exactly what I need.

and what is it that you need? what are you trying to do?

--p



-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
