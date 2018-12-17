From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 2/3] ASoC: xlnx: Add i2s driver
Date: Mon, 17 Dec 2018 13:28:42 +0100
Message-ID: <ce27a85e-ce86-a16f-cd1d-eeb953e9575c@xilinx.com>
References: <1544207558-72508-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
 <1544207558-72508-3-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
 <20181213153127.GN10669@sirena.org.uk>
 <19c273d9-c52d-48be-a1e1-88e2b1f14cce@xilinx.com>
 <20181217122441.GC13868@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820079.outbound.protection.outlook.com [40.107.82.79])
 by alsa0.perex.cz (Postfix) with ESMTP id A778126789E
 for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2018 13:29:03 +0100 (CET)
In-Reply-To: <20181217122441.GC13868@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>, Michal Simek <michal.simek@xilinx.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, Vishal Sagar <vsagar@xilinx.com>
List-Id: alsa-devel@alsa-project.org

On 17. 12. 18 13:24, Mark Brown wrote:
> On Fri, Dec 14, 2018 at 07:50:43AM +0100, Michal Simek wrote:
>> On 13. 12. 18 16:31, Mark Brown wrote:
>>> On Sat, Dec 08, 2018 at 12:02:37AM +0530, Maruthi Srinivas Bayyavarapu wrote:
> 
>>>> @@ -0,0 +1,185 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * Xilinx ASoC I2S audio support
>>>> + *
> 
>>> This looks otherwise good so I've applied it but please send a followup
>>> patch converting the entire comment block to C++ style so this looks
>>> more consistent.
> 
>> Is it the rule for your subsystems? Or did it come from any generic
>> agreement how this should be handled in .c files?
> 
> It's mainly me, it's certainly not a consistent policy.
> 

ok.
Maruthi: Please send that patch which Mark is asking about.

Thanks,
Michal
