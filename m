From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: ASoC: fsl_sai: Has anybody attempted to run the
 i.MX6UL in TDM mode with channels > 2?
Date: Thu, 19 Jan 2017 20:21:19 +0100
Message-ID: <20170119192119.4e224b3ggix424ov@piout.net>
References: <CAG5mAdy8BbeKdh+yM8vqNEU1RpzfqD20+SxQj-2iLihXxF7Mww@mail.gmail.com>
 <20170118184326.cokht5tfy24hpf7d@piout.net>
 <CAG5mAdypzORzV89rrTF9jFbdtNpY6NoExuXAAUih9HAdCQDypw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A39F26790F
 for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2017 20:21:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAG5mAdypzORzV89rrTF9jFbdtNpY6NoExuXAAUih9HAdCQDypw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Caleb Crome <caleb@crome.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Arnaud Mouiche <arnaud.mouiche@invoxia.com>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 19/01/2017 at 11:12:35 -0800, Caleb Crome wrote :
> Oh boy,
>    I have never used the SAI.
> 
> The best test that I've ever used for getting this all straight is to
> route the DOUT -> DIN in hardware, set the SSI for symmetric mode, and
> send a known signal out and watch the input.  We call this a 'ramp'
> test because it's basically sending a sequence 1, 2, 3, 4, 5, ...
> (i.e. a ramp) out and verifying that it comes back in in bit-perfect
> order. (originally got the idea from the Audio Anecdotes Books)
> 
> Arnoud codified that test in his program 'atest', that you can get
> here:  https://github.com/amouiche/atest, which works great.
> 

Great, I'll test that.

> Another comment:  don't use a sine wave that's an exact multiple of
> the block size.  i.e. with 1ms blocks, a 441Hz at 44.1kHz sine wave is
> the worst possible test signal :-)   If blocks get swapped around,
> you'll have no idea.  Good thing that you have a time-changing sine
> wave :-)
> 
> If you must use a sine wave test, use a non, multiple:  450 Hz would
> be fine.   Typical in telephony testing is a test tone of 1004 Hz, so
> that 10ms block problems are spotted.
> 

Yeah, I'm using 441 as the sampling rate is 48000 so it shows the issue.

> 
> So, that'll help you with your testing, but as far as how DMA works --
> I'm pretty clueless.  Arnoud and I (actually mostly Arnoud)  tracked
> down several errors with the SSI port implementation.  It wouldn't
> surprise me if there were as many problems with the SAI
> implementation.
> 
> One of the fundamental problems with the freescale SSI/DMA interaction
> is that the SSI port doesn't request one FRAME at a time from the DMA,
> rather it just requests some number of elements.  This causes a real
> implementation headache because if anything ever gets out of sync,
> it's forever and irretreivabley out of sync.  IIRC, the TI chips do
> DMA requests on a frame by frame basis, so if it goes wrong one frame,
> it'll get corrected the next.
> 
> Sorry I can't be of more help, but I really don't know how the SAI/DMA
> stuff works.
> 

Thanks for the answer and the ideas anyway ;)

> -Caleb
> 
> 
> On Wed, Jan 18, 2017 at 10:43 AM, Alexandre Belloni
> <alexandre.belloni@free-electrons.com> wrote:
> > Hi Caleb,
> >
> > Fabio pointed to that thread because I'm trying to use the i.mx7d SAI in
> > TDM mode with 8 channels (but I'm using only 4).
> >
> > On 02/05/2016 at 10:52:39 -0700, Caleb Crome wrote :
> >> Hi all,
> >>    Now that the MX6 fsl_ssi seems to be getting stable for TDM with
> >> channels > 2 (thanks all!), the MX6 UL and MX7 have only the SAI port.
> >>
> >> Does anybody have experience with running the SAI with more than 2 channels?
> >>
> >
> > I have a really small patch to make the SAI driver configure CR4 and CR5
> > properly for more than 2 channels.
> > Data on the TDM bus seems fine.
> >
> > However, I have an issue with the sample ordering. Discussing that with
> > Lars, it seems the SDMA is getting confused when switching periods. To
> > test, I'm playing a 441Hz sine that is fading out. I can definitively
> > see block of 1024 samples (it is period_size) that are ok but not
> > properly ordered. You can have a look at:
> > http://free-electrons.com/~alexandre/playback.png
> >
> > Did you have the same issue?
> >
> > --
> > Alexandre Belloni, Free Electrons
> > Embedded Linux and Kernel engineering
> > http://free-electrons.com

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
