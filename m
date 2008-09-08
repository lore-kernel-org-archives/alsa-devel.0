From: Dmitry Baryshkov <dbaryshkov@gmail.com>
Subject: ASoC vs non-ASoC: 2 pcm driver questions.
Date: Mon, 8 Sep 2008 06:53:48 +0000 (UTC)
Message-ID: <ga2i5s$sge$2@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id EC382244C6
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Sep 2008 08:53:58 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KcadJ-0006P7-K1
	for alsa-devel@alsa-project.org; Mon, 08 Sep 2008 06:53:57 +0000
Received: from iap-pxy-mow1.siemens.ru ([212.248.25.26])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 08 Sep 2008 06:53:57 +0000
Received: from dbaryshkov by iap-pxy-mow1.siemens.ru with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 08 Sep 2008 06:53:57 +0000
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
List-Id: alsa-devel@alsa-project.org

Hi,

While unifying pxa2xx-pcm drivers (ASoC and plain one) I've encountered the
following differences in snd_pcm_open:

1. ASoC one uses snd_soc_set_runtime_hardware() function instead of
 just copying runtime->hw = pxa2xx_pcm_hardware;
However the major difference is that snd_soc_set_runtime_hardware() doesn't
initialise few fields which are set later in generic soc_pcm_open().
Can I drop this call and use the same assignment as in non-asoc driver.

2. To enforce some constraints ASoC driver uses generic
 snd_pcm_hw_constraint_step() instead of hand-written rule functions.
 Can this be also unified or there are some hidden differencies?

-- 
With best wishes
Dmitry
