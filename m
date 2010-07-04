From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: issue with TWL4030
Date: Sun, 4 Jul 2010 10:28:01 +0900
Message-ID: <538E63AD-6099-4DA7-AF94-B9CD60D3DBF8@opensource.wolfsonmicro.com>
References: <AANLkTilwdeNLChInBSaFIpVTLDONLXIIHVpLk3Aibk0v@mail.gmail.com>
	<20100703000635.GA3533@sirena.org.uk>
	<AANLkTilvo5eV352yiSgOSst_kwt3juh4LSdTM64H5eBT@mail.gmail.com>
	(sfid-20100703_153215_586738_42F1509B)
Mime-Version: 1.0 (iPad Mail 7B367)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 251DE24496
	for <alsa-devel@alsa-project.org>;
	Sun,  4 Jul 2010 03:27:52 +0200 (CEST)
In-Reply-To: <AANLkTilvo5eV352yiSgOSst_kwt3juh4LSdTM64H5eBT@mail.gmail.com>
	(sfid-20100703_153215_586738_42F1509B)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On 3 Jul 2010, at 23:32, Grazvydas Ignotas <notasas@gmail.com> wrote:

> On Sat, Jul 3, 2010 at 3:06 AM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
>> On Sat, Jul 03, 2010 at 01:50:50AM +0300, Grazvydas Ignotas wrote:
>> 
>>> there seems to be a problem with TWL4030 hw_param programming, which
>>> is easy to reproduce over OSS emulation with this simple program:
>> 
>> OSS emulation is strongly disrecommended due to the fact that it
>> repeatedly reprograms things using partially valid configurations.  Some
>> drivers will refuse to run with it.
> 
> Well it used to work fine on OMAP+TWL until one of Peter's rework
> patches, I guess 6b87a91f (haven't really bisected), hope we can find
> some solution. We have some closed OSS programs that we can't drop,
> unfortunately. I know userspace OSS emulation solutions exist, but it
> wouldn't hurt to have more options.

OSS is dying in mainline, distributions are desupporting it and it's just painful all round to carry the bodges for it in kernel, so I really would recommend exploring the userspace solutions if you need to interoperate with this unfixable userspace stuff. I'd anticipate you will run into further issues going forward with kernel side changes, and it gives you more room to do things like soft mixing in your userspace stack too. 
