From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: [1/2] 2.6.22-rc6: known regressions
Date: Mon, 25 Jun 2007 11:48:29 +0200
Message-ID: <467F8F6D.30801@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Sender: linux-ide-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>, Ben Collins <bcollins@ubuntu.com>, Rodrigo Luiz <troops.of.doom@gmail.com>, Rik van Riel <riel@surriel.com>, Hugh Dickins <hugh@veritas.com>, Petr Vandrovec <petr@vmware.com>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Rodney Gordon II <meff@spherevision.org>
List-Id: alsa-devel@alsa-project.org

Hi all,

Here is a list of some known regressions in 2.6.22-rc6.

Feel free to add new regressions/remove fixed etc.
http://kernelnewbies.org/known_regressions

*STATISTICS* (a.k.a. list of aces)

Name                    Regressions fixed since 21-Jun-2007
Andi Kleen                             1
Hugh Dickins                           1
Jean Delvare                           1



Unclassified

Subject    : Kernel hang on CMOS_READ
References : http://lkml.org/lkml/2007/6/3/138
Submitter  : Rodrigo Luiz <troops.of.doom@gmail.com>
Status     : Unknown



ALSA

Subject    : snd-aoa causes badness in lib/kref.c:33
References : http://bugzilla.kernel.org/show_bug.cgi?id=8513
Submitter  : Ben Collins <bcollins@ubuntu.com>
Handled-By : Takashi Iwai <tiwai@suse.de>
Status     : Unknown



Memory management

Subject    : 2.6.22-rc5-yesterdaygit with VM debug: BUG in mm/rmap.c:66: anon_vma_link ?
References : http://lkml.org/lkml/2007/6/25/45
Submitter  : Petr Vandrovec <petr@vmware.com>
Status     : unknown



SATA/PATA

Subject    : libata IT821X driver still fails! Hard-freezes system
References : http://lkml.org/lkml/2007/6/14/82
Submitter  : Rodney Gordon II <meff@spherevision.org>
Status     : unknown



Regards,
Michal

--
LOG
http://www.stardust.webpages.pl/log/
