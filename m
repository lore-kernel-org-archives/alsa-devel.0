From: Kevin Groeneveld <kgroeneveld@gmail.com>
Subject: alsa-lib 1.0.27 incorrect definition of __kernel_off_t?
Date: Mon, 22 Jul 2013 17:22:12 -0400
Message-ID: <CABF+-6UXCFt5Oq0yiOkrfiN3kxWtae8zbOkqrdTFmDMm3h07Pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
 [209.85.212.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 08234261A99
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2013 23:22:13 +0200 (CEST)
Received: by mail-wi0-f173.google.com with SMTP id hq4so2396796wib.0
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2013 14:22:12 -0700 (PDT)
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

I tried doing a cross compile of alsa-lib 1.0.27.2 today and ended up with
the following error:

error: conflicting types for 'off_t'

Commit 9b5beef1 adds the following line to local.h:

#define __kernel_off_t        off_t

Not only is __kernel_off_t already defined elsewhere in my header files,
the above line tries to define __kernel_off_t (which I think should be 32
bit on my platform) to off_t which is 64 bit.

I just deleted the line and everything seems to be working so far.


Kevin
