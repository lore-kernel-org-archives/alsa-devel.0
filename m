From: Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: [Alsa-devel] Bizarre audio behavior
Date: Wed, 14 Jul 2004 14:20:52 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040714142052.4b421488@mango.fruits.de>
References: <1089773762.2729.24.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-S267219AbUGNMNJ@vger.kernel.org>
In-Reply-To: <1089773762.2729.24.camel@mindpipe>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, paul@linuxaudiosystems.com, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 13 Jul 2004 22:56:03 -0400
Lee Revell <rlrevell@joe-job.com> wrote:

> Ok, this is absolutely bizarre.  If I run JACK from a GNOME terminal,
> even with a large period size, all I get are these error messages:
> If I run if from an xterm or a text console, it works perfectly, even 
> with a really small buffer:
> 
> 
> I have no idea where this bug could be, it seems like it would have to be 
> display-related.
> 
> Lee 
> 


Hmm, maybe in one case LD_ASSUME_KERNEL is set?

flo


-- 
Palimm Palimm!
http://affenbande.org/~tapas/wiki
