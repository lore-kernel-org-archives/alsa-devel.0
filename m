From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: Re: [PATCH] Add initial support of Mitac mioa701
 master volume.
Date: Wed, 09 Jul 2008 11:59:18 +0100
Message-ID: <1215601158.4882.257.camel@localhost.localdomain>
References: <87vdzgp0ue.fsf@free.fr>
	<1215549906-14829-1-git-send-email-robert.jarzmik@free.fr>
	<1215549906-14829-2-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mimesweeper.wolfsonmicro.main (lumison.wolfsonmicro.com
	[87.246.78.27]) by alsa0.perex.cz (Postfix) with ESMTP id DFD6C24346
	for <alsa-devel@alsa-project.org>;
	Wed,  9 Jul 2008 12:59:26 +0200 (CEST)
Received: from orlando.wolfsonmicro.main (orlando.wolfsonmicro.main) by
	mimesweeper.wolfsonmicro.main (Clearswift SMTPRS 5.2.3) with ESMTP id
	<T8814197d64ac1408051700@mimesweeper.wolfsonmicro.main> for
	<alsa-devel@alsa-project.org>; Wed, 9 Jul 2008 11:59:27 +0100
In-Reply-To: <1215549906-14829-2-git-send-email-robert.jarzmik@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Tue, 2008-07-08 at 22:45 +0200, Robert Jarzmik wrote:
> Depending on the "Mio Mode" chosen, the master volume
> controls the widget volume/mute levels, providing userspace
> a unified vision of volume control (one control only).
> 

The userspace manager does the same thing here. I prefer the userspace
approach for the long term instead of this being handled differently by
each driver. It's in git atm though.  

Thanks

Liam


Privacy & Confidentiality Notice
-------------------------------------------------
This message and any attachments contain privileged and confidential information that is intended solely for the person(s) to whom it is addressed. If you are not an intended recipient you must not: read; copy; distribute; discuss; take any action in or make any reliance upon the contents of this message; nor open or read any attachment. If you have received this message in error, please notify us as soon as possible on the following telephone number and destroy this message including any attachments. Thank you.
-------------------------------------------------
Wolfson Microelectronics plc
Tel: +44 (0)131 272 7000
Fax: +44 (0)131 272 7001
Web: www.wolfsonmicro.com

Registered in Scotland

Company number SC089839

Registered office: 

Westfield House, 26 Westfield Road, Edinburgh, EH11 2QB, UK
