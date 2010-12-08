From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] ASoC: CS4271 codec support
Date: Wed, 8 Dec 2010 23:16:34 +0000
Message-ID: <AB4B79E7-D4CF-4098-83C9-708C1EDBE26F@opensource.wolfsonmicro.com>
References: <1291809772.31916.4.camel@r60e>
	<20101208130558.GE16418@rakim.wolfsonmicro.main>
	<1291849166.31916.74.camel@r60e>
	(sfid-20101208_225932_331499_3B362103)
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E0CC6103B5E
	for <alsa-devel@alsa-project.org>; Thu,  9 Dec 2010 00:16:37 +0100 (CET)
In-Reply-To: <1291849166.31916.74.camel@r60e>
	(sfid-20101208_225932_331499_3B362103)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alexander <subaparts@yandex.ru>
Cc: alsa-devel@alsa-project.org, ryan@bluewatersys.com, linux-arm-kernel@lists.infradead.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On 8 Dec 2010, at 22:59, Alexander wrote:

> On Wed, 2010-12-08 at 13:05 +0000, Mark Brown wrote:

>> Ideally the deemphasis would be managed based on the sample rate.

> I'm not sure if it's necessary feature at all. And the way it should be
> managed is something unclear to me )

Provide the user with an on/off switch then if enabled select the deemphasis
filter which is closest to the sample rate. It's not essential to provide the control
but you may as well.
