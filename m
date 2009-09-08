From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: Layla 3G does not recover from ACPI Suspend
Date: Tue, 8 Sep 2009 21:32:45 +0200
Message-ID: <20090908213245.0f97cabc@Jay>
References: <alpine.BSO.2.00.0909061445140.28864@zrgural.vwaro.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out28.alice.it (smtp-out28.alice.it [85.33.2.28])
	by alsa0.perex.cz (Postfix) with ESMTP id 933481037F7
	for <alsa-devel@alsa-project.org>;
	Tue,  8 Sep 2009 21:34:48 +0200 (CEST)
In-Reply-To: <alpine.BSO.2.00.0909061445140.28864@zrgural.vwaro.pbz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Hills <mark@pogo.org.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, 6 Sep 2009 15:16:57 +0100 (BST)
Mark Hills <mark@pogo.org.uk> wrote:

> I have an Echo Layla 3G in my workstation. It works for audio, but does 
> not recover from ACPI suspend to RAM.

I does not recover because there is not suspend/resume support. I wrote
almost complete support a lot of time ago which wasn't merged due to two
unsolved issues. The resurrection procedure (actually it is a reinit from
scratch) was very unreliable on my Gina24 for unknown reasons and there
was an atomicity issue in the rawmidi interface.
I can manage to provide you a patch for testing in a few days.


--
Giuliano.
