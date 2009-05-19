From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
Subject: POLLOUT warnings dropped by Pulseaudio
Date: Tue, 19 May 2009 15:59:45 +0300
Message-ID: <4A12AD41.3030101@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pardus.org.tr (ns2.uludag.org.tr [193.140.100.220])
	by alsa0.perex.cz (Postfix) with ESMTP id F3E502473B
	for <alsa-devel@alsa-project.org>;
	Tue, 19 May 2009 14:59:49 +0200 (CEST)
Received: from [192.168.1.2] (unknown [88.249.178.198])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested) (Authenticated sender: ozan)
	by pardus.org.tr (Postfix) with ESMTP id 58535669C631
	for <alsa-devel@alsa-project.org>;
	Tue, 19 May 2009 15:59:38 +0300 (EEST)
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

Pulseaudio keeps telling

May 19 12:22:59 mecbuk pulseaudio[1630]: alsa-sink.c: ALSA woke us up to
write new data to the device, but there was actually nothing to write!
May 19 12:22:59 mecbuk pulseaudio[1630]: alsa-sink.c: Most likely this
is a bug in the ALSA driver 'snd_hda_intel'. Please report this issue to
the ALSA developers.
May 19 12:22:59 mecbuk pulseaudio[1630]: alsa-sink.c: We were woken up
with POLLOUT set -- however a subsequent snd_pcm_avail() returned 0 or
another value < min_avail.

on quite every system (say 8 out of 10). I remember the long discussion
thread about a few problems found and fixed in alsa-lib. Is there
anything left to do, any way of helping by sending some debugging output
or else, to fix those issues totally?

Or should I silently ignore those messages?

Thanks,
Ozan Caglayan
