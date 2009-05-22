From: Chuck Ebbert <cebbert@redhat.com>
Subject: 2.6.30: xruns caused by "ALSA: pcm - Safer boundary
	checks"
Date: Fri, 22 May 2009 16:27:09 -0400
Message-ID: <20090522162709.2e04b688@dhcp-100-2-144.bos.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.redhat.com (mx2.redhat.com [66.187.237.31])
	by alsa0.perex.cz (Postfix) with ESMTP id 111F024530
	for <alsa-devel@alsa-project.org>;
	Fri, 22 May 2009 22:27:39 +0200 (CEST)
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n4MKRaGx002154
	for <alsa-devel@alsa-project.org>; Fri, 22 May 2009 16:27:38 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n4MKRZx0024135
	for <alsa-devel@alsa-project.org>; Fri, 22 May 2009 16:27:36 -0400
Received: from dhcp-100-2-144.bos.redhat.com (dhcp-100-2-144.bos.redhat.com
	[10.16.2.144])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n4MKRZFC015733
	for <alsa-devel@alsa-project.org>; Fri, 22 May 2009 16:27:35 -0400
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

Bug report: https://bugzilla.redhat.com/show_bug.cgi?id=498858

To reproduce, pause a video in mplayer and then hit play:

ALSA sound/core/pcm_lib.c:263: hda_codec: hw_ptr skipping! [Q] (pos=11263,
delta=17400, period=1024, jdelta=21/362/0)
ALSA sound/core/pcm_lib.c:337: hda_codec: hw_ptr skipping! (pos=11730,
delta=1490, period=1024, jdelta=10/31)
ALSA sound/core/pcm_lib.c:337: hda_codec: hw_ptr skipping! (pos=11734,
delta=1494, period=1024, jdelta=10/31)
ALSA sound/core/pcm_lib.c:337: hda_codec: hw_ptr skipping! (pos=11734,
delta=1494, period=1024, jdelta=10/31)
ALSA sound/core/pcm_lib.c:337: hda_codec: hw_ptr skipping! (pos=11735,
delta=1495, period=1024, jdelta=10/31)
ALSA sound/core/pcm_lib.c:263: hda_codec: hw_ptr skipping! [Q] (pos=12287,
delta=2047, period=1024, jdelta=21/42/0)
ALSA sound/core/pcm_lib.c:337: hda_codec: hw_ptr skipping! (pos=12449,
delta=2209, period=1024, jdelta=4/46)
