From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Very elementary question regarding period size
Date: Mon, 27 Aug 2007 15:49:30 +0530
Message-ID: <61445c750708270319p3ca234dfx965fd5c8d98ca03f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.180])
	by alsa0.perex.cz (Postfix) with ESMTP id 75A64103829
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Aug 2007 12:19:32 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id j37so2130730waf
	for <alsa-devel@alsa-project.org>; Mon, 27 Aug 2007 03:19:31 -0700 (PDT)
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

I am testing out my alsa driver for various period and buffer sizes, at some
configurations it doesn't work so arises this very basic question.

Is every sound card/hardware supposed to work at all the period sizes?  The
way I have written my driver, makes the DMA processing dependent on period
size so the answer is obvious in my case, that it might not work for all
period sizes. Does it hold true for all the cards?

-pharaoh.
