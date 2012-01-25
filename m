From: "John P. Hartmann" <jphartmann@gmail.com>
Subject: salsa-lib-0.1.2 alsa/pcm_macros.h (on Linux, at least)
Date: Wed, 25 Jan 2012 16:27:52 +0100
Message-ID: <CANM685JYrx_8BkKBjbQXDJVS=TiDFOOmAR3LRjVoQSkJXVCsmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 86AE824360
	for <alsa-devel@alsa-project.org>; Wed, 25 Jan 2012 16:27:53 +0100 (CET)
Received: by vcbfo13 with SMTP id fo13so2951780vcb.38
	for <alsa-devel@alsa-project.org>; Wed, 25 Jan 2012 07:27:52 -0800 (PST)
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

The salsa macros do not compile with -Wall -Werror.

The culprit is the use of "access", which is also a UNIX function.
This function is defined unistd.h, which is included by stddef.h.  And
stddef.h is one of the files mangled into the belly of GCC.

So it is a royal mess, and nobody's fault in particular, but could we
please have the header file updated, for example to use "Acc" rather
than "access" for the parameter?

Thanks,
