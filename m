From: stan <stanl@cox.net>
Subject: Re: Hidden rate conversion, and Alsa configuration
Date: Fri, 27 Jul 2007 11:29:39 -0700
Message-ID: <20070727112939.0829a541@localhost.localdomain>
References: <200707161340.23503.gineera@aspect135.co.uk>
	<20070719142440.GA2467@localhost>
	<200707201333.38449.gineera@aspect135.co.uk>
	<200707271720.41278.gineera@aspect135.co.uk>
	<75b66ecd0707270859q33f02d05la5160f3443dc9cc1@mail.gmail.com>
	<20070727105316.694a73cd@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fed1rmmtao106.cox.net (fed1rmmtao106.cox.net [68.230.241.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 4BD4E103813
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Jul 2007 20:29:41 +0200 (CEST)
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao106.cox.net
	(InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
	id <20070727182940.IMQF1393.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>
	for <alsa-devel@alsa-project.org>; Fri, 27 Jul 2007 14:29:40 -0400
In-Reply-To: <20070727105316.694a73cd@localhost.localdomain>
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

On Fri, 27 Jul 2007 10:53:16 -0700
stan <stanl@cox.net> wrote:

> On Fri, 27 Jul 2007 11:59:53 -0400
> "Lee Revell" <rlrevell@joe-job.com> wrote:
> 
> > On 7/27/07, Alan Horstmann <gineera@aspect135.co.uk> wrote:
> > > Could you give pointers as to how to modify Alsa configuration so
> > > that rate conversion can never happen, as I would prefer to have
> > > an error accessing the sound card rather than unknown conversion,
> > > which in my use should never be neccesary anyway.
> > 
> > Simply open the hw device rather than the default, dmix, or plughw
> > device.
> > 
> > Lee
> 
> When I use the following call with device_to_use == "plughw:0,0"
> it works just fine.  When I try to use device_to_use == "hw:0,0"
> it gives a segmentation fault.  Is there a special initialization
> needed to use the hw plug?
> 
> err = snd_pcm_open (&alsa_dev, device_to_use,
> SND_PCM_STREAM_PLAYBACK, 0);
> 
I see from this alsa-project doc page 
http://alsa-project.org/alsa-doc/alsa-lib/pcm__hw_8c.html#d0275f35954d3681fd8d016d5cf26749
that there are special functions
for this : snd_pcm_hw_open or _snd_pcm_hw_open.
