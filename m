From: Mark Canter <marcus@vfxcomputing.com>
Subject: Re: [Alsa-devel] Re: intel 8x0 went silent in 2.6.11
Date: Thu, 3 Mar 2005 21:50:22 -0500 (EST)
Message-ID: <Pine.LNX.4.62.0503032146580.21844@krusty.vfxcomputing.com>
References: <4227085C.7060104@drzeus.cx> <29495f1d05030309455a990c5b@mail.gmail.com>
 <Pine.LNX.4.62.0503031342270.19015@krusty.vfxcomputing.com>
 <1109875926.2908.26.camel@mindpipe> <Pine.LNX.4.62.0503031356150.19015@krusty.vfxcomputing.com>
 <1109876978.2908.31.camel@mindpipe> <Pine.LNX.4.62.0503031527550.30702@krusty.vfxcomputing.com>
 <20050303154929.1abd0a62.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
In-Reply-To: <20050303154929.1abd0a62.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: rlrevell@joe-job.com, nish.aravamudan@gmail.com, drzeus-list@drzeus.cx, linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Yes, flipping back to the 2.6.10 kernel resolves the sound issue through 
the docking station so that everything runs without incident.  Though I'd 
like to see/assist in resolving the issue for future releases :).

On Thu, 3 Mar 2005, Andrew Morton wrote:

> Mark Canter <marcus@vfxcomputing.com> wrote:
>>
>>
>> To close this issue out of the LKML and alsa-devel, a bug report has been
>> written.
>>
>> It appears to be an issue with the 'headphone jack sense' (as kde labels
>> it).  The issue is in the way the 8x0 addresses the docking station/port
>> replicator's audio output jack.  The mentioned quick fix does not work for
>> using the ds/pr audio output, but does resolve it for a user that is only
>> using headphones/internal speakers.
>
> But there was a behavioural change: applications which worked in 2.6.10
> don't work in 2.6.11, is that correct?
>
> If so, the best course of action is to change the kernel so those
> applications work again.  Can that be done?
>
