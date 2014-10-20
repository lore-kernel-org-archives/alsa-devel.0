From: Jordan Kagan <jrkagan2@gmail.com>
Subject: bug in alsa-utils 1.0.28 - arecord
Date: Mon, 20 Oct 2014 15:33:45 -0400
Message-ID: <CAC_TXnmZcBcXSgGH6JgsjwhN9jeruo3YbEzcrbGSxb-M5Mq5oQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f45.google.com (mail-wg0-f45.google.com [74.125.82.45])
 by alsa0.perex.cz (Postfix) with ESMTP id CADC3265D05
 for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2014 21:34:05 +0200 (CEST)
Received: by mail-wg0-f45.google.com with SMTP id m15so6153591wgh.28
 for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2014 12:34:05 -0700 (PDT)
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

Hello,

I encountered an issue with using the arecord binary in this most recent
version.  When using the '-d' duration flag, the program will continue to
open files AFTER the duration has expired.  The issue occurs when the
capture() while loop hits the break due to a value returned by pcm_read().
When the while loop is exited, the program hits the do-while loop and
continues to open files indefinitely.  If rcount is returned from
pcm_read() instead of "result", the problem does not occur.

Thanks,

Jordan
