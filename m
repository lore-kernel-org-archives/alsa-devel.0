From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [RFC 0/5] Add a gpio jack device
Date: Mon, 25 May 2015 17:17:01 +0200
Message-ID: <55633CED.2090600@metafoo.de>
References: <1432332563-15447-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-195.synserver.de (smtp-out-195.synserver.de
 [212.40.185.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 867702610A3
 for <alsa-devel@alsa-project.org>; Mon, 25 May 2015 17:17:05 +0200 (CEST)
In-Reply-To: <1432332563-15447-1-git-send-email-dgreid@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dylan Reid <dgreid@chromium.org>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, lgirdwood@gmail.com, zhengxing@rock-chips.com
List-Id: alsa-devel@alsa-project.org

On 05/23/2015 12:09 AM, Dylan Reid wrote:
> The first three changes add a gpio audio jack device.  This device can
> be used on systems that report headphone or mic plug through GPIOS.
> There can be 0-N of these devices created per board each can report one
> of several events.  For example, this allows for a single jack for
> HP/Mic and a separate jack for line out.

I'm not convinced that this series is the right approach and I don't think 
it helps us to solve the problem.

I think what we need to get the layering and encapsulation right is to 
introduce a distinction between jacks and jack detection logic. The jacks 
are part of the fabric and should be registered by the machine driver. The 
jack detection logic can be implemented by either GPIOs, a dedicated jack 
detection chip, like the TS3A227E, or can be part of a more complex CODEC. 
The jack detection logic is a function that is provided by these. The audio 
fabric, which makes up the sound card, is a consumer of this functionality.

To be able to properly abstract this changes to the framework are necessary 
to introduce the concept of jack detection logic providers and consumers.

The chip/driver that implements the jack detection logic register a jack 
detection logic provider, the machine driver registers the jack and 
specifies which jack detection provider is used for each jack.

- Lars
