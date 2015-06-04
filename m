From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: Different codecs for playback and capture?
Date: Thu, 04 Jun 2015 15:52:49 +0200
Message-ID: <55705831.7060305@metafoo.de>
References: <alpine.DEB.2.02.1506031045380.22011@lnxricardw1.se.axis.com>
 <556F0E7F.80802@metafoo.de>
 <alpine.DEB.2.02.1506041343450.15001@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-080.synserver.de (smtp-out-080.synserver.de
 [212.40.185.80])
 by alsa0.perex.cz (Postfix) with ESMTP id EC70A26061E
 for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2015 15:52:50 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.02.1506041343450.15001@lnxricardw1.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricard Wanderlof <ricard.wanderlof@axis.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 06/04/2015 01:46 PM, Ricard Wanderlof wrote:
>
> On Wed, 3 Jun 2015, Lars-Peter Clausen wrote:
>
>> There has been support for multiple CODECs on the same DAI link for a while
>> now. Have a look at
>> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=88bd870f02dff5c9445286e185f21873f25a977f.
>>
>> Instead of setting the codec_name/codec_dai_name fields in the dai_link
>> create a snd_soc_link_component array with a entry for each of the CODECs
>> and assign that to the codecs field in the DAI link.
>>
>> I'm not too sure how well it works if one CODEC is playback only and the
>> other is capture only and there might be some issues. But this is the way to
>> go and if there are problems fix them.
>
> It doesn't seem as if snd_soc_dai_link_component is used in any (in-tree)
> driver; a grep in sound/soc just returns soc-core.c . Perhaps some
> out-of-tree driver has been used to test it?

This is the only example I'm aware of:
http://wiki.analog.com/resources/tools-software/linux-drivers/sound/ssm4567#multi_ssm4567_example_configuration

>
> How are the different component codecs accessed when accessing the device?
> Or does this happen automatically? For instance, normally I would register
> one card with the single dai and coec, which would come up as #0, so I
> could access the resulting device with hw:0,0 . But when I have two codecs
> on the same dai_link, what mechanism does ALSA use to differentiate
> between the two? Or is it supposed to happen automatically depending on
> the capabilities of the respective codecs.

It will be exposed as a single card with one capture and one playback PCM. 
So it will be the same as if the CODEC side was only a single device 
supporting both.
