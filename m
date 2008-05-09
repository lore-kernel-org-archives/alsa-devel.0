From: Rene Herman <rene.herman@keyaccess.nl>
Subject: 2.6.26-rc1 regression: ISA DMA broken (bisected)
Date: Fri, 09 May 2008 03:37:54 +0200
Message-ID: <4823AAF2.7070102@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 6858D2487E
	for <alsa-devel@alsa-project.org>;
	Fri,  9 May 2008 03:36:54 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Glauber Costa <gcosta@redhat.com>
Cc: ALSA devel <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>, Pete Clements <clem@clem.clem-digital.net>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
List-Id: alsa-devel@alsa-project.org

Good day.

commit 8779f2fc3b84ebb6c5181fb13d702e9944c16069

"x86: don't try to allocate from DMA zone at first"

breaks all of ISA DMA. Or all of ALSA ISA DMA at least. All
ISA soundcards are silent following that commit -- no error
messages, everything appears fine, just silence.

It won't just revert due to 32/64 merge.

Rene.
