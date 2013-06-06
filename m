From: James Miller <jamesstewartmiller@gmail.com>
Subject: "https://bugtrack.alsa-project.org/alsa-bug" Tascam
	US122L
Date: Thu, 6 Jun 2013 13:56:32 +0100
Message-ID: <CAKJvYZH=kmG7MotB8wOfYeLhF8hu1uWVo75Rt5aicP2sj28ZAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oa0-f52.google.com (mail-oa0-f52.google.com
 [209.85.219.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 9429A261AAB
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2013 14:56:33 +0200 (CEST)
Received: by mail-oa0-f52.google.com with SMTP id o13so2101279oag.25
 for <alsa-devel@alsa-project.org>; Thu, 06 Jun 2013 05:56:32 -0700 (PDT)
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

Hi, I can't visit this bugtracker page (above) and am also wondering if
there is any progress on the Tascam US122L.  I understand someone from the
kxaudio team has tried a kernel bisect but that the problem lies in the
driver with a vm switch.

http://www.remastersys.com/forums/index.php?topic=3013.0

somewhere I read that this was an alsa problem but I found this kernel
patch (referred to) and it has been suggested that it is this that is the
cause.  I am not a prof. developer but might have a go at recompiling my
kernel after changing the module so that I can get my soundcard working
with kernel 3.8.13-rt(patch).  Do you guys know anything about this that
might help me?

https://patchwork.kernel.org/patch/1258951/

thanks

James

ubuntu studio on mac pro 2006

3.8.13-rt9 #1 SMP PREEMPT RT Thu May 30 18:54:25 BST 2013 x86_64 x86_64
x86_64 GNU/Linux

-- 
James Stewart Miller Bsc(hons) Psych.
