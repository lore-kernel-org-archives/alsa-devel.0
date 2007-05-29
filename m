From: stan <stanl@cox.net>
Subject: Re: hardware not asking for more data using asyn call
 back
Date: Tue, 29 May 2007 13:20:32 -0700
Message-ID: <20070529132032.2841b8c0@ip72-208-99-199.ph.ph.cox.net>
References: <975f530d0705291219h3a8601c3hba494ba2e1ac1a7b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fed1rmmtao107.cox.net (fed1rmmtao107.cox.net [68.230.241.39])
	by alsa0.perex.cz (Postfix) with ESMTP id 66D2A243EE
	for <alsa-devel@alsa-project.org>;
	Tue, 29 May 2007 22:20:34 +0200 (CEST)
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao107.cox.net
	(InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP id
	<20070529202032.UXGP12190.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>
	for <alsa-devel@alsa-project.org>; Tue, 29 May 2007 16:20:32 -0400
In-Reply-To: <975f530d0705291219h3a8601c3hba494ba2e1ac1a7b@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 29 May 2007 15:19:12 -0400
"Ashlesha Shintre" <ashlesha.shintre@gmail.com> wrote:

> Hi,
> 
> Thanks Stan, for your response - Instead of copying pcm data from a
> wav file, i decided to copy all the data to a master buffer first and
> then see if the circular buffer implementation works -
> 
Not really necessary to use an intermediate buffer, but won't hurt.
I'm not sure why you are using a circular buffer, though it shouldn't
hurt either.

> so now instead of copying from the wave file, i m copying data from
> the master buffer to the circular buffer.. however, as per your
> suggestion, if i copy the data in the while loop in main, then, it
> might not always be copied between 2 consecutive callbacks, but maybe
> more, as the callbacks are asynchronous.

Well, your computer is creating the data that the callback function is
going to send to alsa.  If the callback function can fill the buffer
and send it to alsa and keep up with the play rate, then if you fill
the buffer in your main routine it will work even better.  Your program
is sleeping instead of doing anything.  You can put in place some kind
of interprocess communication so that they don't tread on each other in
the buffer.  With any modern processor that isn't heavily loaded, I
don't think this will matter anyway.

> 
> however, the hardware still does not ask for more data after
> executing the callback function about twice -- is there a way to
> flush the hardware buffer before beginning playback? I have pasted my
> code below
> 

The program output would still be helpful.  I implemented this a few
years ago.  I'll go look at the code and see how it differs from
yours.  I seem to recall that there was a sample of exactly this on the
alsa website, www.alsa-project.org.  You could look at that and it
might trigger an Aha! moment.

> Regards,
> Ashlesha.
