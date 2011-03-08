From: "Reddy, MR Swami" <MR.Swami.Reddy@nsc.com>
Subject: Re: [PATCH] ASoC: Add National Semiconductor LM49352
 Audio Codec support
Date: Mon, 7 Mar 2011 20:31:24 -0800
Message-ID: <290463D19D2E064191F1F96ECA480A89432CB6DE88@EXMAIL02.scwf.nsc.com>
References: <290463D19D2E064191F1F96ECA480A89432CB6D84E@EXMAIL02.scwf.nsc.com>
	<20110307131814.GJ13471@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sc-mailgw03.nsc.com (mail6.nsc.com [12.24.21.242])
	by alsa0.perex.cz (Postfix) with ESMTP id 14932244C6
	for <alsa-devel@alsa-project.org>; Tue,  8 Mar 2011 05:31:50 +0100 (CET)
Received: from SCNTRDCSS8.nsc.com (scntrdcss8.nsc.com [10.188.130.179])
	by sc-mailgw03.nsc.com (Tumbleweed MailGate 3.7.1) with ESMTP id
	288BC13ABC2A
	for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2011 20:31:45 -0800 (PST)
In-Reply-To: <20110307131814.GJ13471@opensource.wolfsonmicro.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Thank you very much for your feedback. I will update the patch as per the comments and submit the update patch for review.

Thanks
Swami

-----Original Message-----
From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com] 
Sent: Monday, March 07, 2011 6:48 PM
To: Reddy, MR Swami
Cc: alsa-devel@alsa-project.org; Liam Girdwood
Subject: Re: [PATCH] ASoC: Add National Semiconductor LM49352 Audio Codec support

On Mon, Mar 07, 2011 at 04:03:55AM -0800, Reddy, MR Swami wrote:

Please fix your MUA to word wrap within paragraphs at less than 80 columns.  I've reflowed your mail for legibility.  There are some suggestions in Documentation/email-clients.txt.

> Patch for adding National Semiconductor LM49352 Audio Codec (http://www.national.com/ds/LM/LM49352.pdf) support along with Samsung_6410 (i.e. SMDK6410) platform support for LM49352. 

> [Tested this patch on SMDK6410 platform with Kernel- 2.6.24 and ALSA version is - 1.0.15].

> Please review and let me know the comments/suggestion on this patch. 

You need to follow the standard kernel patch submission process, which is documented in Documentation/SubmittingPatches.  In particular you
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
- in general each individual driver should be a single patch so your machine and CODEC drivers should be split up.  If the machine driver is just for a flying wire system you should remove it, otherwise please also submit the arch/arm parts.

I've not done a detailed review of the code due to the above high level issues.

> And also let me know the forward-porting (to the latest ALSA version APIs) steps/process. Thanks in advance.

You need to figure out a process that works for you.  In general inspecting the kernel history is usually very useful for stuff like this, or you could just start from scratch and copy over the active bits of code.
