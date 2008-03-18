From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: basic questions
Date: Mon, 17 Mar 2008 22:01:34 -0400
Message-ID: <75b66ecd0803171901k17ed767dj30f6e4f79e25857e@mail.gmail.com>
References: <827ad74d0803132135i6c7c8ad8sa7ad5469cc677920@mail.gmail.com>
	<75b66ecd0803141535g66aae270v5c53fb67e973566f@mail.gmail.com>
	<200803151157.38835.linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.189])
	by alsa0.perex.cz (Postfix) with ESMTP id D92D5243A4
	for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2008 03:01:35 +0100 (CET)
Received: by rv-out-0910.google.com with SMTP id k20so4476483rvb.32
	for <alsa-devel@alsa-project.org>; Mon, 17 Mar 2008 19:01:34 -0700 (PDT)
In-Reply-To: <200803151157.38835.linux@audioscience.com>
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
To: Eliot Blennerhassett <linux@audioscience.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 14, 2008 at 6:57 PM, Eliot Blennerhassett
<linux@audioscience.com> wrote:
> On Saturday 15 March 2008 11:35:20 Lee Revell wrote:
>  > On Fri, Mar 14, 2008 at 12:35 AM, Harsha priya gupta
>  >
>  > <harshapriya@gmail.com> wrote:
>  > > Hi,
>  > >
>  > >  I am ramping up on ALSA architecture and framework. I have a couple of
>  > > basic questions. I apologize if these questions are very basic to be
>  > > raised in this mailing list. If anyone can help me find answers, it would
>  > > be great. Thanks in advance.
>  > >
>  > >  1. My assumption is that ALSA handles only PCM streams today. Does it
>  > > handle encoded streams from application to sound card (Which can do
>  > > hardware decoding)?
>  >
>  > Someone else could probably give a better answer, but I believe that
>  > currently ALSA has no API for cards that do HW decoding.
>
>  Not AFAIK, and certainly the architecture assumes a constant data rate. I.e X
>  bytes consumed implies elapsed time of (X * constant)  = the _period_
>
>  Alsa headers do define some format constants for compressed audio.
>
>  We would like to support compressed audio for our cards, which can do hardware
>  decoding. I did try to implement it early on, but got lost in the quagmire of
>  driver midlevel code and alsa-lib.
>
>  A first step would be to allow CBR compressed formats to pass through to the
>  driver unaltered. For these there is a defined bits per sample, though it can
>  be non-integer which might be a problem.

I would look at how ALSA implements AC3 passthrough.

Lee
