From: Ralf Baechle <ralf@linux-mips.org>
Subject: [RFC] Remove Alchemy OSS drivers?
Date: Fri, 20 May 2011 00:19:12 +0100
Message-ID: <20110519231911.GB10628@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: linux-mips@linux-mips.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Namhyung Kim <namhyung@gmail.com>, Man
List-Id: alsa-devel@alsa-project.org

OSS has very little if any useful life in it left for MIPS, at least from
my perspective.  So I propose to remove the Au1550 driver - there is an
ALSA replacement for it available.

Anybody against it?  Are there still any remaining features or platforms
that are only supported by the OSS driver?

The OSS code is so backwards that I'd like to retire the possible remaining
MIPS users and then make OSS unavailable in Kconfig for MIPS.

  Ralf
