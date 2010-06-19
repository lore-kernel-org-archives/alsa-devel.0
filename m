From: Daniel Mack <daniel@caiaq.de>
Subject: Re: Status of the Tascam US-122mkII???
Date: Sun, 20 Jun 2010 01:05:27 +0200
Message-ID: <20100619230527.GJ25445@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id A172E24374
	for <alsa-devel@alsa-project.org>;
	Sun, 20 Jun 2010 01:05:31 +0200 (CEST)
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
To: jordan johnston <triplesquarednine@gmail.com>
Cc: alsa-devel@alsa-project.org, Tobias Hansen <Tobias.Hansen@physik.uni-hamburg.de>
List-Id: alsa-devel@alsa-project.org

*** Reply to ALL please! ***

On Sat, Jun 19, 2010 at 06:51:58PM -0400, jordan johnston wrote:
> On Sat, Jun 19, 2010 at 6:41 PM, Daniel Mack <daniel@caiaq.de> wrote:
> > Well, you can assume that audio is transported over dedicated
> > isochronous endpoints. The question is how audio parameters are set up.
> > And you can find out by tracing the traffic and see what happens when
> > you start or stop the stream, when you change the sample rate etc.
> >
> 
> now, here you are referring, to tracing in OSX, or Windows right? (like before.)

Yes.

> i may try that out, but as i am not versed in this stuff it may be
> quite difficult
> without better understanding.
> 
> do you know of any really insightful information on the
> subject(somewhere on the net).
> im going to google around a bit too.

Hmm, I can point you to the USB specs which gives you detailed
explanation about the low-level communication on the bus:

  http://www.usb.org/developers/docs/usb_20_052510.zip

And you can read other Linux drivers and see what they do.

We have no clue what Tascam's engineers did when they designed the
MK2 version, and how close they kept to the protocol specs of their
earlier products. Maybe they just shifted some bytes around, maybe they
completely started over. All left for you to find out :)

> Ya, it was a gamble i had called the store earlier in the week, they
> actually had the device i wanted.
> however, i didn't end up going that day. so when i did come, it had
> been sold. i then decided to take
> a gamble on it.
> 
> no big deal. - 30 day return policy, and they said it was fine that i
> returned it, if i couldn't get it
> supported under linux.

It might take you more than 30 days to fully support it under Linux if
you're going to do it yourself though ;)


Daniel
