From: PgmHelmi <pgmhelmi@tele2.at>
Subject: Re: Different returns from snd_pcm_readi() in differen
 versions from ALSA driver
Date: Thu, 11 Nov 2010 09:33:04 +0100
Message-ID: <4CDBAA40.3060603@tele2.at>
References: <4CD81FEB.3090100@tele2.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from swip.net (mailfe07.tele2.at [212.247.154.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 81B321037EE
	for <alsa-devel@alsa-project.org>; Thu, 11 Nov 2010 09:33:25 +0100 (CET)
Received: from [86.33.9.184] (account cxu-94p-73t@tele2.at HELO [192.168.1.3])
	by mailfe07.swip.net (CommuniGate Pro SMTP 5.2.19)
	with ESMTPA id 47511027 for alsa-devel@alsa-project.org;
	Thu, 11 Nov 2010 09:33:24 +0100
In-Reply-To: <4CD81FEB.3090100@tele2.at>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi!

Has at least somebody a hint for us, where we can find a solution for 
our problem? We searched already in mailing list and internet but could 
not found something fitting. And the list of release changes is very 
long and descriptions are not always very clear.

Kind regards


PgmHelmi schrieb:
> Hi!
> 
> We had to write a driver for audio playing and recording on Linux thin 
> clients. We are using ALSA driver + libs for it, but we are
> depending on the versions which are installed on them.
> 
> We have a certain buffer size for this and set the corresponding 
> hardware and software parameters and call for capture
> snd_pcm_readi(). The function returns the read buffer frames. In most 
> versions this is equal to the number of wanted passed frames, but
> not in all. We have ALSA driver version 1.0.15 and 1.0.22.1 where the 
> returned number is the same. But we have also version 1.0.21
> where the returned number is the period size or a multiple of it.
> 
> So conclusion is, that something was changed between 1.0.15 and 1.0.21 
> and changed back till 1.0.22.1. As we are dependent on the
> behaviour of the former and newer version, my question is, if there is a 
> possibility to get the same behaviour in version 1.0.21?
> 
> Thank you for your answer in advance!
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
