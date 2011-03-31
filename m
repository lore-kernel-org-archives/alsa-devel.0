From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: Query - ASoC headphone detection stereo vs. mono
Date: Thu, 31 Mar 2011 22:35:26 +0100
Message-ID: <1301607326.3549.214.camel@odin>
References: <4D94C7C2.8050109@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 1C7BC1037FB
	for <alsa-devel@alsa-project.org>;
	Thu, 31 Mar 2011 23:35:30 +0200 (CEST)
Received: by wyg36 with SMTP id 36so2622060wyg.38
	for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2011 14:35:29 -0700 (PDT)
In-Reply-To: <4D94C7C2.8050109@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Patrick Lai <plai@codeaurora.org>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-03-31 at 11:28 -0700, Patrick Lai wrote:
> I would like to get a better understanding on how to propagate channel 
> mode of inserted headphone through soc-jack framework? I looked at 
> jack.h and I don't see any definition of channel mode. I would assume 
> that user-space needs this information in order to set up the path in 
> the audio CODEC properly such as mixing stereo content into mono stream 
> inside CODEC. How is use case handled on other platform?
> 

The Jack detect core doesn't have this sort of functionality yet. We can
report insertions and device type (if supported by the hardware) but it
does sound like we need to additionally pass this sort of information up
if required.

Another agenda topic.

Thanks

Liam 
