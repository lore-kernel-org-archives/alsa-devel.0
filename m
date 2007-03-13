From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [SOUND] hda_intel: build fix
Date: Tue, 13 Mar 2007 12:42:48 +0000
Message-ID: <20070313124248.GA25963@linux-mips.org>
References: <20070310190513.GA24435@linux-mips.org>
	<s5h8xe2soxt.wl%tiwai@suse.de>
	<20070312135351.GA11974@linux-mips.org>
	<s5hzm6ijzep.wl%tiwai@suse.de>
	<20070312154647.GC11974@linux-mips.org>
	<s5hodmyju1w.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from ftp.linux-mips.org (ftp.linux-mips.org [194.74.144.162])
	by alsa0.perex.cz (Postfix) with ESMTP id 87F9C246A8
	for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2007 13:44:43 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:8670 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022271AbXCMMon (ORCPT <rfc822;alsa-devel@alsa-project.org>);
	Tue, 13 Mar 2007 12:44:43 +0000
Content-Disposition: inline
In-Reply-To: <s5hodmyju1w.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, alsa-devel@alsa-project.org, perex@suse.cz, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

> Ah, that's a nasty part of C const.  It should be like
> 	const struct snd_ice1712_card_info *c;
> but for pointer-of-pointer, something like
> 	struct snd_ice1712_card_info * const *tbl;

Well, that works.

Andrew, I'm going to post an updated patch in separate email.

  Ralf

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
