From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: basic questions
Date: Fri, 14 Mar 2008 18:35:20 -0400
Message-ID: <75b66ecd0803141535g66aae270v5c53fb67e973566f@mail.gmail.com>
References: <827ad74d0803132135i6c7c8ad8sa7ad5469cc677920@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.238])
	by alsa0.perex.cz (Postfix) with ESMTP id 7433F24590
	for <alsa-devel@alsa-project.org>; Fri, 14 Mar 2008 23:35:23 +0100 (CET)
Received: by wr-out-0506.google.com with SMTP id 50so3378332wri.2
	for <alsa-devel@alsa-project.org>; Fri, 14 Mar 2008 15:35:21 -0700 (PDT)
In-Reply-To: <827ad74d0803132135i6c7c8ad8sa7ad5469cc677920@mail.gmail.com>
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
To: Harsha priya gupta <harshapriya@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 14, 2008 at 12:35 AM, Harsha priya gupta
<harshapriya@gmail.com> wrote:
> Hi,
>
>  I am ramping up on ALSA architecture and framework. I have a couple of basic
>  questions. I apologize if these questions are very basic to be raised in
>  this mailing list. If anyone can help me find answers, it would be great.
>  Thanks in advance.
>
>  1. My assumption is that ALSA handles only PCM streams today. Does it handle
>  encoded streams from application to sound card (Which can do hardware
>  decoding)?
>

Someone else could probably give a better answer, but I believe that
currently ALSA has no API for cards that do HW decoding.

>  2. What are the hwdep files in ALSA used for? Where do the concerned IOCTLS
>  land to?

Anything you want to do that doesn't fit into the ALSA framework.
Typically they're used for things like programming the card's DSP
engine.  I've also used them for testing/QA in embedded development,
using hwdep ioctls to provide an alternate playback path, so that any
issues can quickly be determined to be an ALSA issue, or a problem
with the way we were programming the HW.

See the emu10k1 driver for a good example of hwdep ioctl usage.  It's
used for things like loading DSP patches.

Lee
