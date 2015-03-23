From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH v2 1/2] ALSA: jack: create jack kcontrols
 for every jack input device
Date: Mon, 23 Mar 2015 12:51:07 +0100
Message-ID: <550FFE2B.7050008@canonical.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 48588260568
 for <alsa-devel@alsa-project.org>; Mon, 23 Mar 2015 12:51:11 +0100 (CET)
In-Reply-To: <1427108203.2968.57.camel@tkkaskin-mobl3.ger.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tanu Kaskinen <tanu.kaskinen@linux.intel.com>, Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, "broonie@kernel.org" <broonie@kernel.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org



On 2015-03-23 11:56, Tanu Kaskinen wrote:
> One thing that is unclear for me is that how are those jacks represented
> that support any of headsets/headphones/microphones, but don't provide
> information about which device type has been plugged in.

For headphone or headset, independent switches:

  * "Headphone Jack"
  * "Headset Mic Jack"

For headphone or headset, one hw switch only:

  * "Headphone Jack"
  * "Headset Mic Phantom Jack"

Headphone or mic, one hw switch:

  * "Headphone Mic Jack"

Headphone, headset, or mic, one hw switch only:

  * "Headphone Mic Jack"
  * "Headset Mic Phantom Jack"

Headphone, headset, or mic, one switch for hp/mic and the other for the 
headset mic:

  * "Headphone Mic Jack"
  * "Headset Mic Jack"

The first one is the most common one, but all of the other ones exist, 
especially on recent Dell machines.

> I know David
> has made a UI for Ubuntu for selecting the device type once something
> has been plugged in to such jack, but I don't remember how the UI can
> know that the jack supports all of those three device types.

For reference, the code is here: 
http://bazaar.launchpad.net/~unity-settings-daemon-team/unity-settings-daemon/trunk/files/head:/plugins/media-keys/what-did-you-plug-in/

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
