From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: Master Plan on rewinding
Date: Mon, 15 Sep 2014 12:01:26 -0500
Message-ID: <54171B66.3010705@linux.intel.com>
References: <540C76E0.9050808@gmail.com> <54148E72.2050903@gmail.com>
 <CAN8cciYj4fo01XZwJ-NhFQDNv6Ua5mqaAEq1zU7PYxHkJyOQ5A@mail.gmail.com>
 <541584FB.2030208@gmail.com> <s5hiokpw89h.wl-tiwai@suse.de>
 <5416B852.6080406@gmail.com> <s5hd2axw60j.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 76928265576
 for <alsa-devel@alsa-project.org>; Mon, 15 Sep 2014 19:02:05 +0200 (CEST)
In-Reply-To: <s5hd2axw60j.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, "Alexander E. Patrakov" <patrakov@gmail.com>
Cc: Raymond Yau <superquad.vortex2@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>, David Henningsson <david.henningsson@canonical.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org


>> What remains not fully understood for me is the claim that the
>> information already exposed by every driver (in the form of the minimal
>> period size) is not useful. I understand that two people are against
>> this idea, so it must be bad. But I must understand why. Is it because
>> the minimum period size reported by some drivers (which ones are
>> suspected, if any?) may be a lie?
>
> A kind of yes.  Many drivers, especially the old ones, set the minimal
> period size without actually knowing the real limit.  It tends to be
> smaller than the hardware really supports.  This is, in most cases,
> just because no hardware spec defines that.  So, it can't be blindly
> taken as the bottom line, unfortunately.  That's why I suggested the
> new field would be optional; we simply don't know the value.

Agree with Takashi, even recent audio IP tend to be reused in various 
ways (buses, system agents, arbiters, DMA controllers, DDR controllers) 
and no one really knows what the rewind granularity is, it's not a 
metric that's tracked.

I actually liked the heuristic that's present in PulseAudio: constrain 
the safeguard to 256 bytes or 1ms (the last part would actually be 
fixed, it's currently not dependent on the sink actual rate and number 
of channels). we could introduce an optional query drivers for this but 
I wonder if it's worth the effort.
-Pierre
