From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Cards that support ADPCM in hardware
Date: Thu, 16 Oct 2014 20:40:35 +0600
Message-ID: <543FD8E3.3020802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f45.google.com (mail-wg0-f45.google.com [74.125.82.45])
 by alsa0.perex.cz (Postfix) with ESMTP id A2649264EAA
 for <alsa-devel@alsa-project.org>; Thu, 16 Oct 2014 16:40:37 +0200 (CEST)
Received: by mail-wg0-f45.google.com with SMTP id m15so3871167wgh.4
 for <alsa-devel@alsa-project.org>; Thu, 16 Oct 2014 07:40:37 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, davem@davemloft.net, adrian@mcmen.demon.co.uk, perex@perex.cz
List-Id: alsa-devel@alsa-project.org

Hello.

Due to the "remove support for old hardware" topic that is going to be 
discussed at the Linux Plumbers Conference, let me see if there is 
actually any supported hardware that supports ADPCM.

A quick grep for ADPCM in the sound directory yields this:

./isa/wss/wss_lib.c: ISA, Windows sound system
./isa/sb/sb16_{main,csp}.c: ISA, classic SB16 card
./oss/ad1848.c: Another ISA card, OSS-only
./sh/aica.c: for SEGA Dreamcast console
./sparc/cs4231.c: I don't know about this

Is any of the hardware listed above still used (or usable) with the 
current kernels?

-- 
Alexander E. Patrakov
