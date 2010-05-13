From: "Andreas Falkenhahn" <andreas@airsoftsoftwair.de>
Subject: ALSA and Ubuntu addendum
Date: Thu, 13 May 2010 20:48:07 +0200
Message-ID: <39c504d92a024ec7179b0c55ceb3158f-EhVcX19FRQFfRwgeDBcNWRwwfgFLV15YQUBGAEFbWi9fXEYKW1loAFBWQ1peLkQAWFleR15RUA8=-webmailer2@server03.webmailer.hosteurope.de>
Reply-To: andreas@airsoftsoftwair.de
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perry.mc0.hosteurope.de (perry.mc0.hosteurope.de [80.237.138.8])
	by alsa0.perex.cz (Postfix) with ESMTP id 8D3A5243AC
	for <alsa-devel@alsa-project.org>;
	Thu, 13 May 2010 20:48:07 +0200 (CEST)
Received: from server03.webmailer.hosteurope.de ([10.9.0.182]);
	by mailout.hosteurope.de (perry.mc0.hosteurope.de) running EXperimental
	Internet Mailer with esmtps (TLSv1:AES256-SHA:256)
	id 1OCdTy-0000s4-65
	for alsa-devel@alsa-project.org; Thu, 13 May 2010 20:50:06 +0200
Received: from nobody by server03.webmailer.hosteurope.de with local (Exim
	4.69) (envelope-from <andreas@airsoftsoftwair.de>)
	id 1OCdS3-0007cJ-95
	for alsa-devel@alsa-project.org; Thu, 13 May 2010 20:48:07 +0200
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

Addendum:
I forgot one thing that doesn't work on Ubuntu either (but works on
openSUSE): PCM streams in signed 8 bit format have terrible sound
artefacts on Ubuntu. If I convert them to unsigned 8 bit format, they are
played correctly. But in signed format, it sounds totally broken.
