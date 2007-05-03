From: "Prabhu Sivaraja" <prabhu.sivaraja@gmail.com>
Subject: DMix period_size should always be half of buffer size?
Date: Thu, 3 May 2007 15:50:19 -0700
Message-ID: <49f264960705031550q4884453ck6d9d6a1f1b6ef6d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.227])
	by alsa0.perex.cz (Postfix) with ESMTP id 71581243BD
	for <alsa-devel@alsa-project.org>;
	Fri,  4 May 2007 00:50:22 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id l8so667217nzf
	for <alsa-devel@alsa-project.org>; Thu, 03 May 2007 15:50:21 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: perex@suse.cz, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a followup to my earlier question about dmix not being able to mix
small files. I investigated it more and here is what I found.

Again background info.
I have a 64KB as kernel buffer and a 64KB circular buffer for my device. In
a poll thread I copy the data obtained from ALSA lib from the kernel buffer
to my device circular buffer by keeping track of appl_ptr and hw_ptr(dmix
only). Everything was working fine except when I was trying to mix files
smaller than 64KB(my buffer size), the small file was not getting mixed
through the dmix plugin. Anything over 64KB was getting mixed just fine. So
I set about reducing my period size from 32KB to 4KB while maintaining my
buffer size at 64KB.

When I tried to do this my hw_ptr never gets incremented from 0. Hence my
driver is stuck in a loop waiting for bytes to copy. This is only observed
when I am using dmix plugin and NOT when using hw or plughw. When my period
size is half the size of my buffer everything works fine with dmix (I
verified this by reducing my buffer size to 8KB and making my period size
4KB. hw_ptr gets incremented then but I get buffer problems). It seems like
dmix is forcing me to keep my period size half the size of my buffer. hw and
plughw devices do not seem to do that.

Is this a limitation of dmix. Could anyone comment on the dmix limitation
that I am experiencing.

Thanks a lot of all your help.

Prabhu.
