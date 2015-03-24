From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH v2 1/2] ALSA: jack: create jack kcontrols
 for every jack input device
Date: Tue, 24 Mar 2015 07:50:39 +0100
Message-ID: <5511093F.1010708@canonical.com>
References: <1426841719-14576-3-git-send-email-yang.jie@intel.com>
 <s5hd2446mt2.wl-tiwai@suse.de>
 <E7B1D079BA13FB44A978CC8F69C7D6A901BDB90F@SHSMSX101.ccr.corp.intel.com>
 <s5hvbhv6eio.wl-tiwai@suse.de>
 <E7B1D079BA13FB44A978CC8F69C7D6A901BDB93C@SHSMSX101.ccr.corp.intel.com>
 <s5hr3sj6bzj.wl-tiwai@suse.de>
 <E7B1D079BA13FB44A978CC8F69C7D6A901BDB993@SHSMSX101.ccr.corp.intel.com>
 <s5hegoj69bs.wl-tiwai@suse.de>
 <1427108203.2968.57.camel@tkkaskin-mobl3.ger.corp.intel.com>
 <550FFE2B.7050008@canonical.com> <20150323164129.GE14954@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 6338926059C
 for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2015 07:50:43 +0100 (CET)
In-Reply-To: <20150323164129.GE14954@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Tanu Kaskinen <tanu.kaskinen@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org



On 2015-03-23 17:41, Mark Brown wrote:
> On Mon, Mar 23, 2015 at 12:51:07PM +0100, David Henningsson wrote:
>> On 2015-03-23 11:56, Tanu Kaskinen wrote:
>
>>> One thing that is unclear for me is that how are those jacks represented
>>> that support any of headsets/headphones/microphones, but don't provide
>>> information about which device type has been plugged in.
>
>> For headphone or headset, independent switches:
>
>>   * "Headphone Jack"
>>   * "Headset Mic Jack"
>
>> For headphone or headset, one hw switch only:
>
>>   * "Headphone Jack"
>>   * "Headset Mic Phantom Jack"
>
> I'd have expected these to be the same thing, just with the second case
> always having the same state for both switches.

We need to distinguish the use cases: in case of independent switches, 
we can make the assumption that if the user plugged in a headset, the 
user wants to use the headset mic instead of the internal mic, so we 
switch to it.

In the other case, where we don't know if the user plugged in a 
headphone or a headset, we need to ask the user what (s)he plugged in, 
so we can determine whether to select headphone+internal mic or 
headphone+headset mic.

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
