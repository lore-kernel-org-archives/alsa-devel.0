From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [PATCH] ASoC/multi-component: fix au1x platform
Date: Thu, 19 Aug 2010 16:30:10 +0200
Message-ID: <AANLkTik_VdzUEZ0+079iZciOryRbFNDyjE-jdzJXztcW@mail.gmail.com>
References: <AANLkTikyZKhs6t8RRRd36KjW_Enb-+NGvUCraxEakHO5@mail.gmail.com>
	<20100819140649.GA29395@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20100819140649.GA29395@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: alsa-devel@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Thu, Aug 19, 2010 at 4:06 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, Aug 19, 2010 at 03:21:35PM +0200, Manuel Lauss wrote:
>
>> Attached is a patch which fixes the Alchemy (au1x) audio platform
>> in your "topic/multi-component" branch.
>
> I would provide more detailed review but you've attached your patch as a
> base64 encoded attachment rather than including it inline so my MUA
> hasn't quoted it.
>
> As far as your comments about multiple cards go this should now be
> supported, though the fact that you're modifying the static data for the
> DAI means that the aux1x drivers probably don't support this or only
> support it in a limited fashion.

The hardware does support it with the issue you mentioned fixed, but the
global "soc_ac97_ops" needs to go away first.  The alchemy line can
support up to 4 independent ac97 "cards" with certain models.


> Your kobject_name() stuff looks pretty fishy - is there some reason for
> not using dev_name()?

no reason, I'll change it.

Thanks,
      Manuel Lauss
