From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add National Semiconductor LM49352
 Audio Codec support
Date: Mon, 7 Mar 2011 13:18:14 +0000
Message-ID: <20110307131814.GJ13471@opensource.wolfsonmicro.com>
References: <290463D19D2E064191F1F96ECA480A89432CB6D84E@EXMAIL02.scwf.nsc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 37F6E1038B9
	for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2011 14:18:17 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <290463D19D2E064191F1F96ECA480A89432CB6D84E@EXMAIL02.scwf.nsc.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Reddy, MR Swami" <MR.Swami.Reddy@nsc.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 07, 2011 at 04:03:55AM -0800, Reddy, MR Swami wrote:

Please fix your MUA to word wrap within paragraphs at less than 80
columns.  I've reflowed your mail for legibility.  There are some
suggestions in Documentation/email-clients.txt.

> Patch for adding National Semiconductor LM49352 Audio Codec (http://www.national.com/ds/LM/LM49352.pdf) support along with Samsung_6410 (i.e. SMDK6410) platform support for LM49352. 

> [Tested this patch on SMDK6410 platform with Kernel- 2.6.24 and ALSA version is - 1.0.15].

> Please review and let me know the comments/suggestion on this patch. 

You need to follow the standard kernel patch submission process, which
is documented in Documentation/SubmittingPatches.  In particular you
should:

 - Conform to the coding standards in CodingStandards (checkpatch.pl is 
   helpful for detecting obvious issues).  A good high level check is if
   your code should visually resemble the rest of the code base.
 - Submit your code against the current development kernel version.  The
   trees will be listed in MAINTAINERS, or -next is a good approximation.
 - Send your patch in-line rather than as an attachment.
 - Send your patch against the full Linux tree, not a subdirectory of
   it.

You should also split your code up into a series of independant patches
- in general each individual driver should be a single patch so your
machine and CODEC drivers should be split up.  If the machine driver is
just for a flying wire system you should remove it, otherwise please
also submit the arch/arm parts.

I've not done a detailed review of the code due to the above high level
issues.

> And also let me know the forward-porting (to the latest ALSA version APIs) steps/process. Thanks in advance.

You need to figure out a process that works for you.  In general
inspecting the kernel history is usually very useful for stuff like
this, or you could just start from scratch and copy over the active bits
of code.
