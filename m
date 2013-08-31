From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 00/14] SPDIF support
Date: Sat, 31 Aug 2013 22:45:26 +0200
Message-ID: <522255E6.6010800@metafoo.de>
References: <20130831123458.GF6617@n2100.arm.linux.org.uk>
 <52220B9A.9000007@metafoo.de> <20130831191414.GG6617@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-186.synserver.de (smtp-out-186.synserver.de
 [212.40.185.186])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E879261B36
 for <alsa-devel@alsa-project.org>; Sat, 31 Aug 2013 22:43:53 +0200 (CEST)
In-Reply-To: <20130831191414.GG6617@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, Jean-Francois Moine <moinejf@free.fr>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 08/31/2013 09:14 PM, Russell King - ARM Linux wrote:
> On Sat, Aug 31, 2013 at 05:28:26PM +0200, Lars-Peter Clausen wrote:
>> On 08/31/2013 02:34 PM, Russell King - ARM Linux wrote:
>> [...]
>>> The same conditions apply as per my previous posting - the DAI link
>>> needs to be setup and the associated DAPM routes to tell the CPU DAI
>>> which outputs are in use, like this:
>>>
>>> DAI link:
>>>                 .name = "S/PDIF1",
>>>                 .stream_name = "IEC958 Playback",
>>>                 .platform_name = "mvebu-audio.1",
>>>                 .cpu_dai_name = "mvebu-audio.1",
>>>                 .codec_dai_name = "dit-hifi",
>>>                 .codec_name = "spdif-dit",
>>>
>>> static const struct snd_soc_dapm_route routes[] = {
>>>         { "Playback", NULL, "spdifdo" },
>>> };
>>
>> This is still not exactly the right way to implement this though. Add a
>> second DAI to your CPU driver, like this:
> 
> What you're suggesting is the DPCM solution.

No it is not using any DPCM. You only need to use DPCM if you want to use
both DAIs at the same time. But maybe you want to do that?

- Lars
