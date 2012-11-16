From: Eldad Zack <eldad@fogrefinery.com>
Subject: Re: USB hardware that supports implicit feedback?
Date: Fri, 16 Nov 2012 03:08:12 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1211160223050.1157@xoschi>
References: <p06240805cccafc72f23b@[192.168.1.36]>
 <alpine.LNX.2.00.1211152158440.2632@xoschi>
 <p06240809cccb09820207@[192.168.1.8]> <50A57933.9070607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
 [209.85.212.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 749EE265CF5
 for <alsa-devel@alsa-project.org>; Fri, 16 Nov 2012 03:08:18 +0100 (CET)
Received: by mail-wi0-f179.google.com with SMTP id hj6so1228334wib.2
 for <alsa-devel@alsa-project.org>; Thu, 15 Nov 2012 18:08:18 -0800 (PST)
In-Reply-To: <50A57933.9070607@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: Daniel Griscom <griscom@suitable.com>, Alsa Developer <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


Hi Daniel,

On Fri, 16 Nov 2012, Daniel Mack wrote:
> On 16.11.2012 05:32, Daniel Griscom wrote:
> > At 10:02 PM +0100 11/15/12, Eldad Zack wrote:
> >> I'm not an ALSA dev, but I recently posted a series of patches for the
> >> M-Audio Fast Track C400, which uses the implicit feedback code that was
> >> already in the tree for other devices.
> Yes, sorry for not responding. I've seen this, but didn't have time yet
> to respond. Thanks for doing this.

Thank you for doing the heavy lifting there! After I noticed the 
clock drift (and read about the implicit feedback mechanism) with the 
first version I posted, I was able to get my hardware to work properly
thanks to your work.

BTW, I took some measurements with a slightly modified jack_delay
(to collect per-period statistics and more decimal precision output) and 
I see +/- 1 usec variation in real-world latency, so I'm very happy with 
it so far.

> Note that I never tested the automatic discovery of that mode. The
> device I wrote the code for doesn't announce it that way, and so a quirk
> was needed in pcm.c to make it happen. Ideally though, what you did is
> the right thing to do, just just need to make sure the driver really
> obeys that setting :)

I think that Autodiscovery should fail with this amtel device because 
the number of endpoints is 1 for the playback ep (this is what I encountered 
with the C400).
Maybe a info message could be added in case the attributes do say 
implicit feedback, but bNumEndpoints < 2?

Cheers,
Eldad
