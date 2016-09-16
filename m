From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] Revert "ASoC: core: mark SND_SOC_BYTES_EXT
	as deprecated"
Date: Fri, 16 Sep 2016 22:21:12 +0900
Message-ID: <9ad9a4af-85ab-6e9f-f17b-6e8afc7fe595@sakamocchi.jp>
References: <1473980762-13259-1-git-send-email-o-takashi@sakamocchi.jp>
 <20160916105247.GY27974@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 47075266875
 for <alsa-devel@alsa-project.org>; Fri, 16 Sep 2016 15:21:15 +0200 (CEST)
In-Reply-To: <20160916105247.GY27974@sirena.org.uk>
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
Cc: tiwai@suse.de, vinod.koul@intel.com, alsa-devel@alsa-project.org, clemens@ladisch.de, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Sep 16 2016 19:52, Mark Brown wrote:
> On Fri, Sep 16, 2016 at 08:06:02AM +0900, Takashi Sakamoto wrote:
>
> Please submit patches using subject lines reflecting the style for the
> subsystem.  This makes it easier for people to identify relevant
> patches.  Look at what existing commits in the area you're changing are
> doing and make sure your subject lines visually resemble what they're
> doing.

OK. But the different fashion in ALSA SoC part from ALSA itself often 
puzzles me.

>> However, SND_SOC_BYTES_TLV brought confusions to user land because it
>> doesn't follow to a protocol of ALSA control interface. At least, this
>> macro and related kernel APIs include two misunderstandings:
>>  - 'struct snd_ctl_elem_info.count' can also represent the length of TLV
>>    packet paylaod, snd_soc_bytes_info_ext() performs in this way.
>>  - 'struct snd_ctl_tlv.tlv' can include arbitrary data regardless of TLV
>>    packet structure, snd_soc_bytes_tlv_callback() performs in this way.
>
> I can't tell what problem you are trying to describe here, sorry.  What
> are you expecting the userspace ABI to do that these controls don't,
> you appear to be saying that the code does actually do what's expected
> which obviously isn't a problem.

These two APIs don't perform what to be expected in a point of 
application interface. These two items are not what to be expected in a 
point of application interface, but what they do wrong.

> What do you expect to happen, what is
> actually happening and why do you beleive this to be a problem?

This patchset comes from a conclusion of this thread:
[alsa-devel] [RFC][PATCH 0/4] ALSA: control: return payload length of 
TLV operation
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-August/112242.html
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-September/112479.html
(they were cross month end.)

If you need a minute, please read Iwai-san's post:
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-September/112534.html

>> In the first place, SND_SOC_BYTES_TLV was added to satisfy a request of
>> developers who need to add control elements which transfer data larger than
>> the size which 'struct snd_ctl_elem_value' can represent; e.g. over 512
>> bytes. As long as the size is less than the size, SND_SOC_BYTES_EXT is
>> still available. Although there is the limitation of maximum data size,
>> it's better to use this API for stable application interface till better
>> alternative ways are implemented in future.
>
> This doesn't make much sense to me, sorry.  This is an interface for
> drivers.  They shouldn't need to know the implementation details of
> different controls and we should be striving for consistency in the
> interface we present both at the driver level and at the userspace
> level.

I have no objections to this indication. I agree with it, as a driver 
developer.

> Having two randomly different interfaces is not going to help
> that or stop the larger controls existing, it'll just make the interface
> more confusing for driver authors.

On the other hand, when some driver developers actually follow to the 
message which I'd like to purge, then abuses of the interface are 
increased. Near future, it will bring confusions and disorder to ALSA 
applications. And the cause is hard to be identified from user land, 
because few developers think drivers lose protocol of application 
interface in fact.

Of cource, there's a need to work more to solve this issue. This is 
quite a small part of it.


Regards

Takashi Sakamoto
