From: Rob Duncan <rduncan@tesla.com>
Subject: More snd_pcm_ioplug_avail_update() questions
Date: Wed, 25 Jul 2018 14:52:36 -0700
Message-ID: <dw77emin53c7a3.fsf@tesla.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-0019bd01.pphosted.com (mx0b-0019bd01.pphosted.com
 [148.163.155.1])
 by alsa0.perex.cz (Postfix) with ESMTP id 1EFB026774B
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 23:52:38 +0200 (CEST)
Received: from pps.filterd (m0127436.ppops.net [127.0.0.1])
 by mx0a-0019bd01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6PLmQkx028302
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 14:52:37 -0700
Received: from external-smtp.teslamotors.com (external-smtp.teslamotors.com
 [205.234.27.238])
 by mx0a-0019bd01.pphosted.com with ESMTP id 2keyr1rdm3-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 14:52:37 -0700
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

Is it required that all available data has been committed between calls
to snd_pcm_ioplug_avail_update() on an IO plugin capture stream?

If this is not a requirement then there can still be uncommitted data in
the mmap after the current appl_ptr.  This data will get overwritten by
the transfer call.

If it is a requirement then snd_pcm_rate_avail_update() seems to be
doing the wrong thing, because it only commits in units of the period
size, which means that there could be a partial period left in the mmap.

Can someone clarify what the contract is for these calls?

Thanks,

Rob.
