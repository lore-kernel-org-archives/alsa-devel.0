From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH] Clean up ASOC functions to support 32b
	values instead of 16b
Date: Thu, 24 Jul 2008 00:05:59 -0400
Message-ID: <9e4733910807232105x7cca4c95x66906f67e68c7c29@mail.gmail.com>
References: <20080723233635.6900.55269.stgit@terra>
	<ed82fe3e0807231841s2489781fr7515cd0bd0195586@mail.gmail.com>
	<9e4733910807231908s449922adtd24f911d467d51fd@mail.gmail.com>
	<ed82fe3e0807232055t3ab09348x789959c834784ca2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.247])
	by alsa0.perex.cz (Postfix) with ESMTP id AAC29248DB
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Jul 2008 06:06:01 +0200 (CEST)
Received: by hs-out-0708.google.com with SMTP id x43so252438hsb.0
	for <alsa-devel@alsa-project.org>; Wed, 23 Jul 2008 21:06:00 -0700 (PDT)
In-Reply-To: <ed82fe3e0807232055t3ab09348x789959c834784ca2@mail.gmail.com>
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
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On 7/23/08, Timur Tabi <timur@freescale.com> wrote:
> On Wed, Jul 23, 2008 at 9:08 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
>
>  >> Please use "unsigned int" instead of "uint".
>  >
>  > Why? uint is a standard Linux kernel definition. I almost made them all u32.
>
>
> For consistency.  The rest of the source file doesn't use the
>  abbreviated types.  Also, sized integer types like u32 should only be
>  used when the variable must have a certain number of bits, so you
>  shouldn't use u32 as a general purpose integer type.

I think I may need to redo this with u32. I'm still working on my
read/write reg routines and it is not obvious that it would adjust
right on a 64b machine. Just because you switch to a 64b machine, my
sound hardware is still 32b.

>
>
>  --
>
> Timur Tabi
>  Linux kernel developer at Freescale
>


-- 
Jon Smirl
jonsmirl@gmail.com
