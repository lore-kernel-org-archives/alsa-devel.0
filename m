From: Ciaccia <ciacciax@yahoo.com>
Subject: Re: Any standard ALSA application for simultaneous
	capture and playabck ?????
Date: Tue, 22 May 2007 02:41:46 -0700 (PDT)
Message-ID: <722156.82921.qm@web31010.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web31010.mail.mud.yahoo.com (web31010.mail.mud.yahoo.com
	[68.142.200.173]) by alsa0.perex.cz (Postfix) with SMTP id 3231C244F4
	for <alsa-devel@alsa-project.org>;
	Tue, 22 May 2007 11:41:50 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Nobin Mathew <nobin.mathew@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

It looks like your application uses the following pattern:

for (;;) {
    ReadFromAlsa
    WriteToAlsa
}

The ReadFormAlsa function waits for the capture channel to become available (i.e., there is some data to be read), while WriteToAlsa waits till the output buffer becomes available (i.e., it's possible to send data to the card without blocking).

Ho do you know that this is the correct order? Could it be that you should before write data to the output buffer and then read data from the capture stream? I think your design is not completely correct...

Look at my code, it works fine, but maybe there is a better approach...


Andrea



----- Original Message ----
From: Nobin Mathew <nobin.mathew@gmail.com>
To: Ciaccia <ciacciax@yahoo.com>
Cc: alsa-devel@alsa-project.org
Sent: Tuesday, May 22, 2007 10:53:54 AM
Subject: Re: [alsa-devel] Any standard ALSA application for simultaneous capture and playabck ?????

I have a single threaded ALSA application which does simultaneous
capture and playback. But i am getting overflow error XRUN from
capture side.

 I am attaching the code to this mail.

Is there any problem with single threaded approach?

Is there any global configuration for ALSA lib?

When i run this app, ALSA state is getting corrupted, even aplay and
arecord is not working properly after that.

Any comments on this issue?

Thanks in advance
Nobin Mathew

On 5/22/07, Ciaccia <ciacciax@yahoo.com> wrote:
> > What are the complications in implementing simultaneous playback and
> > capture in ALSA???
>
>
> I would like to add something to this post: what is the "best" way to
> program a full duplex application? I would like to have an application
> that does full-duplex, with the lowest possible latency and using less
> CPU resource as possible. I tried different approaches, but I was not
> completely satisfied with none of them....
>
>
> Here is what I tried:
> -having two threads, one for playback and one for capture
> -defining 2 callbacks with async_handles and do all the processing in the callback functions
> (the last attempt)
> -using poll() to wait for one of the streams to be ready (see attached file fullduplex.c)
>
> Could some of you look at the attached code (it is not generic and contains lots of asserts, but it's supposed to work only on one single machine) and tell me if the last approach using poll is well structured?
>
> The main loop looks as following:
>
> >    while (1) {
> >        err = poll(ufds, 2, -1);
> >
> >        for (i = 0; i < 2; i++)
> >        {
> >            if (snd_pcm_poll_descriptors_revents(handles[i], &ufds[i], 1, &revents) < 0)
> >            {
> >                printf("Error getting revents for %s\n", descriptors[i].name);
> >                exit(1);
> >            }
> >
> >            if (revents & descriptors[i].poll_flag)
> >            {
> >                if (transfer_loop(handles[i], &first[i], descriptors[i].func) < 0)
> >                {
> >                    printf("transfer_loop error for %s\n", descriptors[i].name);
> >                    // TODO exit?!?
> >                }
> >            }
> >        }
> >    }
>
> and the transfer_loop is a modified version of the loop found in the ALSA examples (pcm.c and latency.c).
> Is this strategy optimal in respect to low latency and low CPU usage?
>
> Every comment is greatly appreciated
> Andrea
>
>
>
>
>
> ____________________________________________________________________________________Luggage? GPS? Comic books?
> Check out fitting gifts for grads at Yahoo! Search
> http://search.yahoo.com/search?fr=oni_on_mail&p=graduation+gifts&cs=bz
>






 
____________________________________________________________________________________
Need Mail bonding?
Go to the Yahoo! Mail Q&A for great tips from Yahoo! Answers users.
http://answers.yahoo.com/dir/?link=list&sid=396546091
