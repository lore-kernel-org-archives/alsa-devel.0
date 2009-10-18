From: "Christian Steffen" <c-steffen@web.de>
Subject: Problems with newest alsa driver on 2.6.30 kernel -
	unknown symbols
Date: Sun, 18 Oct 2009 16:44:55 +0200
Message-ID: <000601ca5001$8f554540$adffcfc0$@de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fmmailgate03.web.de (fmmailgate03.web.de [217.72.192.234])
	by alsa0.perex.cz (Postfix) with ESMTP id 6531624551
	for <alsa-devel@alsa-project.org>;
	Sun, 18 Oct 2009 16:47:32 +0200 (CEST)
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id 01A67127335C7
	for <alsa-devel@alsa-project.org>;
	Sun, 18 Oct 2009 16:44:56 +0200 (CEST)
Received: from [78.49.14.78] (helo=Crusoe)
	by smtp08.web.de with asmtp (WEB.DE 4.110 #314) id 1MzX0B-0003kD-00
	for alsa-devel@alsa-project.org; Sun, 18 Oct 2009 16:44:55 +0200
Content-Language: de
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

Hi there,

while an older version of alsa drivers is working fine with my kernel
2.6.30, the newly compiled modules can't be inserted properly.
I compiled snd-had-intel modules for my kernel 2.6.30 and tried to
insert/start them.

dmesg returns me:

[  106.209451] snd_hda_codec: Unknown symbol __snd_printk
[  106.210340] snd_hda_codec: Unknown symbol snd_hwdep_new
[  106.212211] snd_hda_codec: disagrees about version of symbol
snd_pcm_hw_constraint_step
[  106.212217] snd_hda_codec: Unknown symbol snd_pcm_hw_constraint_step


Any idea?

Thanks,
Christian
