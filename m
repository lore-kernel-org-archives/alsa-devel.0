From: James Miller <jamesstewartmiller@gmail.com>
Subject: tascam us122l
Date: Fri, 4 Oct 2013 16:12:49 +0100
Message-ID: <CAKJvYZEoB_Sf=3ZQcnkZmqAS3M4YK-G7dFVYctE1D9yRuGNPtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f54.google.com (mail-qa0-f54.google.com
 [209.85.216.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F8A72615DF
 for <alsa-devel@alsa-project.org>; Fri,  4 Oct 2013 17:12:50 +0200 (CEST)
Received: by mail-qa0-f54.google.com with SMTP id bv4so1124546qab.13
 for <alsa-devel@alsa-project.org>; Fri, 04 Oct 2013 08:12:49 -0700 (PDT)
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

Hi, I've just checked the kernel source for the tascam us122l (us122l.c
us122l.h) and it has changed completely since the 3.4 kernel.  I'm having a
stack trace problem when trying to use jack with us122l.  The card is
recognised and I am using the .asoundrc from pub.briata.org as I always
have done.
When the us122l.c got broken (around about kernel version 3.6 to 3.9)  I
was able to get it working by recompiling the kernel after amending the
us122l.c source code by changing a flag that was pushed in to a vm struct.

In the new code I can't find any reference to the vm operation and it seems
that the code has changed completely, I am going to try and revert to the
3.4 us122l.c to see if that will work, but I'd be grateful if someone could
look into this.  Thanks

James

-- 
James Stewart Miller Bsc(hons) Psych.
