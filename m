From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: 2.6.26.[6|7]-rt11, alsa rawmidi, seq hang
Date: Fri, 07 Nov 2008 10:37:58 +0100
Message-ID: <49140C76.4070300@ladisch.de>
References: <1226019485.3135.31.camel@localhost.localdomain>
	<49140683.9040008@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 50DA42413F
	for <alsa-devel@alsa-project.org>; Fri,  7 Nov 2008 10:38:02 +0100 (CET)
In-Reply-To: <49140683.9040008@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: Takashi Iwai <tiwai@suse.de>, Ingo Molnar <mingo@elte.hu>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

I wrote:
> I vaguely remember that we had exactly the same problem (hangs when
> using sequencer on RT kernel) some time ago, and that it was somehow
> related to tasklets.

http://lkml.org/lkml/2006/3/7/256
