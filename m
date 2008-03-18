From: "Harsha priya gupta" <harshapriya@gmail.com>
Subject: Re: basic questions
Date: Tue, 18 Mar 2008 18:20:46 +0530
Message-ID: <827ad74d0803180550g5cf74fc2qf02f8ce81bd48193@mail.gmail.com>
References: <827ad74d0803132135i6c7c8ad8sa7ad5469cc677920@mail.gmail.com>
	<75b66ecd0803141535g66aae270v5c53fb67e973566f@mail.gmail.com>
	<200803151157.38835.linux@audioscience.com>
	<75b66ecd0803171901k17ed767dj30f6e4f79e25857e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.224])
	by alsa0.perex.cz (Postfix) with ESMTP id 367D2243F7
	for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2008 13:50:49 +0100 (CET)
Received: by wr-out-0506.google.com with SMTP id 50so4529145wri.2
	for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2008 05:50:48 -0700 (PDT)
In-Reply-To: <75b66ecd0803171901k17ed767dj30f6e4f79e25857e@mail.gmail.com>
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
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks a lot for the responses.

I see that there can be a way to implement a path for sending encoded
streams to sound card driver through ALSA for hardware decoding but it does
not explicitly exist today.

There are currently a lot of hardware that support decoding. If there is no
existing path in ALSA, what is the recommended way to do so? [ provide
different driver for encoded streams?]

As I am new to ALSA, it would be great if anyone could help me quantify the
effort and difficulty level involved and provide a direction for the same.

Would I be on the right path if;

1. Like PCM object, register a encoded stream object in ALSA framework
2. Provide IOCTLs from sound card driver for MMF to send encoded buffer
3. (is required??) implement API in ALSA driver and Libasound to route the
calls from MMF to sound card IOCTLs

Thanks a lot in advance,
-Harsha

On Tue, Mar 18, 2008 at 7:31 AM, Lee Revell <rlrevell@joe-job.com> wrote:

> On Fri, Mar 14, 2008 at 6:57 PM, Eliot Blennerhassett
> <linux@audioscience.com> wrote:
> > On Saturday 15 March 2008 11:35:20 Lee Revell wrote:
> >  > On Fri, Mar 14, 2008 at 12:35 AM, Harsha priya gupta
> >  >
> >  > <harshapriya@gmail.com> wrote:
> >  > > Hi,
> >  > >
> >  > >  I am ramping up on ALSA architecture and framework. I have a
> couple of
> >  > > basic questions. I apologize if these questions are very basic to
> be
> >  > > raised in this mailing list. If anyone can help me find answers, it
> would
> >  > > be great. Thanks in advance.
> >  > >
> >  > >  1. My assumption is that ALSA handles only PCM streams today. Does
> it
> >  > > handle encoded streams from application to sound card (Which can do
> >  > > hardware decoding)?
> >  >
> >  > Someone else could probably give a better answer, but I believe that
> >  > currently ALSA has no API for cards that do HW decoding.
> >
> >  Not AFAIK, and certainly the architecture assumes a constant data rate.
> I.e X
> >  bytes consumed implies elapsed time of (X * constant)  = the _period_
> >
> >  Alsa headers do define some format constants for compressed audio.
> >
> >  We would like to support compressed audio for our cards, which can do
> hardware
> >  decoding. I did try to implement it early on, but got lost in the
> quagmire of
> >  driver midlevel code and alsa-lib.
> >
> >  A first step would be to allow CBR compressed formats to pass through
> to the
> >  driver unaltered. For these there is a defined bits per sample, though
> it can
> >  be non-integer which might be a problem.
>
> I would look at how ALSA implements AC3 passthrough.
>
> Lee
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>



-- 
-Harsha
