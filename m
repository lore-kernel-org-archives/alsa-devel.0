From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: dmix format S24_LE
Date: Tue, 2 Mar 2010 14:03:56 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1003021402190.28127@eeebox2.perex-int.cz>
References: <4B8D0278.2040101@eia.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 1D76E10381F
	for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2010 14:03:58 +0100 (CET)
In-Reply-To: <4B8D0278.2040101@eia.be>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Bart De Vos <bart_dv@eia.be>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2 Mar 2010, Bart De Vos wrote:

> Hi,
>
> I've added support for the S24_LE format in the dmix plugin. This has
> been tested 'only' on i.MX31 (arm11) with sound DAC AK4367 over I2S,
> which supports this format natively.

I commited your changes (including the i386 architecture support) to the 
git tree:

http://git.alsa-project.org/?p=alsa-lib.git;a=commitdiff;h=7fd0d9f42357e49bc28259421de6338122381cb2

 					Thanks,
 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
