From: "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: any reason for include/uapi/sound header files not
 listed in Kbuild?
Date: Sat, 28 May 2016 15:10:32 -0400 (EDT)
Message-ID: <alpine.LFD.2.20.1605281508070.8417@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp684.redcondor.net (smtp684.redcondor.net [208.80.206.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 9874526058E
 for <alsa-devel@alsa-project.org>; Sat, 28 May 2016 21:11:13 +0200 (CEST)
Received: from astoria.ccjclearline.com ([64.235.106.9])
 by smtp684.redcondor.net ({700db0a8-6fb7-4c8b-9b2a-6812225182d8})
 via TCP (outbound) with ESMTPS id 20160528191111220_0684
 for <alsa-devel@alsa-project.org>; Sat, 28 May 2016 19:11:11 +0000
Received: from [99.240.204.5] (port=54062 helo=crashcourse.ca)
 by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
 (Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
 id 1b6jfF-0006LD-2m
 for alsa-devel@alsa-project.org; Sat, 28 May 2016 15:12:49 -0400
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


  i just noticed that, in include/uapi/sound/, there are three header
files:

* asoc.h
* tlv.h
* usb_stream.h

that are not referenced by the corresponding Kbuild file. is there any
reason for this? or, in general, is there *any* reason for there to be
header files under include/uapi/ that are not listed in their Kbuild
files? thanks.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
