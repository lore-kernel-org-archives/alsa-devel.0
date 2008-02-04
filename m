From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: alsa-info.sh debugging script
Date: Mon, 4 Feb 2008 13:01:04 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0802041257040.8166@tm8103.perex-int.cz>
References: <200802022334.42705.wishie@wishie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id CFBA7243AE
	for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2008 13:01:05 +0100 (CET)
In-Reply-To: <200802022334.42705.wishie@wishie.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Travis Place <wishie@wishie.net>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sat, 2 Feb 2008, Travis Place wrote:

> Hi everyone,
> 
> I am new to this list, so be nice please :P
> 
> I am the author of the alsa-info.sh debugging script, and heard you may want 
> to use it within ALSA.. I have been speaking to Tobin, and he mentioned that 
> a few things may need to be added (like alsactl output).
> 
> I just want to get some ideas of things i can add, and if they should be 
> included automatically, or require a --with-alsactl (for example).
> 
> I have added the alsactl output to the script now, its included by default.. 
> Any other ideas/changes that need to be made ?

Hi,

	First, thank you for your contribution. I just played with script 
and added alsactl functionality, too. (Sorry for duplicate work.) Also, I 
made few other changes to show --help, --about, --update without 
/tmp/alsa-info.txt file processing.
	The alsa-info.sh is hosted in HG repository now available at:

http://hg.alsa-project.org/alsa/raw-file/tip/alsa-info.sh
http://hg.alsa-project.org/alsa/log/tip/alsa-info.sh

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
