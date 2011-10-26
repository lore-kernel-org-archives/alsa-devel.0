From: Magnus Olsson <magnus.olsson@axis.com>
Subject: ASoC PCM drivers without progress counters breaks
	snd_pcm_status
Date: Wed, 26 Oct 2011 11:25:03 +0200
Message-ID: <A612847CFE53224C91B23E3A5B48BAC74BFCF3FBD6@xmail3.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anubis.se.axis.com (anubis.se.axis.com [195.60.68.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 154351038C0
	for <alsa-devel@alsa-project.org>;
	Wed, 26 Oct 2011 11:25:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by anubis.se.axis.com (Postfix) with ESMTP id 2C68119DDF
	for <alsa-devel@alsa-project.org>;
	Wed, 26 Oct 2011 11:25:09 +0200 (CEST)
Received: from anubis.se.axis.com ([127.0.0.1])
	by localhost (anubis.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id vDfRUo6ijfI8 for <alsa-devel@alsa-project.org>;
	Wed, 26 Oct 2011 11:25:07 +0200 (CEST)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by anubis.se.axis.com (Postfix) with ESMTP id C13EC19DDE
	for <alsa-devel@alsa-project.org>;
	Wed, 26 Oct 2011 11:25:07 +0200 (CEST)
Received: from xmail3.se.axis.com (xmail3.se.axis.com [10.0.5.75])
	by seth.se.axis.com (Postfix) with ESMTP id A32933E084
	for <alsa-devel@alsa-project.org>;
	Wed, 26 Oct 2011 11:25:07 +0200 (CEST)
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
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

To determine the timestamp of captured audio, we do something along the lines:

ts = snd_pcm_status_get_htstamp() - time(snd_pcm_status_get_delay())
snd_pcm_readi(buf)
process(buf, ts)

However for PCM drivers that only update its hw_pointer in steps of periods (in irq-handler), the attributes in snd_pcm_status() struct will not be in sync even though ALSA thinks so. For example, the avail property will correspond to the time of the last IRQ, not at the specified timestamp returned by snd_pcm_status_get_htstamp(). This will introduce timestamp jitter which depends on system IRQ latency and also when the userspace application issues it syscall to read status. For an embedded system under heavy load, the A/V sync is unacceptable when using ALSA timestamps.

Several mainline PCM drivers do this kind of hw-pointer caching in their irq handlers, perhaps because the DMA HW does not support progress counting.

Possible solutions:

1)      If DMA HW supports progress counter, implement it.

2)      If DMA HW is not supported, implement it in software (estimate position using elapsed time since last irq). Only requires driver changes.

3)      If DMA HW is not supported, return use last irq timestamp as the timestamp returned by snd_pcm_status_get_htstamp() . Probably requires ALSA Core changes.

I've tested 1) and results in much improved A/V sync on our systems.  If would be kind of convenient if ALSA SoC Core could provide a generic pointercallback for solution 2), if the PCM driver specifies that it does not support HW progress counter. Otherwise we will see a lot of duplicate code for estimating position. AFAIK, ALSA already maintains a timestamp for last irq.

Magnus Olsson
Axis Communications / Product Platforms
