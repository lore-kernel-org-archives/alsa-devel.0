From: Ed Wildgoose <lists@wildgooses.com>
Subject: Re: RME9632 Precise Pointer option problem (attn Thomas
 Charbonnel)
Date: Mon, 27 Sep 2004 19:45:23 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <41585FC3.9030300@wildgooses.com>
References: <200409271112.i8RBC6Qc017508@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200409271112.i8RBC6Qc017508@localhost.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


>its not. you have to keep in mind that RME designed this hardware
>around the ASIO model, in which the h/w ptr position is  essentially
>irrelevant. consequently, the way in which the ptr is updated is not
>particularly reliable.
>  
>

Agreed.  Seems to be that way.  Just wondering if someone has some specs 
for the card and perhaps it can be made better...?


>>quite accurate estimating the current point location based on counting 
>>ticks since we started and noting when we add new data, etc.
>>    
>>
>
>you should probably first explain why you want to do this. as i
>mentioned, the h/w design is really centered on straightforward double
>buffering - the application works on one "buffer" and the hardware
>works on the other. 
>
>when you add data to the buffer makes no difference to the location of
>the hw ptr, btw.
>  
>

Many video players clock themselves to the video stream to decide 
exactly when to display the next video frame.  This is not so silly 
because we can be fairly sure the audio clock and system clock will 
diverge through time, so clocking video to audio is the best way to keep 
the in sync (without exotic altenatives).

Unfortunately you should be able to clearly see that if the audio clock 
can only be observed to the nearest full buffer then we are going to get 
some pretty visible jitter even with 1024 sample buffers (which is 
exactly what I see on screen).  Working around this is non-trivial 
really, yeah sure you can use your own clock, but it's still non-trivial 
to recover the audio clock bearing in mind that you only get infrequent 
glipses of it, and even then only the clock is quantised to the size of 
the audio buffer (ie large). 

My idea was that either in every application (tedious), or perhaps at 
the driver level: everytime we are woken up to check the card then we 
can have a look at how full the buffers are (eg when we add data is a 
good time).  At the point that we notice the buffers move from two full 
to one full we can assume that our accurate pointer must have crossed 
the magic boundary and we can determine a bound on the audio clock.  In 
the meantime we take our clock estimate and offset it based on the 
system clock ticks.

Over time (eg several mins) we can probably also obtain a reasonable 
estimate of the audio clock offset compared with the sys clock - this 
might be useful to refine the estimation even further.

Would a patch to do something like this in the driver be accepted (ie 
make the accurate pointer option do this estimation process instead)?  
Adding to each application has potential, but is obviously a pain to do 
it for Xine, mplayer, Ogle, etc, etc)

Does this make sense?

Ed W



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
