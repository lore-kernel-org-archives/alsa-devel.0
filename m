From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: Re: [PATCH] [RFC 0/13] Intel SST drivers
Date: Tue, 7 Jul 2009 12:03:38 +0530
Message-ID: <98769532B4BB14429434178695419EAE5BBC22F7@bgsmsx501.gar.corp.intel.com>
References: <438BB0150E931F4B9CE701519A44630132984DC0@bgsmsx502.gar.corp.intel.com>
	<20090704103156.GC10490@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 5654A246CF
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jul 2009 08:34:33 +0200 (CEST)
In-Reply-To: <20090704103156.GC10490@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, "Koul, Vinod" <vinod.koul@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


>-----Original Message-----
>From: alsa-devel-bounces@alsa-project.org [mailto:alsa-devel-bounces@alsa-
>project.org] On Behalf Of Mark Brown
>Sent: Saturday, July 04, 2009 4:02 PM
>To: Koul, Vinod
>Cc: alsa-devel@alsa-project.org
>Subject: Re: [alsa-devel] [PATCH] [RFC 0/13] Intel SST drivers
>
>On Fri, Jul 03, 2009 at 11:36:03AM +0530, Koul, Vinod wrote:
>
>> There are 2 drivers involved. One is for the audio DSP engine that can
>> decode and do audio processing and one is for the ALSA sound card
>> driver with support for three different sound cards that are supported
>> on the platform.
>
>Looking at this I'm wondering how general purpose the DSP on these parts
>is.  This sort of integrated DSP is fairly common in modern embedded
>CPUs but normally the DSP is exposed in a more general fashion, allowing
>the DSP to be used for non-audio purposes as well which means that the
>DSP management code tends to live outside the sound tree.
>
>Given what you're saying about Intel-provided firmwares it is possible
>that while the hardware is capable of general purpose use you're not
>exposing sufficient information for people to actually write their own
>firmware in which case that's less of an issue and the situation is
>closer to that with things like WiFi cards but I thought it was better t
>ask.

The DSP is Low power audio engine and not a general purpose DSP. The DSP is optimized for Audio decode/encode offload and rendering. Yes we are thinking of situation closer to WiFi cards

Thanks,
Harsha
