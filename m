From: "Pekka Enberg" <penberg@cs.helsinki.fi>
Subject: Re: [BUG] Linux 2.6.20.1 - unable to handle kernel
	paging request - accessing freed memory?
Date: Tue, 27 Feb 2007 16:48:25 +0200
Message-ID: <84144f020702270648o32fb15dfg4267f0cb5b50454a@mail.gmail.com>
References: <s5h7iu4heun.wl%tiwai@suse.de>
	<797678.74613.qm@web52901.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.191])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 367AC29D
	for <alsa-devel@alsa-project.org>; Tue, 27 Feb 2007 15:48:37 +0100 (MET)
Received: by nf-out-0910.google.com with SMTP id n29so190138nfc
	for <alsa-devel@alsa-project.org>; Tue, 27 Feb 2007 06:48:36 -0800 (PST)
In-Reply-To: <797678.74613.qm@web52901.mail.yahoo.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Chris Rankin <rankincj@yahoo.com>
Cc: Takashi Iwai <tiwai@suse.de>, Randy Dunlap <randy.dunlap@oracle.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 2/27/07, Chris Rankin <rankincj@yahoo.com> wrote:
> Hmm, this bug looks interesting:
>
> http://www.ussg.iu.edu/hypermail/linux/kernel/0702.3/0514.html
>
> Yes, my machine *is* a dual P4 with HT enabled...

Yeah, but the oops looks more like a reference counting problem with
sysfs dentries. No harm in trying out the patch or reproducing without
CONFIG_SCHED_SMT though.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
