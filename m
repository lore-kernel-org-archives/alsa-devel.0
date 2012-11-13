From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: CM6206, S/PDIF + JACK
Date: Tue, 13 Nov 2012 22:25:34 +0100
Message-ID: <50A2BACE.80107@ladisch.de>
References: <CANOoOjsvRWz6N7eUgJRyFohqih4_d9-sCXhHpWs3M7i4wXjbWQ@mail.gmail.com>	<50A2434A.8000803@ladisch.de>
 <CANOoOjtGq5OYYkhVHrxivCSrPmvzid1_-vbvuzDtgDqChUHTSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 443D6265230
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2012 22:25:45 +0100 (CET)
In-Reply-To: <CANOoOjtGq5OYYkhVHrxivCSrPmvzid1_-vbvuzDtgDqChUHTSQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan MacDonald <allcoms@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dan MacDonald wrote:
> However, I had a quick go at capturing audio from SPDIF and the default
> stereo inputs (after making sure SPDIF in was enabled under alsamixer)
>  this morning but I got nothing. I have zero experience with SPDIF devices
> and Linux (or any other OS) so I dunno what to watch out for

This depends entirely on how the hardware implements the routing.

> In my quick test I was trying to capture audio from a audio CDR so there
> won't have been any copy protection on the disc. CDs are 44.1Khz of course
> but I was running JACK at 48Khz - that shouldn't be an issue should it or
> would I need to run JACK at 44.1 to capture an audio CD via SPDIF? Maybe rt
> resampling isn't supported?

I didn't find a box labeled "high-quality resampler for those lazy Jack
users" in the datasheet ...

> Another thing thats just come to mind is I think that the mic and line
> inputs were also set to capture so maybe I'd need to only enable capture
> for the SPDIF input but nothing else?

In theory, only one input can be enabled at the same time.
What does "amixer contents" show for this device?


Regards,
Clemens
