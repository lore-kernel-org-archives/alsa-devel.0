From: Ralf Baechle <ralf@linux-mips.org>
Subject: [RFC] Remove Alchemy OSS drivers?
Date: Fri, 20 May 2011 00:22:21 +0100
Message-ID: <20110519232221.GC10628@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from duck.linux-mips.net (h5.dl5rb.org.uk [81.2.74.5])
	by alsa0.perex.cz (Postfix) with ESMTP id B3ABA24466
	for <alsa-devel@alsa-project.org>;
	Fri, 20 May 2011 01:22:21 +0200 (CEST)
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
To: linux-mips@linux-mips.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Namhyung Kim <namhyung@gmail.com>, Manuel Lauss <manuel.lauss@g>
List-Id: alsa-devel@alsa-project.org

OSS has very little if any useful life in it left for MIPS, at least from
my perspective.  So I propose to remove the Au1550 driver - there is an
ALSA replacement for it available.

Anybody against it?  Are there still any remaining features or platforms
that are only supported by the OSS driver?

The OSS code is so backwards that I'd like to retire the possible remaining
MIPS users and then make OSS unavailable in Kconfig for MIPS.

  Ralf
