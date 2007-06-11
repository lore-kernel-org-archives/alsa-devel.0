From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: =?utf-8?q?=5BASoC=5D_bug_in_soc=5Fpcm=5Fopen?=
Date: Mon, 11 Jun 2007 15:02:54 +0000 (UTC)
Message-ID: <loom.20070611T165936-889@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id EEA60103818
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jun 2007 17:14:36 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HxlTy-0008Tm-4G
	for alsa-devel@alsa-project.org; Mon, 11 Jun 2007 17:07:02 +0200
Received: from ASt-Lambert-152-1-34-237.w82-124.abo.wanadoo.fr
	([82.124.160.237]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 11 Jun 2007 17:07:02 +0200
Received: from matthieu.castet by
	ASt-Lambert-152-1-34-237.w82-124.abo.wanadoo.fr with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 11 Jun 2007 17:07:02 +0200
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

it seems there is a bug in soc_pcm_open. In some case [1] we are in a error
path, but we don't set the ret return value.

This cause bug/crash from alsa core.

Thanks

Matthieu



[1]http://hg-mirror.alsa-project.org/alsa-kernel/file/38926de0e79c/soc/soc-core.c
if (!runtime->hw.rates) {

      218 		printk(KERN_ERR "asoc: %s <-> %s No matching rates\n",

      219 			codec_dai->name, cpu_dai->name);

      220 		goto machine_err;

      221 	}

      222 	if (!runtime->hw.formats) {

      223 		printk(KERN_ERR "asoc: %s <-> %s No matching formats\n",

      224 			codec_dai->name, cpu_dai->name);

      225 		goto machine_err;

      226 	}

      227 	if (!runtime->hw.channels_min || !runtime->hw.channels_max) {

      228 		printk(KERN_ERR "asoc: %s <-> %s No matching channels\n",

      229 			codec_dai->name, cpu_dai->name);

      230 		goto machine_err;

      231 	}
