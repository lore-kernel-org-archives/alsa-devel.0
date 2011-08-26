From: "Olivier Guillion - Myriad" <olivier@myriad-online.com>
Subject: Re: Alsa timing question
Date: Fri, 26 Aug 2011 10:29:52 +0200
Message-ID: <4E575980.12671.44D900@olivier.myriad-online.com>
References: <CAE3TgXE3g9n92Xru_6Znk00rfDdF5OSMXaTiquU=ne5NLrOkOg@mail.gmail.com>,
	<4E55F6A2.3040307@ladisch.de>,
	<CAE3TgXHocCLC4T69p_n_yyDu6MFvyPF0-DOioZ-kZnXjyZn3Sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.planet-service.fr (smtp.planet-service.fr [83.167.45.85])
	by alsa0.perex.cz (Postfix) with ESMTP id 78990246C2
	for <alsa-devel@alsa-project.org>;
	Fri, 26 Aug 2011 10:29:30 +0200 (CEST)
In-reply-to: <CAE3TgXHocCLC4T69p_n_yyDu6MFvyPF0-DOioZ-kZnXjyZn3Sw@mail.gmail.com>
Content-description: Mail message body
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Toy <rtoy@google.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

Raymond Toy wrote:
> > > I'm working on an application where I'd like to have relatively fixed
> > timing
> > > between calls to snd_pcm_writei.
> >
> > Why?
> >
> 
> It's a bit complicated.  A different process generates the audio and places the
> data in a shared memory area.  My process sends signals the other process to
> generate more data, I read the shared memory area (for the previously generated
> data).  Sometime later, the other process fills the shared area with new
> samples.  Thus, if the timing between calls is not fairly regular, I'll either
> reread the same data or miss the new data.  (I'm not in control of how this
> works.  I just have to deal with what I'm given.)

IMO, it's not a good idea to try to synchronize perfectly two processes by way 
of an interrupt.
If the generating process has to remain untouched, you should probably 
bufferize its data in your own process before sending it to writei. It would 
add some latency, but make the data flow safer.
Here is how it could work:
1- Your process writes a "magic" pattern at the end of the shared area
2- It sends a signal to the other process to make it generate data
3- It checks whether the magic pattern is still here
4- When changed, it means the data have been calculated. It saves them to an 
internal circular buffer
5- If the circular buffer is not full, it restarts at 1-
6-In parallel, when data can be written to the device through writei, they are 
taken from the circular buffer.

Hope this helps,
Olivier
