From: Ricardo Biehl Pasquali <pasqualirb@gmail.com>
Subject: Boundary calculation
Date: Mon, 16 Jul 2018 16:25:07 -0300
Message-ID: <20180716192507.GA7151@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f170.google.com (mail-qk0-f170.google.com
 [209.85.220.170])
 by alsa0.perex.cz (Postfix) with ESMTP id D5FE6267600
 for <alsa-devel@alsa-project.org>; Mon, 16 Jul 2018 21:25:16 +0200 (CEST)
Received: by mail-qk0-f170.google.com with SMTP id z74-v6so21070628qkb.10
 for <alsa-devel@alsa-project.org>; Mon, 16 Jul 2018 12:25:16 -0700 (PDT)
Received: from localhost.localdomain ([201.37.66.59])
 by smtp.gmail.com with ESMTPSA id u21-v6sm14149905qka.88.2018.07.16.12.25.14
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 16 Jul 2018 12:25:14 -0700 (PDT)
Content-Disposition: inline
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

Hello.

I can't get the tricky boundary calculation. Perhaps I'm
missing some obvious thing, or maybe it's really some
circumvent for a specific case that was not commented.

The current calculation for boundary is:

	boundary = buffer_size;
	while (boundary * 2 <= LONG_MAX - buffer_size)
		boundary *= 2;

I've checked out some repositories, specially alsa-driver
in ALSA git, and I realized this calculation exists at
least since 2001. I guess it was Jaroslav who wrote.

Visualization of the calculation (B = buffer_size):

                           LONG_MAX
-------------------------------
\______________/           \__/
     B * 4                  B
\______/
 B * 2
\__/
 B

Why isn't a simpler calculation used instead? e.g.:

	/* closest multiple of buffer size less or equal LONG_MAX */
	boundary = LONG_MAX - LONG_MAX % buffer_size;

                           LONG_MAX
-------------------------------
\__________________________/
           B * 6

Cheers!

	pasquali
