From: Timur Tabi <timur@freescale.com>
Subject: asoc: problem with snd_soc_dai_set_fmt()
Date: Thu, 29 Apr 2010 16:22:17 -0500
Message-ID: <4BD9F889.4010106@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 1470F1038CD
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Apr 2010 23:22:36 +0200 (CEST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o3TLMIX6003799
	for <alsa-devel@alsa-project.org>; Thu, 29 Apr 2010 14:22:30 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id o3TLWUsQ020339
	for <alsa-devel@alsa-project.org>; Thu, 29 Apr 2010 16:32:30 -0500 (CDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

There is a problem with snd_soc_dai_set_fmt():

int snd_soc_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
{
	if (dai->driver && dai->driver->ops->set_fmt)
		return dai->driver->ops->set_fmt(dai, fmt);
	else
		return -EINVAL;
}

Let's say the DAI driver has not defined a .set_fmt() function.  This means
that if the fabric driver does this:

ret = snd_soc_dai_set_fmt(cpu_dai, machine_data->dai_format);
if (ret < 0) {
	dev_err(dev, "could not set CPU driver audio format\n");
	return ret;
}

It's going to think that the DAI driver *rejected* the DAI format.  What
this means is that I cannot make this function optional.  I have to define
this function in my CPU driver.

May I propose this:

int snd_soc_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
{
	if (dai->driver && dai->driver->ops->set_fmt)
		return dai->driver->ops->set_fmt(dai, fmt);
	else
		return 0;
}

-- 
Timur Tabi
Linux kernel developer at Freescale
