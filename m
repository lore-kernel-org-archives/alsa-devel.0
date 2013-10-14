From: Paul Smedley <paul@smedley.id.au>
Subject: ALSA Driver Source - available outside of kernel?
Date: Mon, 14 Oct 2013 21:20:48 +0000 (UTC)
Message-ID: <loom.20131014T231831-580@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 7BC10261644
 for <alsa-devel@alsa-project.org>; Mon, 14 Oct 2013 23:21:09 +0200 (CEST)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1VVpZb-0003o9-E2
 for alsa-devel@alsa-project.org; Mon, 14 Oct 2013 23:21:07 +0200
Received: from 101.166.51.36 ([101.166.51.36])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Mon, 14 Oct 2013 23:21:07 +0200
Received: from paul by 101.166.51.36 with local (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Mon, 14 Oct 2013 23:21:07 +0200
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

Hi All,

As you may be aware, alsa is the basis of an audio driver uniaud for the os/2 
operating system (http://svn.netlabs.org/uniaud). Up to alsa 1.0.25 I could 
download just the alsa-driver source in order to update uniaud, I see now the 
source is part of the kernel

Is it possible to download just the alsa-driver 1.0.27.2 source from 
anywhere, or do i need to extract it from current linux kernel source?

We also utilised things like adriver.h that were present to support older 
linux kernels - do these still exist? 

I tried mcking around with git and could only find 1.0.25 source.

Thanks,

Paul
