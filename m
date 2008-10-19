From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: 20K1 PCI bars, and mode switching info.
Date: Sun, 19 Oct 2008 17:23:20 +0100
Message-ID: <48FB5EF8.10505@superbug.co.uk>
References: <48FB5B2C.3030008@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anchor-post-32.mail.demon.net (anchor-post-32.mail.demon.net
	[194.217.242.90])
	by alsa0.perex.cz (Postfix) with ESMTP id C86C12449A
	for <alsa-devel@alsa-project.org>;
	Sun, 19 Oct 2008 18:23:43 +0200 (CEST)
Received: from superbug.demon.co.uk ([80.176.146.252] helo=[192.168.0.10])
	by anchor-post-32.mail.demon.net with esmtp (Exim 4.67)
	id 1Krb3t-0006Nl-9S
	for alsa-devel@alsa-project.org; Sun, 19 Oct 2008 16:23:26 +0000
In-Reply-To: <48FB5B2C.3030008@superbug.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

James Courtier-Dutton wrote:
> To switch from UAA mode to 20K1 mode write each DW value: CTLX, CTL-,
> CTLF, CTLi
Here is the pseudo code:

WriteMemory((bar0 + 0x00003ffc),0x43544c58);  // CTLX
WriteMemory((bar0 + 0x00003ffc),0x43544c2d);  // CTL-
WriteMemory((bar0 + 0x00003ffc),0x43544c46);  // CTLF
WriteMemory((bar0 + 0x00003ffc),0x43544c69);  // CTLi
