From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: 2.6.17rc emu10k1 regression.
Date: Sun, 28 May 2006 17:51:12 +0100
Message-ID: <4479D500.2060305@superbug.co.uk>
References: <20060528164015.GA13499@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from anchor-post-32.mail.demon.net (anchor-post-32.mail.demon.net
	[194.217.242.90])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 09738183
	for <alsa-devel@alsa-project.org>;
	Sun, 28 May 2006 18:51:13 +0200 (MEST)
In-Reply-To: <20060528164015.GA13499@redhat.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Dave Jones <davej@redhat.com>, alsa-devel@alsa-project.org, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Dave Jones wrote:
> $ lspci  | grep audio
> 00:1f.5 Multimedia audio controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) AC'97 Audio Controller (rev 02)
> 06:0d.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 04)
> 
> (That's 06:0d.1 0980: 1102:7002 (rev 01))
> 
> This worked fine in 2.6.16, however when I try a .17rc kernel I get this..
> 
> cannot find the slot for index 0 (range 0-1)
> EMU10K1_Audigy: probe of 0000:06:0d.0 failed with error -12
> 
> (Unremarkable, considering it *isn't* an Audigy)
> 
> 

The same driver is used for the EMU10K1 and the Prodigy.
the -12 is an "Out of memory", so something outside the alas driver tree
must have changed to cause this problem.

James
