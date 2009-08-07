From: John Bonesio <bones@secretlab.ca>
Subject: Re: MPC5200/WM9712 mute problem
Date: Fri, 07 Aug 2009 07:48:42 -0700
Message-ID: <1249656522.5844.89.camel@riker>
References: <20090731230311.17686.46431.stgit@riker>
	<9e4733910908010647k3a4a22c5jf9b9eda482f016b1@mail.gmail.com>
	<1249139096.4582.13.camel@riker> <20090802114950.GA1778@sirena.org.uk>
	<1249489853.4582.58.camel@riker> <20090805170305.GC16844@sirena.org.uk>
	<1249579721.5844.88.camel@riker>
	<20090807095601.GA8175@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f175.google.com (mail-pz0-f175.google.com
	[209.85.222.175])
	by alsa0.perex.cz (Postfix) with ESMTP id A66611038B1
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Aug 2009 16:48:47 +0200 (CEST)
Received: by pzk5 with SMTP id 5so1644604pzk.23
	for <alsa-devel@alsa-project.org>; Fri, 07 Aug 2009 07:48:46 -0700 (PDT)
In-Reply-To: <20090807095601.GA8175@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, alsa-devel@alsa-project.org, Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2009-08-07 at 10:56 +0100, Mark Brown wrote:
> On Thu, Aug 06, 2009 at 10:28:41AM -0700, John Bonesio wrote:
> 
> > I'm open to more suggestions or thoughts on the approach I've taken so
> > far.
> 
> The approach you've been taking sounds reasonable; at this point I'd be
> looking at trying to confirm that the controller is doing what's been
> asked of it.  Checking that the CODEC power rails are all within spec
> and looking at other bits in the same register may also be useful.
> 
> Is the system otherwise idle when the problem occurs?

Yes the system is idle - just me fiddling with the mute settings.
