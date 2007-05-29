From: "Ashlesha Shintre" <ashlesha.shintre@gmail.com>
Subject: Re: hardware not asking for more data using asyn call
	back
Date: Tue, 29 May 2007 17:46:53 -0400
Message-ID: <975f530d0705291446m4fef44dcu8baacf006915709f@mail.gmail.com>
References: <975f530d0705291219h3a8601c3hba494ba2e1ac1a7b@mail.gmail.com>
	<20070529132032.2841b8c0@ip72-208-99-199.ph.ph.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.231])
	by alsa0.perex.cz (Postfix) with ESMTP id C398124335
	for <alsa-devel@alsa-project.org>;
	Tue, 29 May 2007 23:46:54 +0200 (CEST)
Received: by wx-out-0506.google.com with SMTP id r21so1700483wxc
	for <alsa-devel@alsa-project.org>; Tue, 29 May 2007 14:46:53 -0700 (PDT)
In-Reply-To: <20070529132032.2841b8c0@ip72-208-99-199.ph.ph.cox.net>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: stan <stanl@cox.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> Not really necessary to use an intermediate buffer, but won't hurt.
> I'm not sure why you are using a circular buffer, though it shouldn't
> hurt either.


I wrote another code sometime back, to asychcronously playback data from a
wav file, where I copied the contents of the wav file to a master buffer
(like in this code) and then pumped data to the callback till the end of the
buffer was reached.  This code works fine -- I m trying to get the circular
buffer to work now as part of an application I am writing that will allow
realtime communication over the network between two hosts.

A circular buffer thus seems like a good idea, as in the case of real time
communication I wont really know how much data is going to come through the
network.

> so now instead of copying from the wave file, i m copying data from
> > the master buffer to the circular buffer.. however, as per your
> > suggestion, if i copy the data in the while loop in main, then, it
> > might not always be copied between 2 consecutive callbacks, but maybe
> > more, as the callbacks are asynchronous.
>
> Well, your computer is creating the data that the callback function is
> going to send to alsa.  If the callback function can fill the buffer
> and send it to alsa and keep up with the play rate, then if you fill
> the buffer in your main routine it will work even better.  Your program
> is sleeping instead of doing anything.  You can put in place some kind
> of interprocess communication so that they don't tread on each other in
> the buffer.  With any modern processor that isn't heavily loaded, I
> don't think this will matter anyway.


One question I had about this  interprocess communication was whether we can
pass more data to the callback function apart from the pcm handler.  From
what I can see in the ALSA libraries, the snd_async_add_pcm_handler function
only allows you to pass one parameter in the form of void * private_data.

> however, the hardware still does not ask for more data after
> > executing the callback function about twice -- is there a way to
> > flush the hardware buffer before beginning playback? I have pasted my
> > code below
>
>
> The program output would still be helpful.  I implemented this a few
> years ago.  I'll go look at the code and see how it differs from
> yours.  I seem to recall that there was a sample of exactly this on the
> alsa website, www.alsa-project.org.  You could look at that and it
> might trigger an Aha! moment.


I think you re talking about the pcm.c which implements asynchronous
playback which in my case works -- but it doesnt implement a circular
buffer.
Another query that I have regarding this is that I get a "Bad File
Descriptor" error from the snd_pcm_start function, but my asynchronous
playback code works despite  this error -- I dont think thats the reason for
this code failing, but its a mystry all the same!


Here is the output of my program:

i=49
> > error in starting snd pcm start err :File descriptor in bad state
> > infinite loop
> > inside callback, available frames = 364
> > going out of callback, ind = 1
> > infinite loop
> > inside callback, available frames = 577
> > going out of callback, ind = 2
> > infinite loop
> > inside callback, available frames = 790
> > underrun recovery
> > error from snd_pcm_prepare is: 0
> > going out of callback, ind = 3
> > infinite loop
> > infinite loop
> > infinite loop
> >
> > Regards,
Ashlesha.

>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
