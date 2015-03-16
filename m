From: Shawn Embedded <programassem@gmail.com>
Subject: Support two wm8962 codec in i.mx6 board.
Date: Mon, 16 Mar 2015 15:30:49 +0800
Message-ID: <CAOaGyfUHS90nKcSxpQZm7X3Lgwtb_9V4xLzyObhd5v=diGHJLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f174.google.com (mail-ob0-f174.google.com
 [209.85.214.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 6FC4C260524
 for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2015 08:30:50 +0100 (CET)
Received: by obbgg8 with SMTP id gg8so29462579obb.1
 for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2015 00:30:49 -0700 (PDT)
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

Hello everyone,

    I'm new to ALSA.

    I have a question here.
    Now there is a wm8962 on the i.mx6 board, running well, and we
want to add an extra wm8962 to the board, connected to i.mx6 on
another SSI port through a different i.mx6's AUDMUX port. The two
wm8962 will work independently completely, at the same time possiblly.

    Before sending this mail to the list, I've already googled some
materials about my requirements.
    I've found there is a structure named "struct snd_soc_aux_dev".
    For my applicantion, if I want to support another wm8962, could I
can use this structure for my intention please?
    But in this link
http://www.spinics.net/lists/alsa-devel/msg40127.html ,  it's said
that

This makes possible to register auxiliary dailess codecs in a machine
driver. Term dailess is used here for amplifiers and codecs without DAI or
DAI being unused.

     then, does it mean that I couldn't use this structure for my application?

    Or, I should declare another structure "struct snd_soc_card" for
the second wm8962, just as the now-working wm8962? or other ways?

    In fact, I'm a little confused if I could declare two structure
snd_soc_card at the same? If it's OK, what should I do next to meet my
requirement?

    Could anyone give me any guidance on this? Any links, and
materials will also be much appreciated.

    Thank you in advance.


-------------------

Best Regards,
Shawn
