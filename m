From: Michael Jordan <mjordan1@catamount.wcu.edu> (by way of Michael Jordan
 <jordan.mymail@gmail.com>)
Subject: BeagleBoard driver development (PCM3168)
Date: Sun, 11 Aug 2013 20:51:14 -0400
Message-ID: <20130811205114.0b7c21e1@mach1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f174.google.com (mail-qc0-f174.google.com
 [209.85.216.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 217C92602AD
 for <alsa-devel@alsa-project.org>; Mon, 12 Aug 2013 02:52:29 +0200 (CEST)
Received: by mail-qc0-f174.google.com with SMTP id c1so3087765qcz.19
 for <alsa-devel@alsa-project.org>; Sun, 11 Aug 2013 17:52:28 -0700 (PDT)
Received: from mach1 ([24.246.150.10])
 by mx.google.com with ESMTPSA id m8sm9445252qay.0.2013.08.11.17.52.27
 for <alsa-devel@alsa-project.org>
 (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
 Sun, 11 Aug 2013 17:52:27 -0700 (PDT)
Resent-Message-ID: <20130811205224.5d28c8cc@mach1>
Resent-To: <alsa-devel@alsa-project.org>
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

Okay, before I went too far I thought to download archives and found
that Klimann has been working on this, but last post I see is April
2013. I picked through and got what I think are the last discussed of
the 3 files omap-pcm3168.c pcm3168.c and pcm3168.h. I did not mean to
cross paths with anybody. I will compare these to what I have worked up
and see what I can contribute.

I am a bit confused about one thing though. When I began this (before I
knew I might be stepping on somebody else's work) I downloaded 3.10
sources from kernel.org. I have previously and again grepped through
the sources and I find no mention of pcm3168. Has this project just not
made it that far? And do I have the latest versions (plucked from the
text archives, or are they in a git somewhere that I don't know about?

Michael
