From: Michel Normand <normand@linux.vnet.ibm.com>
Subject: [PATCH] alsa-tools gcc6 narrowing error
Date: Mon, 20 Jun 2016 15:26:05 +0200
Message-ID: <1466429166-2201-1-git-send-email-normand@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by alsa0.perex.cz (Postfix) with ESMTP id BF99F2654BE
 for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2016 15:26:21 +0200 (CEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5KDDeAF096744
 for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2016 09:26:20 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23n0mdvxpm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2016 09:26:19 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <alsa-devel@alsa-project.org> from <normand@linux.vnet.ibm.com>;
 Mon, 20 Jun 2016 14:26:17 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 1380C17D805A
 for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2016 14:27:29 +0100 (BST)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
 [9.149.37.250])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5KDQDcm3277060
 for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2016 13:26:13 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5KDQCXM007787
 for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2016 07:26:12 -0600
Received: from mnow541.ibm.com (sig-9-83-70-219.evts.uk.ibm.com [9.83.70.219])
 by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with
 ESMTP id u5KDQ8Si007578
 for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2016 07:26:09 -0600
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Trying to build alsa-tools with gcc6 for PowerPC architecture.
It failed as detailed in proposed patch of next mail


Michel Normand (1):
  gcc6 narrowing error

 hdspmixer/src/channelmap.cxx | 158 +++++++++++++++++++++----------------------
 us428control/Cus428Midi.cc   |  30 ++++----
 2 files changed, 94 insertions(+), 94 deletions(-)

-- 
1.9.1
