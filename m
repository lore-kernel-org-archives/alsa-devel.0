From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH] ASoC: Add card driver data
Date: Fri, 28 Jan 2011 08:11:54 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0310C8DF0F@HQMAIL01.nvidia.com>
References: <1296220523-26815-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1296220770.3335.55.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id C83841037FF
	for <alsa-devel@alsa-project.org>; Fri, 28 Jan 2011 17:12:05 +0100 (CET)
In-Reply-To: <1296220770.3335.55.camel@odin>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Liam Girdwood wrote on Friday, January 28, 2011 6:20 AM:
> 
> On Fri, 2011-01-28 at 13:15 +0000, Mark Brown wrote:
> > Provide driver data for cards within the card structure. To simplify the
> > implementation of the PM operations we don't use the struct device
> driver
> > data as this is used by the core to retrieve the card in callbacks from
> > the device model and PM core.
> >
> > Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
> Acked-by: Liam Girdwood <lrg@slimlogic.oc.uk>

Thanks. This is obviously exactly what I need too.

-- 
nvpublic
