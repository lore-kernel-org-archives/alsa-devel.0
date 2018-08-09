From: Rob Duncan <rduncan@tesla.com>
Subject: Miscellaneous ioplug questions
Date: Thu, 9 Aug 2018 11:45:51 -0700
Message-ID: <dw77emtvo3pee8.fsf@tesla.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-0019bd01.pphosted.com (mx0a-0019bd01.pphosted.com
 [148.163.151.57])
 by alsa0.perex.cz (Postfix) with ESMTP id EA7EF2677CD
 for <alsa-devel@alsa-project.org>; Thu,  9 Aug 2018 20:45:54 +0200 (CEST)
Received: from pps.filterd (m0127435.ppops.net [127.0.0.1])
 by mx0a-0019bd01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w79IiK9s024849
 for <alsa-devel@alsa-project.org>; Thu, 9 Aug 2018 11:45:52 -0700
Received: from external-smtp.teslamotors.com (external-smtp.teslamotors.com
 [205.234.27.238])
 by mx0a-0019bd01.pphosted.com with ESMTP id 2kru43g0md-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
 for <alsa-devel@alsa-project.org>; Thu, 09 Aug 2018 11:45:52 -0700
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "'alsa-devel@alsa-project.org'" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I have some questions about some ioplug implementation details:

- Is the value returned from the pointer callback supposed to be a
  monotonically increasing value, or should it wrap at the buffer size?
  The documentation says "get the current DMA position" which isn't
  clear to me.

- Must the pointer callback return values that are an integral multiple
  of the period size, or can it report partial periods?

- Should the poll FD be made writeable as soon as data is available, or
  only when at least avail_min is available?

Thanks,

Rob.
