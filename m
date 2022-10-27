Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2929DFA3740
	for <alsa-devel@archiver.kernel.org>; Thu, 27 Oct 2022 13:38:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 57A432FC0;
	Thu, 27 Oct 2022 15:37:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 57A432FC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666877904;
	bh=5YAEco5Tq5AjmO/fVsK+NqVFKGrLuVvUAlTBWUtrozY=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HYvYwNORqXi1ulvXc6UC416cPLL48jIFqvLO+7z7l1N+NN1eSqQLYACyCynoj31Zm
	 ph0BAl8KDhiHORKzzH/yH6+E9pT7XPWcmtM0Ng6a9DUn6VPlJrNMjE+gC/iAn+uObR
	 2GMNuaVFhcqGeOgQwyl5zFdjIRDUWtFchz6nMPMw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0771BF8025E;
	Thu, 27 Oct 2022 15:37:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 873B3F8025A; Thu, 27 Oct 2022 15:37:32 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 77A0AF80496
 for <alsa-devel@alsa-project.org>; Thu, 27 Oct 2022 15:37:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 77A0AF80496
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 902CB62308;
 Thu, 27 Oct 2022 13:37:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C06C4347C;
 Thu, 27 Oct 2022 13:37:21 +0000 (UTC)
Date: Thu, 27 Oct 2022 09:37:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] ALSA: Use del_timer_sync() before freeing timer
Message-ID: <20221027093736.1e8cc9b9@gandalf.local.home>
In-Reply-To: <87pmedojfv.wl-tiwai@suse.de>
References: <20221026231236.6834b551@gandalf.local.home>
 <87pmedojfv.wl-tiwai@suse.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, Stephen Boyd <sboyd@kernel.org>,
 Takashi Iwai <tiwai@suse.com>, LKML <linux-kernel@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Guenter Roeck <linux@roeck-us.net>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Thu, 27 Oct 2022 08:43:32 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> Applied now with the fix of unused variable warning.

Thanks Takashi!

-- Steve
