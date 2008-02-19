From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: Re: Maya44 revised patch
Date: Tue, 19 Feb 2008 16:25:03 +0100
Message-ID: <47BAF4CF.50208@insite.cz>
References: <47B37EE7.5000905@lightshed.de>	<s5hpruzycbo.wl%tiwai@suse.de>	<47B4340C.1030106@insite.cz>	<s5hir0ryauz.wl%tiwai@suse.de>
	<47B474F0.6050203@lightshed.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from prague.insite.cz (r3g29.net.upc.cz [213.220.198.29])
	by alsa0.perex.cz (Postfix) with ESMTP id 7FFC5245EB
	for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2008 16:25:11 +0100 (CET)
In-Reply-To: <47B474F0.6050203@lightshed.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rainer Zimmermann <mail@lightshed.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Rainer Zimmermann napsal(a):

.........
> Yes, so far the driver is stable on my system (2.6.22) and on Piotr's, but I
> would still consider it experimental. It still contains experimental code and
> some experimental controls, and I guess there should be more testing, in
> particular the MI/ODI/O and SPDIF part is still untested.
> Well, your decision...

The Juli@ support I am working on requires some major changes to 
ice1724.c in the rate-setting code, to make it custumizable for 
individual cards. Since I do not want to resolve the conflicts the 
commit would inflict to my to-be-coded version, please let me know your 
next plans with ice1724.c. I would start after the commit.

Thanks a lot,

Pavel.
