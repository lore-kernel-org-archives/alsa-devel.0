From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [PATCH v2 1/2] ALSA: jack: create jack kcontrols
 for every jack input device
Date: Wed, 25 Mar 2015 13:53:08 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A901BDD854@SHSMSX101.ccr.corp.intel.com>
References: <1426841719-14576-1-git-send-email-yang.jie@intel.com>
 <1426841719-14576-3-git-send-email-yang.jie@intel.com>
 <s5hd2446mt2.wl-tiwai@suse.de>
 <E7B1D079BA13FB44A978CC8F69C7D6A901BDB90F@SHSMSX101.ccr.corp.intel.com>
 <s5hvbhv6eio.wl-tiwai@suse.de>
 <E7B1D079BA13FB44A978CC8F69C7D6A901BDB93C@SHSMSX101.ccr.corp.intel.com>
 <s5hr3sj6bzj.wl-tiwai@suse.de>
 <E7B1D079BA13FB44A978CC8F69C7D6A901BDB993@SHSMSX101.ccr.corp.intel.com>
 <s5hegoj69bs.wl-tiwai@suse.de>
 <1427108203.2968.57.camel@tkkaskin-mobl3.ger.corp.intel.com>
 <550FFE2B.7050008@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id AC9AB2652E4
 for <alsa-devel@alsa-project.org>; Wed, 25 Mar 2015 14:53:15 +0100 (CET)
In-Reply-To: <550FFE2B.7050008@canonical.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>, Tanu Kaskinen <tanu.kaskinen@linux.intel.com>, Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org


Thank you for comprehensive summarizing, David.
Can you help give more description as below?

~Keyon

> -----Original Message-----
> From: David Henningsson [mailto:david.henningsson@canonical.com]
> Sent: Monday, March 23, 2015 7:51 PM
> To: Tanu Kaskinen; Takashi Iwai
> Cc: Jie, Yang; perex@perex.cz; broonie@kernel.org; alsa-devel@alsa-
> project.org; Girdwood, Liam R; Liam Girdwood
> Subject: Re: [PATCH v2 1/2] ALSA: jack: create jack kcontrols for every jack
> input device
> 
> 
> 
> On 2015-03-23 11:56, Tanu Kaskinen wrote:
> > One thing that is unclear for me is that how are those jacks
> > represented that support any of headsets/headphones/microphones, but
> > don't provide information about which device type has been plugged in.
> 
> For headphone or headset, independent switches:
> 
>   * "Headphone Jack"
>   * "Headset Mic Jack"
[Keyon] here for the most common headset jack
(SND_JACK_HEADPHONE | SND_JACK_MICROPHONE), we should create
two independent kctls/switches--"Headphone Jack" + "Headset Mic Jack",
right?

so, is it possible that there is only "Mic Jack" in this case? I mean that
only input(no output, no physical headphone/speaker jack) jack exist.

If yes, then we may need change "Headset Mic Jack" to "Mic Jack"?

> 
> For headphone or headset, one hw switch only:
[Keyon] I am sorry I am not familiar with the jack HW circuit. What "one 
hw switch only" here means? Does it means that -- for headset Jack, the 
status(connected/disconnected) of HP pin is always exactly same with 
that of Mic pin?
> 
>   * "Headphone Jack"
>   * "Headset Mic Phantom Jack"
[Keyon] for Headset of this type, do we need create only "Headset Mic 
Phantom Jack" kctl, or "Headphone Jack" kctl is also needed?
> 
> Headphone or mic, one hw switch:
[Keyon]I am fresh about this kind of hw jack, it should use different 
segment of the plug, seems we don't need check the actual connected 
status at the jack creation stage, just creating "Headphone Mic Jack"
should works, right?
> 
>   * "Headphone Mic Jack"
> 
> Headphone, headset, or mic, one hw switch only:
[Keyon] how many kctls should we create for this?
> 
>   * "Headphone Mic Jack"
>   * "Headset Mic Phantom Jack"
> 
> Headphone, headset, or mic, one switch for hp/mic and the other for the
> headset mic:
[Keyon] I can't imagine how this works, it's too messy for me. :(
> 
>   * "Headphone Mic Jack"
>   * "Headset Mic Jack"
> 
> The first one is the most common one, but all of the other ones exist,
> especially on recent Dell machines.
> 
> > I know David
> > has made a UI for Ubuntu for selecting the device type once something
> > has been plugged in to such jack, but I don't remember how the UI can
> > know that the jack supports all of those three device types.
> 
> For reference, the code is here:
> http://bazaar.launchpad.net/~unity-settings-daemon-team/unity-settings-
> daemon/trunk/files/head:/plugins/media-keys/what-did-you-plug-in/
> 
> --
> David Henningsson, Canonical Ltd.
> https://launchpad.net/~diwic
