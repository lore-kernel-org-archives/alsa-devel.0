From: Adrian Bunk <bunk@stusta.de>
Subject: 2.6.21-rc4: known regressions with patches available
Date: Mon, 19 Mar 2007 21:39:43 +0100
Message-ID: <20070319203943.GZ752__18428.6083830104$1174337905$gmane$org@stusta.de>
References: <Pine.LNX.4.64.0703160925270.26106@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mailhub.stusta.mhn.de (mailout.stusta.mhn.de [141.84.69.5])
	by alsa0.perex.cz (Postfix) with ESMTP id 5454D24669
	for <alsa-devel@alsa-project.org>; Mon, 19 Mar 2007 21:39:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0703160925270.26106@woody.linux-foundation.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
Cc: Len Brown <len.brown@intel.com>, alsa-devel@alsa-project.org, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Oliver Neukum <oneukum@suse.de>, Ray Lee <ray-lk@madrabbit.org>, greg@kroah.com, linux-usb-devel@lists.sourceforge.net, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jim Radford <radford@blackbean.org>, linux-acpi@vger.kernel.org, perex@suse.cz, Takashi Iwai <tiwai@suse.de>, Mark Lord <lkml@rtr.ca>, Tomas Janousek <tomi@nomi.cz>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, Milan Broz <mbroz@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Thomas Meyer <thomas@m3y3r.de>, Colchao <colchaodemola@gmail.com>
List-Id: alsa-devel@alsa-project.org

Let's not bore people running -rc kernels with regressions that have 
patches available - let's get this patches into the tree for giving 
them the pure exciting experience of the many unfixed regressions.


This email lists some known regressions in Linus' tree compared to 2.6.20
with patches available.

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you caused a breakage or I'm considering you in any other way
possibly involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering.


Subject    : acpi_serialize locks system during boot
References : http://bugzilla.kernel.org/show_bug.cgi?id=8171
Submitter  : Colchao <colchaodemola@gmail.com>
Handled-By : Len Brown <len.brown@intel.com>
Patch      : http://bugzilla.kernel.org/show_bug.cgi?id=8171
Status     : patch available


Subject    : laptop immediately resumes after suspend
References : http://lkml.org/lkml/2007/3/8/469
Submitter  : Ray Lee <ray-lk@madrabbit.org>
Caused-By  : Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
             commit ed41dab90eb40ac4911e60406bc653661f0e4ce1
Handled-By : Len Brown <lenb@kernel.org>
Patch      : http://lkml.org/lkml/2007/3/12/228
Status     : patch available


Subject    : suspend/resume hangs (until keypress)  (CONFIG_NO_HZ)
References : http://bugzilla.kernel.org/show_bug.cgi?id=8181
             http://lkml.org/lkml/2007/3/11/112
Submitter  : Tomas Janousek <tomi@nomi.cz>
             Thomas Meyer <thomas@m3y3r.de>
             Milan Broz <mbroz@redhat.com>
Handled-By : Thomas Gleixner <tglx@linutronix.de>
Patch      : http://lkml.org/lkml/2007/3/16/406
Status     : patch available


Subject    : snd-intel8x0: no 3d surround sound
References : http://lkml.org/lkml/2007/3/5/164
Submitter  : Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Caused-By  : Randy Cushman <rcushman_linux@earthlink.net>
             commit 831466f4ad2b5fe23dff77edbe6a7c244435e973
Handled-By : Takashi Iwai <tiwai@suse.de>
Status     : patch available


Subject    : USB: Oops when connecting USB 1.1 docks
References : http://lkml.org/lkml/2007/3/4/266
Submitter  : Mark Lord <lkml@rtr.ca>
Caused-By  : Jim Radford <radford@blackbean.org>
             commit d9a7ecacac5f8274d2afce09aadcf37bdb42b93a
Handled-By : Oliver Neukum <oneukum@suse.de>
             Jim Radford <radford@blackbean.org>
Patch      : http://lkml.org/lkml/2007/3/13/217
Status     : patch available


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
