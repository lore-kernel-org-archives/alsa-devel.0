From: Qais Yousef <qais.yousef@imgtec.com>
Subject: Re: [PATCH 00/10] Add support for img AXD audio hardware decoder
Date: Thu, 27 Aug 2015 10:07:08 +0100
Message-ID: <55DED33C.50007@imgtec.com>
References: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com>
 <20150826180436.GC28760@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150826180436.GC28760@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

On 08/26/2015 07:04 PM, Mark Brown wrote:
> On Mon, Aug 24, 2015 at 01:39:09PM +0100, Qais Yousef wrote:
>
>> Qais Yousef (10):
>>    irqchip: irq-mips-gic: export gic_send_ipi
>>    dt: add img,axd.txt device tree binding document
>>    ALSA: add AXD Audio Processing IP alsa driver
>>    ALSA: axd: add fw binary header manipulation files
>>    ALSA: axd: add buffers manipulation files
>>    ALSA: axd: add basic files for sending/receiving axd cmds
>>    ALSA: axd: add cmd interface helper functions
>>    ALSA: axd: add low level AXD platform setup files
>>    ALSA: axd: add alsa compress offload operations
>>    ALSA: axd: add Makefile
> Please try to use subject lines matching the style for the subsystem, I
> very nearly deleted this unread because it looks like an ALSA patch
> series, not an ASoC one.

OK sorry about that. I'll fix this in the next series.

Thanks,
Qais
