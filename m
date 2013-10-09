From: "Nathanael D. Noblet" <nathanael@gnat.ca>
Subject: Re: Internal Mic Boost channel is unused
Date: Wed, 09 Oct 2013 13:46:48 -0600
Message-ID: <5255B2A8.6060507@gnat.ca>
References: <5231E348.8020204@gnat.ca> <52333782.9070402@gnat.ca>
 <5233AEFC.8000907@canonical.com> <5237204A.7040602@gnat.ca>
 <52377EDC.6040105@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from titanium.nobletdesign.com (titanium.nobletdesign.com
 [64.34.172.148])
 by alsa0.perex.cz (Postfix) with ESMTP id C0D9B261605
 for <alsa-devel@alsa-project.org>; Wed,  9 Oct 2013 21:46:50 +0200 (CEST)
In-Reply-To: <52377EDC.6040105@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 09/16/2013 03:57 PM, David Henningsson wrote:
> Matching this with your alsa-info, we can see that 'Mic Jack'
> corresponds to 0x1b and 'Mic Jack', index=1 corresponds to 0x1a.
>
> Hence you could try turning pin 0x1a to "not connected" in
> hda-jack-retask. (I don't know how/if hda-jack-retask is packaged in
> Fedora, but it is part of alsa-tools.)
>
> If this resolves your problem, we could then try making that the default
> in upcoming kernels, but the question is we really dare to do that,
> without clear confirmation that 0x1a is actually useless. In current
> state it's a bit buggy, but if the headphone jack is actually a headset
> jack turning that off would make the headset mic go from "needs manual
> adjustment to work" to "completely unusuable".

So that adjustment allows the internal microphone to be useable. However 
the mic in jack is now completely unusable. With a headset or a plain 
microphone.

Thoughts?

-- 
Nathanael d. Noblet
t 403.875.4613
