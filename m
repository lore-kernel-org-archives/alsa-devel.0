From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [SOUND] hda_intel: build fix
Date: Mon, 12 Mar 2007 13:53:51 +0000
Message-ID: <20070312135351.GA11974__40902.2053624087$1173707843$gmane$org@linux-mips.org>
References: <20070310190513.GA24435@linux-mips.org>
	<s5h8xe2soxt.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from ftp.linux-mips.org (ftp.linux-mips.org [194.74.144.162])
	by alsa0.perex.cz (Postfix) with ESMTP id B0177244F9
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2007 14:55:54 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:4280 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022290AbXCLNzr (ORCPT <rfc822;alsa-devel@alsa-project.org>);
	Mon, 12 Mar 2007 13:55:47 +0000
Content-Disposition: inline
In-Reply-To: <s5h8xe2soxt.wl%tiwai@suse.de>
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

On Mon, Mar 12, 2007 at 12:04:30PM +0100, Takashi Iwai wrote:

> It's no big problem to remove const in these cases, but allowing const
> with __devinitdata seems the right fix to me...

Gccs derives the readability of a section used with __attribute(section())
from the first use, which in case of this driver was a non-const use, so
gcc made .init.data a r/w section.  Later uses were marked with const,
so did conflict.  Having to ensure that all members of a section are const
or are not const is painful, so this is clearly less than desirable
behaviour on gcc's side.  I think gcc picking the most permissive
attributes for a section, that is r/w in this case would be far preferable.

Here is a small test case btw:

int foo __attribute__ ((__section__ (".init.data"))) = 23;
const int bar __attribute__ ((__section__ (".init.data"))) = 42;

Now I'm not a great fan of the patch I've posted but it reflects what real
world gcc is doing so for the time being I don't see much of a chance to
The Right Thing (TM).  And the gain from const in this case will be small
anyway.

  Ralf

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
