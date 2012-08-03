From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [alsa-devel] DT support for Davinci ASoC platform
Date: Fri, 3 Aug 2012 14:39:32 +0530
Message-ID: <501B954C.3070606@ti.com>
References: <1BAFE6F6C881BF42822005164F1491C33EA35352@DBDE01.ent.ti.com>
 <4FF5733E.6000604@gmail.com> <501AE3C6.8040708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <501AE3C6.8040708@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Daniel Mack <zonque@gmail.com>
Cc: "Porter, Matt" <mporter@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Rajashekhara,
 Sudhakar" <sudhakar.raj@ti.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "Hebbar,
 Gururaja" <gururaja.hebbar@ti.com>, "alsa-user@lists.sourceforge.net" <alsa-user@lists.sourceforge.net>, "Girdwood,
 Liam" <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Hi Daniel,

On 8/3/2012 2:02 AM, Daniel Mack wrote:
> On 05.07.2012 12:58, Daniel Mack wrote:
>> Hi Gururaja,
>>
>> On 04.07.2012 14:48, Hebbar, Gururaja wrote:
>>> All,
>>>
>>> Are there any plans or work going on for providing Device Tree Support for Davinci
>>> ASoC?
>>>
>>> I am planning to add DT support for TI AM335x (McASP) and I don't want to do duplicate
>>> task.
>>
>> That's good to know. But isn't there a dependency on the EDMA engine? Is
>> that part ported yet?
> 
> May I ask whether you made any progress on that yet?

Matt Porter from TI is working on DMA engine migration. This would still
be some time away since there is a bunch of work involved here.

To make progress on Audio DT conversion Gururaja is doing an up port of
AM335x EDMA support from TI release to mainline kernel. If you are
interested in it, he can probably share that with you once he posts his
DT patches.

Thanks,
Sekhar
