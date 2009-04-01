From: Chuck Ebbert <cebbert@redhat.com>
Subject: Rewrite of hw_ptr updaters makes things worse?
Date: Wed, 1 Apr 2009 18:46:27 -0400
Message-ID: <20090401184627.5034c20d@dhcp-100-2-144.bos.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.redhat.com (mx2.redhat.com [66.187.237.31])
	by alsa0.perex.cz (Postfix) with ESMTP id C798F103839
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Apr 2009 00:46:47 +0200 (CEST)
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n31MkkOR021596
	for <alsa-devel@alsa-project.org>; Wed, 1 Apr 2009 18:46:46 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n31Mkkvk021445
	for <alsa-devel@alsa-project.org>; Wed, 1 Apr 2009 18:46:47 -0400
Received: from dhcp-100-2-144.bos.redhat.com (dhcp-100-2-144.bos.redhat.com
	[10.16.2.144])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n31MkjIn031786
	for <alsa-devel@alsa-project.org>; Wed, 1 Apr 2009 18:46:45 -0400
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

After adding these patches from 2.6.30 to a 2.6.29 kernel, pulseaudio problems
are worse:

ALSA: pcm - Reset invalid position even without debug option
ALSA: pcm - Fix delta calculation at boundary overlap
ALSA: pcm - Safer boundary checks
ALSA: Rewrite hw_ptr updaters


Mar 28 14:28:20 platon pulseaudio[3040]: alsa-sink.c: Increasing wakeup
watermark to 60,00 ms
Mar 28 14:31:35 platon pulseaudio[3040]: alsa-sink.c: Increasing wakeup
watermark to 70,00 ms
Mar 28 14:31:35 platon pulseaudio[3040]: alsa-sink.c: Increasing wakeup
watermark to 80,00 ms
Mar 28 14:31:35 platon pulseaudio[3040]: alsa-util.c: snd_pcm_avail() returned
a value that is exceptionally large: 4294952932 bytes (24347805 ms).
Mar 28 14:31:35 platon pulseaudio[3040]: alsa-util.c: Most likely this is a bug
in the ALSA driver 'snd_intel8x0'. Please report this issue to the ALSA
developers.
Mar 28 14:31:35 platon pulseaudio[3040]: rtpoll.c: Assertion 'usec <=
((pa_usec_t) 1000000ULL)*60ULL*60ULL' failed at pulsecore/rtpoll.c:548,
function pa_rtpoll_set_timer_relative(). Aborting.
