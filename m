From: Brian McNeil <brian.mcneil@wikinewsie.org>
Subject: Re: PCI: ICE1712 -- EDIROL2496DA support
Date: Wed, 24 Dec 2014 11:23:41 +0000
Message-ID: <4381949d0b2de599221179b591dddf4f@wikinewsie.org>
References: <1419093962-8789-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.vexxhost.net (mx1.vexxhost.net [162.253.52.232])
 by alsa0.perex.cz (Postfix) with ESMTP id 60F562608D3
 for <alsa-devel@alsa-project.org>; Wed, 24 Dec 2014 12:25:14 +0100 (CET)
Received: from node62.mtl.net.vexxhost.com ([199.204.44.226])
 by mx1.vexxhost.net with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.84) (envelope-from <brian.mcneil@wikinewsie.org>)
 id 1Y3k3u-00016z-Sk
 for alsa-devel@alsa-project.org; Wed, 24 Dec 2014 06:25:10 -0500
In-Reply-To: <1419093962-8789-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I've a pair of these, and seeing patches to the driver reminded me to 
bring up the subject of word-clock sync.

I've managed to get the clock-sync working sometimes; either using an 
inter-card jumper, or light pipe between breakout boxes. However, they 
do seem to go out of sync without warning, or readily-discerned reason.

I'm far from technically clueless, but driver development is 
well-outside my comfort zone. Happy to work on this off-list if someone 
wants to let me know what probing/interrogation of the cards is needed. 
Could - probably - sniff traffic between a Windows VM and the cards, if 
given pointers; yes, even if that involves building a kernel.


-- 
Brian McNeil
-- 
Wikinewsie.org | http://wikinewsie.org | https://en.wikinews.org
"Facts don't cease to be facts, but news ceases to be news."
GPG Fingerprint: 7C3D FFD5 5ED5 B80F 1D18 A52B E84C 8928 6ABC A7AD
