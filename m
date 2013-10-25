From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: [PATCH v3 0/5] ALSA: hda - hdmi: ATI/AMD
 multi-channel and HBR support
Date: Fri, 25 Oct 2013 20:23:48 +0300
Message-ID: <526AA924.5070508@iki.fi>
References: <1382638238-25055-1-git-send-email-anssi.hannula@iki.fi>
 <s5hli1imfsi.wl%tiwai@suse.de> <20131025165452.GA89428@deflower.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sinikuusama.dnainternet.net (sinikuusama.dnainternet.net
 [83.102.40.134])
 by alsa0.perex.cz (Postfix) with ESMTP id 117F72616CB
 for <alsa-devel@alsa-project.org>; Fri, 25 Oct 2013 19:23:55 +0200 (CEST)
In-Reply-To: <20131025165452.GA89428@deflower.internal>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andre Heider <a.heider@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, Olivier Langlois <olivier@trillion01.com>, alsa-devel@alsa-project.org, =?ISO-8859-1?Q?Peter_Fr=FChberger?= <fritsch@xbmc.org>
List-Id: alsa-devel@alsa-project.org

25.10.2013 19:54, Andre Heider kirjoitti:
> On Fri, Oct 25, 2013 at 01:04:45AM +0200, Takashi Iwai wrote:
>> At Thu, 24 Oct 2013 21:10:33 +0300,
>> Anssi Hannula wrote:
>>>
>>> Hi all!
>>>
>>> Here's another revision of the ATI/AMD multichannel+HBR patchset.
>>>
>>> Changes:
>>> - added customizable callbacks instead of polluting generic code
>>> - fixed wrong codec id in rev3+ check (as previously noted)
>>> - cosmetics
>>>
>>> I've only tested this on NVIDIA/Intel, but I'd guess at least Peter
>>> should be able to test this on AMD in a few days or so. The earlier
>>> revisions were tested to fully work.
>>>
>>> Combined patch can be found at: http://onse.fi/files/atihdmi5.patch
>>> However, this patchset is on top recent sound-next commits so it does not
>>> directly apply on older kernels.
>>>
>>> Olivier, I hope you will be able to test this at some point as well
>>> (same things as last time), even though it will be a bit more work :)
>>
>> I applied all patches now.  You can try sound git tree either master
>> or for-next branch.
> 
[...]
> Anssi,
> 
> I gave this a quick test, and it works on my 6850! Nice work!
> The HDMI output is connected to a Onkyo receiver from the future ;) :
> 	EDID for output HDMI-0
> 	Manufacturer: ONK  Model: 1  Serial#: 16777216
> 	Year: 2245  Week: 255
> 	EDID Version: 1.3
> 	EDID (in hex):
[...]
> 
> No DTS-HD/TrueHD support, but all 5.1 channels are working correctly.

Good to hear :)

[...]
> cat /proc/asound/card0/eld\#0.0
> 	monitor_present		1
> 	eld_valid		0

However, this should have eld_valid=1 and contain more info. To get a
hint on whether it is a bug in audio or video driver, could you give a
log with CONFIG_SND_DEBUG ?

AFAICS the sound git master tree should have the necessary support in
the radeon video driver to allow the audio driver to generate a valid
ELD with your card.

-- 
Anssi Hannula
