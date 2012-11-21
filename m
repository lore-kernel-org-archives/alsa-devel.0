From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 4/4] ASoC: firmware core: Add core support
 to create and destroy firmware components.
Date: Wed, 21 Nov 2012 11:16:18 +0000
Message-ID: <50ACB802.20102@ti.com>
References: <1353348765-6238-1-git-send-email-lrg@ti.com>
 <1353348765-6238-4-git-send-email-lrg@ti.com>
 <20121120032659.GC4483@opensource.wolfsonmicro.com> <50AB9E56.5050509@ti.com>
 <20121121004356.GC4673@opensource.wolfsonmicro.com> <50ACAB1D.2040103@ti.com>
 <20121121103754.GC18117@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 27C63265CD2
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2012 12:16:20 +0100 (CET)
In-Reply-To: <20121121103754.GC18117@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 21/11/12 10:37, Mark Brown wrote:
> On Wed, Nov 21, 2012 at 10:21:17AM +0000, Liam Girdwood wrote:
>> On 21/11/12 00:43, Mark Brown wrote:
>
>>> So, the text strings for coefficients were what drivers used to be using
>
>> Yeah, it will be your standard alsamixer enum kcontrol strings e.g.
>> for the ABE DL1 EQU has "Flat Response", "800Hz HPF 0dB", "800Hz HPF
>> -12dB", "800Hz HPF -20dB", "4000Hz LPF 0dB" where the settings are
>> tied to the associated blob of coefficients.
>
> Right, but the decision we took at the ASoC conference and have been
> implementing was to move away from that to just letting applications set
> the binary blob to change the enumeration value instead and then putting
> the management of multiple names for the blobs into userspace.
>

Ok, this is fine and works well for larger or multiple blobs that will be 
frequently changed at runtime depending on use case. However, the ABE 
coefficients here (around 400 bytes per EQU) are only loaded once at boot 
(where the number and graph positions of the EQUs is tightly coupled to the 
FW) and are not unloaded. The simplification here is that we dont have to 
write any new userspace code to manage the ABE EQUs and treat them as regular 
alsamixer controls which makes the integration and testing easier in this case.

Liam
