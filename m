From: Roel Kluin <roel.kluin@gmail.com>
Subject: pcm_oss: Can period_bytes - buffer_used be less than 0?
Date: Wed, 04 Mar 2009 16:32:23 +0100
Message-ID: <49AE9F07.1000904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f163.google.com (mail-ew0-f163.google.com
	[209.85.219.163])
	by alsa0.perex.cz (Postfix) with ESMTP id 886EE1037EF
	for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2009 16:32:24 +0100 (CET)
Received: by ewy7 with SMTP id 7so2751366ewy.32
	for <alsa-devel@alsa-project.org>; Wed, 04 Mar 2009 07:32:23 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

vi sound/core/oss/pcm_oss.c +1572 (in linus' git tree) and note:

static int snd_pcm_oss_sync(struct snd_pcm_oss_file *pcm_oss_file)
{
	...
	size_t size;
	... :1608
	size = runtime->oss.period_bytes - runtime->oss.period_ptr;

can this period_bytes - buffer_used become less than 0?

Roel
