From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 2/3] ASoC: xlnx: Add i2s driver
Date: Fri, 14 Dec 2018 07:50:43 +0100
Message-ID: <19c273d9-c52d-48be-a1e1-88e2b1f14cce@xilinx.com>
References: <1544207558-72508-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
 <1544207558-72508-3-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
 <20181213153127.GN10669@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181213153127.GN10669@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Vishal Sagar <vsagar@xilinx.com>, Michal Simek <michal.simek@xilinx.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On 13. 12. 18 16:31, Mark Brown wrote:
> On Sat, Dec 08, 2018 at 12:02:37AM +0530, Maruthi Srinivas Bayyavarapu wrote:
> 
>> @@ -0,0 +1,185 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Xilinx ASoC I2S audio support
>> + *
> 
> This looks otherwise good so I've applied it but please send a followup
> patch converting the entire comment block to C++ style so this looks
> more consistent.

Is it the rule for your subsystems? Or did it come from any generic
agreement how this should be handled in .c files?

Thanks,
Michal
