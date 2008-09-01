From: Simon Tremblay <bidou@videotron.qc.ca>
Subject: Re:
	=?utf-8?q?alsa-lib=2C_dmix=2C_and_snd=5Fpcm=5Fopen?=
	=?utf-8?q?=5Fconf_function?=
Date: Mon, 1 Sep 2008 17:17:29 +0000 (UTC)
Message-ID: <loom.20080901T171602-395@post.gmane.org>
References: <loom.20080901T165414-425@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id E56C6244CC
	for <alsa-devel@alsa-project.org>;
	Mon,  1 Sep 2008 19:17:38 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KaD20-00018h-Q1
	for alsa-devel@alsa-project.org; Mon, 01 Sep 2008 17:17:37 +0000
Received: from 72.0.201.57 ([72.0.201.57])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 01 Sep 2008 17:17:36 +0000
Received: from bidou by 72.0.201.57 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 01 Sep 2008 17:17:36 +0000
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

Simon Tremblay <bidou <at> videotron.qc.ca> writes:

> I located my problem in alsa-lib, around line 2154 of alsa-lib/src/pcm/pcm.c: 
> 
> err = snd_pcm_open_conf(pcmp, name, root, pcm_conf, stream, mode); (in
> snd_pcm_open_noupdate function)
> 
> err result is -1 when it's used with dmix...
> 


Note that I get 1 for snd_config_search_definition return value.
