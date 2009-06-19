From: Adam Williamson <awilliam@redhat.com>
Subject: IDT quirks...where?
Date: Fri, 19 Jun 2009 14:49:20 -0700
Message-ID: <1245448160.313.510.camel@adam.local.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.redhat.com (mx2.redhat.com [66.187.237.31])
	by alsa0.perex.cz (Postfix) with ESMTP id 6FA902469B
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Jun 2009 23:49:26 +0200 (CEST)
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n5JLnNeR032704
	for <alsa-devel@alsa-project.org>; Fri, 19 Jun 2009 17:49:25 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n5JLnMIm017354
	for <alsa-devel@alsa-project.org>; Fri, 19 Jun 2009 17:49:22 -0400
Received: from [10.16.10.32] (vpn-10-32.bos.redhat.com [10.16.10.32])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n5JLnLYg015172
	for <alsa-devel@alsa-project.org>; Fri, 19 Jun 2009 17:49:21 -0400
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

Hi, guys. Following up a Fedora forum quirk report:

http://forums.fedoraforum.org/showpost.php?p=1229209&postcount=16

elsewhere in the thread, the reporter is instructed to try the hp-dv5
model parameter, and reports that this works.

The alsa-info output shows the subsystem ID as 103c:3621, and the codec
as IDT 92HD71B7X. This is one I haven't seen before. I wanted to write
up a bug report with a patch to add a quirk for this chipset, but I
can't see which of the quirk files it should go into - none of the
patch_*.c files seems to cover IDT codecs. What's the story with these?
Where do their quirks go? Does current ALSA have one already? (I did try
searching through each of the patch_*.c files for 3621 and found
nothing, but I may have missed something).

Thanks!

-- 
Adam Williamson
Fedora QA Community Monkey
IRC: adamw | Fedora Talk: adamwill AT fedoraproject DOT org
http://www.happyassassin.net
