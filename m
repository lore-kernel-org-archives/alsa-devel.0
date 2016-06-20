From: Michel Normand <normand@linux.vnet.ibm.com>
Subject: [PATCH] gcc6 reporting error building alsa-tools on
	PowerPC
Date: Mon, 20 Jun 2016 10:10:23 +0200
Message-ID: <1466410224-19466-1-git-send-email-normand@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by alsa0.perex.cz (Postfix) with ESMTP id A2E54261703
 for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2016 10:10:34 +0200 (CEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5K84G3C044730
 for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2016 04:10:33 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23n0mdj0je-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2016 04:10:33 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <alsa-devel@alsa-project.org> from <normand@linux.vnet.ibm.com>;
 Mon, 20 Jun 2016 09:10:30 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 0A5661B08067
 for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2016 09:11:39 +0100 (BST)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
 [9.149.37.249])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5K8ASqh34668558
 for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2016 08:10:28 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5K8ARKp016880
 for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2016 02:10:27 -0600
Received: from mnow541.ibm.com (sig-9-83-70-219.evts.uk.ibm.com [9.83.70.219])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with
 ESMTP id u5K8APwr016763
 for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2016 02:10:26 -0600
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

Hello there,
While trying to build alsa-tools with gcc6, many reported error
that are solved by proposed patch.

I do not know if sending to this mailing list is the correct way to provide it to you.

Michel Normand (1):
  gcc6 narrowing error

 hdspmixer/src/channelmap.cxx | 158 +++++++++++++++++++++----------------------
 us428control/Cus428Midi.cc   |  30 ++++----
 2 files changed, 94 insertions(+), 94 deletions(-)

-- 
1.9.1
