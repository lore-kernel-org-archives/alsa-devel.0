From: Akshay Mishra <akshaymishra@gmail.com>
Subject: Fwd: Overrun Errors - SAM9G
Date: Thu, 17 Jul 2014 18:24:02 +0530
Message-ID: <CABSY_Zsh44D19KtDYkc6ozSsxKpTk+cQJiy4rEGKqWgbv_a=tQ@mail.gmail.com>
References: <CABSY_ZsjSaZQA+KadBWnzR-9=YQby-Fnb9ZpBGZpXHtVsZZXMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f48.google.com (mail-oi0-f48.google.com
 [209.85.218.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 178BB265531
 for <alsa-devel@alsa-project.org>; Thu, 17 Jul 2014 14:54:23 +0200 (CEST)
Received: by mail-oi0-f48.google.com with SMTP id h136so1058869oig.7
 for <alsa-devel@alsa-project.org>; Thu, 17 Jul 2014 05:54:23 -0700 (PDT)
In-Reply-To: <CABSY_ZsjSaZQA+KadBWnzR-9=YQby-Fnb9ZpBGZpXHtVsZZXMw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello,
    I am trying a simple alsa capture on the Atmel ARM9 (SAM9G45). While
only capture runs fine, putting any os call on the same thread gives XRUNs.

Even a innocent usleep(1) seems to lead to regular XRUNs. Eventually I want
to dump this capture on the serial port and I am not able to get past this.

I have tried on AT91 linux as well as on kernel 3.10.10-rt7 with no success.

Please advice,
Akshay
