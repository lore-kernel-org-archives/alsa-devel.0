From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Re: basic questions
Date: Sat, 15 Mar 2008 11:57:38 +1300
Message-ID: <200803151157.38835.linux@audioscience.com>
References: <827ad74d0803132135i6c7c8ad8sa7ad5469cc677920@mail.gmail.com>
	<75b66ecd0803141535g66aae270v5c53fb67e973566f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.clear.net.nz (smtp3.clear.net.nz [203.97.33.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 6B9B61037F0
	for <alsa-devel@alsa-project.org>; Fri, 14 Mar 2008 23:52:31 +0100 (CET)
Received: from zaphod (121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp3.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0JXQ00HH6SVF7G40@smtp3.clear.net.nz> for
	alsa-devel@alsa-project.org; Sat, 15 Mar 2008 11:52:29 +1300 (NZDT)
In-reply-to: <75b66ecd0803141535g66aae270v5c53fb67e973566f@mail.gmail.com>
Content-disposition: inline
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

On Saturday 15 March 2008 11:35:20 Lee Revell wrote:
> On Fri, Mar 14, 2008 at 12:35 AM, Harsha priya gupta
>
> <harshapriya@gmail.com> wrote:
> > Hi,
> >
> >  I am ramping up on ALSA architecture and framework. I have a couple of
> > basic questions. I apologize if these questions are very basic to be
> > raised in this mailing list. If anyone can help me find answers, it would
> > be great. Thanks in advance.
> >
> >  1. My assumption is that ALSA handles only PCM streams today. Does it
> > handle encoded streams from application to sound card (Which can do
> > hardware decoding)?
>
> Someone else could probably give a better answer, but I believe that
> currently ALSA has no API for cards that do HW decoding.

Not AFAIK, and certainly the architecture assumes a constant data rate. I.e X 
bytes consumed implies elapsed time of (X * constant)  = the _period_

Alsa headers do define some format constants for compressed audio.

We would like to support compressed audio for our cards, which can do hardware 
decoding. I did try to implement it early on, but got lost in the quagmire of 
driver midlevel code and alsa-lib.

A first step would be to allow CBR compressed formats to pass through to the 
driver unaltered. For these there is a defined bits per sample, though it can 
be non-integer which might be a problem.

regards

--
Eliot Blennerhassett
www.audioscience.com
