From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [RFC i-iv] ASoC: Add support for cross-device paths
	without dai and without name collision
Date: Fri, 29 Oct 2010 15:00:15 +0300
Message-ID: <1288353618-21753-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id BB4F6243FC
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Oct 2010 13:59:15 +0200 (CEST)
Received: by eyg24 with SMTP id 24so1790068eyg.38
	for <alsa-devel@alsa-project.org>; Fri, 29 Oct 2010 04:59:15 -0700 (PDT)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi

I'm sending here four set of patches that are build on top of another. They
are trying to solve issues with following setup:

CPU <-> [Codec x.0] -> [Codec x.1] -> out

Here only Codec x.0 has DAI link between codec and CPU, Codec x.1 is used as
an amplifier and the same codec driver is used for both codec instances.

Currently this setup is not possible because ASoC doesn't support cross-device
paths, i.e. DAPM is per codec, there is no support to register dailess codecs
and no resolution for name collisions that would occur when multiple codec
instances tries to register same kcontrols and when trying to build paths
between widgets.

I've separated patches to these problems to separate sets so that reviewing
would be easier. However, they depend on previous sets so they must be applied
sequentially and thus each set is named as RFC_[i-iv]/iv.

I've based this work on of top of Liam's DAPM decoupling patches. Those must
be squashed together but I'm sending here them separately because they include
core change from Liam and trivial conversions and minor fixes from me.

i	Decoupling DAPM from codecs. Core implementation from Liam Girdwood
	and some minor bits from me, conversion of new codecs and all the
	platforms. I've build tested the codecs and OMAP platforms and if some
	platform doesn't build, it's my fault.
ii	Extend ASoC core to handle cross-device paths. Decoupling paths and
	widgets from DAPM context and handling cross-device bias and widget
	power changes.
iii	Support for dailess codecs. This is achieved by renaming dai_link as
	dev_map, i.e. the former struct snd_soc_dai_link becomes
	struct snd_soc_dev_map so it does not only describe platform, cpu dai
	and codec binding but also registration of dailess codecs.
iv	Optional name_prefix to struct snd_soc_dev_map. With this a machine
	driver can specify a name that is used to prefix codec kcontrols,
	widgets and internal route names for avoiding name collision that would
	occur if multiple codec instances are registered.


-- 
Jarkko
