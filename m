From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: Question to integrate a new driver
Date: Tue, 15 May 2007 17:35:31 -0400
Message-ID: <75b66ecd0705151435s199645f0wef5ca64e076137cf@mail.gmail.com>
References: <1179349709.6403.12.camel@piorce>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.236])
	by alsa0.perex.cz (Postfix) with ESMTP id 30BC0248A4
	for <alsa-devel@alsa-project.org>;
	Tue, 15 May 2007 23:35:33 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id l8so298091nzf
	for <alsa-devel@alsa-project.org>; Tue, 15 May 2007 14:35:32 -0700 (PDT)
In-Reply-To: <1179349709.6403.12.camel@piorce>
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
To: Jean-Christian Hassler <jhassler@free.fr>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 5/16/07, Jean-Christian Hassler <jhassler@free.fr> wrote:
> I wrote with a friend an ALSA driver for the emagic AUDIOWERK 2
> soundcard. Now it works for the analog inputs/outputs.
>
> The project page is here : http://home.gna.org/aw2-alsa/index.html
>
> We have 2 questions to continue our work :
> 1- what is the way to submit our code to be integrated in the ALSA
> tree ?

Post to alsa-devel as a patch against ALSA Hg sources.  Include
signed-off-by line and description.  See alsa-devel archives for some
examples.

> 2- We develop on two different version of the kernel (2.6.17-14 &
> 2.6.20) and the request_irq function prototype has changed between these
> two versions(the "struct pt_regs *" does no longer exists), how is this
> managed in ALSA ?

Post a patch against latest alsa sources and the ALSA build process
will automagically patch the code so it can be build against older
kernels.  No need to worry about old kernels in your driver.

Some minor kernel coding style issues to fix before submitting:

Don't use StudlyCaps (pcmDevice->streamNumber should be
pcm_device->stream_number)
Don't use typedefs for structs
Preferred if/else style is:
if (foo) {
    stuff;
} else {
    other_stuff;
}
Use DMA_32BIT_MASK constant rather than 0xffffffff
Don't use C++ style comments (//)

Lee
