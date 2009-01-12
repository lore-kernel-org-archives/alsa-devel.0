From: Michael Hirsch <m.hirsch@phase-zero.de>
Subject: 'node->type == SND_CONFIG_TYPE_COMPOUND' failed
Date: Mon, 12 Jan 2009 17:12:03 +0100
Message-ID: <496B6BD3.5040400@phase-zero.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wp122.webpack.hosteurope.de (wp122.webpack.hosteurope.de
	[80.237.132.129])
	by alsa0.perex.cz (Postfix) with ESMTP id 98F891037ED
	for <Alsa-devel@alsa-project.org>; Mon, 12 Jan 2009 17:10:37 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Hello all,

I'm trying to get alsa 1.0.16 working on a ARM PXA processor and I'm 
stuck with the following error message:

aplay: conf.c: 3166: snd_config_iterator_first: Assertion `node->type == 
SND_CONFIG_TYPE_COMPOUND' failed.

kernel version matches the user space library and utils version.

searching the archives / google brings no result.

We tried with an empty alsa.conf but then the message:

ALSA lib pcm.c:2144:(snd_pcm_open_noupdate) Unknown PCM default
aplay: main:564: audio open error: No such file or directory

appears. However the card shows up /proc/asound/cards and alsamixer is 
able to access it.

Any ideas?

Best regards

Michael
