From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 4/4] ASoC: firmware core: Add core support
 to create and destroy firmware components.
Date: Wed, 21 Nov 2012 10:21:17 +0000
Message-ID: <50ACAB1D.2040103@ti.com>
References: <1353348765-6238-1-git-send-email-lrg@ti.com>
 <1353348765-6238-4-git-send-email-lrg@ti.com>
 <20121120032659.GC4483@opensource.wolfsonmicro.com> <50AB9E56.5050509@ti.com>
 <20121121004356.GC4673@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 45FFB265CD1
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2012 11:21:21 +0100 (CET)
In-Reply-To: <20121121004356.GC4673@opensource.wolfsonmicro.com>
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

On 21/11/12 00:43, Mark Brown wrote:
> On Tue, Nov 20, 2012 at 03:14:30PM +0000, Liam Girdwood wrote:
>> On 20/11/12 03:27, Mark Brown wrote:
>
>>> With coefficeints we have been moving towards a model where we just
>>> expose them as binary controls rather than doing the enumeration thing.
>
>> For ABE we have different coefficients tied to each enumerated EQU
>> kcontrol setting and just configure the ABE coefficient depending on
>> the kcontrol value. We load the coefficients and EQU kcontrol at the
>> same time since it's enumerated text strings are coupled to the
>> coefficients.
>
> So, the text strings for coefficients were what drivers used to be using

Yeah, it will be your standard alsamixer enum kcontrol strings e.g. for the 
ABE DL1 EQU has "Flat Response", "800Hz HPF 0dB", "800Hz HPF -12dB", "800Hz 
HPF -20dB", "4000Hz LPF 0dB" where the settings are tied to the associated 
blob of coefficients.

Liam
