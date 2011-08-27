From: "Olivier Guillion - Myriad" <olivier@myriad-online.com>
Subject: Re: Alsa timing question
Date: Sat, 27 Aug 2011 10:08:32 +0200
Message-ID: <4E58A600.877.18C109@olivier.myriad-online.com>
References: <CAE3TgXE3g9n92Xru_6Znk00rfDdF5OSMXaTiquU=ne5NLrOkOg@mail.gmail.com>,
	<4E575980.12671.44D900@olivier.myriad-online.com>,
	<CAE3TgXFEsyehvsSy6XMY=rnu9BxCw+eEgX-+BH74iSn2Pdjo2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.planet-service.fr (smtp.planet-service.fr [83.167.45.85])
	by alsa0.perex.cz (Postfix) with ESMTP id 5DF2C246B1
	for <alsa-devel@alsa-project.org>;
	Sat, 27 Aug 2011 10:08:16 +0200 (CEST)
In-reply-to: <CAE3TgXFEsyehvsSy6XMY=rnu9BxCw+eEgX-+BH74iSn2Pdjo2w@mail.gmail.com>
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

Raymond Toy <rtoy@google.com> wrote :
> > IMO, it's not a good idea to try to synchronize perfectly two processes by way
> > of an interrupt. If the generating process has to remain untouched, you should
> > probably bufferize its data in your own process before sending it to writei.
> > It would add some latency, but make the data flow safer. Here is how it could
> > work: 1- Your process writes a "magic" pattern at the end of the shared area
> > 2- It sends a signal to the other process to make it generate data 3- It
> > checks whether the magic pattern is still here 4- When changed, it means the
> > data have been calculated. It saves them to an internal circular buffer
> >
> 
> A nice idea, but I'm not sure it will work in my scenario.  The "magic"
> pattern could potentially be real data (the buffer contains audio samples), so
> that would cause funny, hard-to-reproduce glitches. 

You are theorically right, even if I doubt that much genuine audio buffer could 
end with, let's say : 0x8000 0x7FFF followed by "This is magic!!!" string :)

>  Plus, I think that when I
> request new data, something is always written.

I thought it was asynchronous, and you just send a signal to your generating 
process to ask it generate data.

> Clemens idea of a counter at the beginning of the buffer would work nicely, but
> requires changes in the generating process.

Right. But if you can modify  the generating process and recompile it, there is 
no more problem. Can you?

Olivier
