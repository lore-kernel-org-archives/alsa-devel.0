From: "Maxim Levitsky" <maximlevitsky@gmail.com>
Subject: Re: No sound on Intel DQ965GF motherboard
Date: Fri, 16 Nov 2007 10:50:53 +0200
Message-ID: <6d1efe520711160050l5e1adb26u3d20aa06ca8279d8@mail.gmail.com>
References: <20071116061042.C5E9D830734@snark.thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rn-out-0102.google.com (rn-out-0910.google.com [64.233.170.189])
	by alsa0.perex.cz (Postfix) with ESMTP id 5978E248A1
	for <alsa-devel@alsa-project.org>; Fri, 16 Nov 2007 09:50:54 +0100 (CET)
Received: by rn-out-0102.google.com with SMTP id e23so869342rng
	for <alsa-devel@alsa-project.org>; Fri, 16 Nov 2007 00:50:53 -0800 (PST)
In-Reply-To: <20071116061042.C5E9D830734@snark.thyrsus.com>
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
To: "Eric S. Raymond" <esr@snark.thyrsus.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 11/16/07, Eric S. Raymond <esr@snark.thyrsus.com> wrote:
> Thank you, alsa developers, for the prompt resolution of my previous
> sound issue with the Thinkpad X61.  Unfortunately, I've now turned up
> an apparently different problem on very similar hardware.
>
> Sound doesn't work on my DQ965GF motherboard under Ubuntu 7.10.
> Here's what I've found out about it.  I'm writing in hope that someone
> on the ALSA devel list can suggest diagnostics to pin down the problem
> exactly.
>
> The device has PCI ID [8086:284b] (rev 02).  It is an Intel 82801H.

According to intel site this board has a STAC9227 the same audio codec I have
on my intel DG965RY

Does 2.6.23 work for you?

Accidentally I introduced a error in this driver thus very similar to
yours issue
was present on few systems.
It is fixed in 2.6.24-rc1
So, what kernel fails?

Can you try 2.6.24-rc2

Best regards,
       Maxim Levitsky

PS:
I don't have the DG965RY motherboard temporarely since it decided
to break, thus I am waiting for replacement board, and can't use
my new PC :-(
