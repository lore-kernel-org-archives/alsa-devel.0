From: "Nobin Mathew" <nobin.mathew@gmail.com>
Subject: Re: Any standard ALSA application for simultaneous
	capture and playabck ?????
Date: Thu, 24 May 2007 10:27:58 +0530
Message-ID: <8d6898730705232157n63740b16kf08bbc284c8c4319@mail.gmail.com>
References: <8d6898730705212330t6d328664sb28478964b0df409@mail.gmail.com>
	<4654CD51.1040207@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.238])
	by alsa0.perex.cz (Postfix) with ESMTP id 068DD2435A
	for <alsa-devel@alsa-project.org>;
	Thu, 24 May 2007 06:57:59 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id i11so541503nzi
	for <alsa-devel@alsa-project.org>; Wed, 23 May 2007 21:57:58 -0700 (PDT)
In-Reply-To: <4654CD51.1040207@superbug.co.uk>
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
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

 I am using single thread for both capture and playback




On 5/24/07, James Courtier-Dutton <James@superbug.co.uk> wrote:
> Nobin Mathew wrote:
> > Hi,
> >
> > Is there any standard ALSA appplication which does simultaneous
> > capture and playback??
> >
> > What are the complications in implementing simultaneous playback and
> > capture in ALSA???
> >
> > What are the plugin (.asoundrc) configurations needed for simultaneous
> > playback and capture????
> >
> > Thanks
> > Nobin Mathew
>
> You might want to look at jackd. It down full duplex low latency.
> It really depends on your application as to how you program alsa to do
> the job. Will your application want one thread for both capture and
> playback, or one thread for capture, and one for playback?
>
> James
>
>
