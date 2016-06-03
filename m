From: Eric Nelson <eric@nelint.com>
Subject: Re: [PATCH] ASoC: sgtl5000: only check VDDD-supply, not revision
Date: Fri, 3 Jun 2016 18:23:18 +0200
Message-ID: <5751AEF6.40200@nelint.com>
References: <20160602124724.7725-1-clemens.gruber@pqgruber.com>
 <CAOMZO5B20n7Tu3r+BsU2R5BbYj41tf7qBsMLRWxChdWMkHxLNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOMZO5B20n7Tu3r+BsU2R5BbYj41tf7qBsMLRWxChdWMkHxLNQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>, Clemens Gruber <clemens.gruber@pqgruber.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Fabio,

On 06/02/2016 05:48 PM, Fabio Estevam wrote:
> Hi Clemens,
> 
> On Thu, Jun 2, 2016 at 9:47 AM, Clemens Gruber
> <clemens.gruber@pqgruber.com> wrote:
>> Instead of checking the SGTL5000 chip revision, we should only check if
>> the VDDD regulator exists and only call sgtl5000_replace_vddd_with_ldo
>> if the regulator is missing.
>> Otherwise, the user reads in the kernel log that the internal LDO is
>> used, even though he did follow the NXP recommendation to use external
>> VDDD and also specified VDDD-supply in the devicetree.
>>
>> Also remove the comment, which incorrectly states that external VDDD is
>> only supported for SGTL5000 chip revisions < 0x11.
>> Official NXP documentation recommends using external VDDD and not the
>> internal LDO due to the SGTL5000 erratum ER1. This also applies to
>> revisions >= 0x11.
>>
>> Tested on an i.MX6Q board with SGTL5000 rev 0x11 and external VDDD.
> 
> Patch looks good to me.
> 
> Eric,
> 
> Sometime ago you were looking at this. What do you think about this patch?
> 

Sorry. I'm traveling and haven't had a chance to review this, but it's
on my to-do.
