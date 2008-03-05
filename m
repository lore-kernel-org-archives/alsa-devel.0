From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: aplay error - cant resolve symbol alsa_lisp_init
Date: Wed, 5 Mar 2008 09:27:09 -0800
Message-ID: <61445c750803050927r77212b12qe12a2f45615282c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.180])
	by alsa0.perex.cz (Postfix) with ESMTP id 049E4103858
	for <alsa-devel@alsa-project.org>; Wed,  5 Mar 2008 18:27:10 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id m33so1529174wag.8
	for <alsa-devel@alsa-project.org>; Wed, 05 Mar 2008 09:27:09 -0800 (PST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I am trying to run aplay on my board, I have got alsa-lib and
alsa-utils on board and when I  try to run
aplay, I get following.

# aplay -h
Dec 31 16:04:42 kernel: Error -5 while decompressing!
Dec 31 16:04:42 kernel: c0234d4a(1911)->c35e3000(4096)
aplay: can't resolve symbol 'alsa_lisp_init_objects'
Dec 31 16:04:42 kernel: aplay used greatest stack depth: 5676 bytes left
# aplay --help
aplay: can't resolve symbol 'alsa_lisp_init_objects'

Any clue?

-pharaoh.
