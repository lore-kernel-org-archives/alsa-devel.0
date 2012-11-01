From: maillist@superlative.org
Subject: Re: [alsa-devel] Idea: dynamic loading of USB quirks
Date: Thu, 01 Nov 2012 21:20:46 +0000
Message-ID: <1410076.LzJ0gmvzpA@kamdesktop>
References: <2390628.MpxcLPPhM0@kamdesktop> <50923B65.4060304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <50923B65.4060304@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thursday 01 Nov 2012 10:05:41 Daniel Mack wrote:
> [cc lkml as this might be of broader interest]
> 

> 
> Then again, if a versatile and clean solution to this problem is found,
> there would be tons of other drivers in Linux to benefit from it, just
> think about the hda driver to begin with. But not only in the ALSA area.
>

I was initially thinking of the more trivial USB quirkes only, and having the 
more complex quirks remain as hard coded.

But it does make sense that, if such a capability could be extended, that it 
could be used for other drivers too.

Cheers,

Keith
