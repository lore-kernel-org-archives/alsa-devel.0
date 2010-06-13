From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: BUG: cx88 can't find device struct
Date: Sun, 13 Jun 2010 16:01:54 +0200
Message-ID: <4C14E4D2.5090002@ladisch.de>
References: <!&!AAAAAAAAAAAYAAAAAAAAACQaAAE2cqNLuI5vSe3nryTCgAAAEAAAAPuor1woocFMmbldYCOiqTQBAAAAAA==@stahurabrenner.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 5E391244C1
	for <alsa-devel@alsa-project.org>;
	Sun, 13 Jun 2010 16:01:55 +0200 (CEST)
In-Reply-To: <!&!AAAAAAAAAAAYAAAAAAAAACQaAAE2cqNLuI5vSe3nryTCgAAAEAAAAPuor1woocFMmbldYCOiqTQBAAAAAA==@stahurabrenner.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Timothy E. Krantz" <tkrantz@stahurabrenner.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Timothy E. Krantz wrote:
> I download the alsa-driver-1.0.23.tar.bz file, unpack it, ./configure and
> make and make install.
>  
> If I then try to record an analog station I get:
>  
> Jun  9 14:40:19 mythdora kernel: BUG: cx88 can't find device struct. Can't proceed with open

The cx88 is not part of the ALSA driver package.

You have to recompile the entire kernel, where the new ALSA is part of
this kernel.  If you distribution doesn't have the latest released (or
beta) kernel, try a kernel snapshot from here (this requires git):
http://git.kernel.org/?p=linux/kernel/git/tiwai/sound-2.6.git;a=summary


HTH
Clemens
