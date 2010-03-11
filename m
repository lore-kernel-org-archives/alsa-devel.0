From: ANISH KUMAR <anish.singh@samsung.com>
Subject: Re: underrun problem when short audio play
Date: Thu, 11 Mar 2010 05:27:44 +0000 (GMT)
Message-ID: <4832775.195611268285264233.JavaMail.weblogic@epml13>
Reply-To: anish.singh@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	by alsa0.perex.cz (Postfix) with ESMTP id 50758103871
	for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2010 06:27:52 +0100 (CET)
Received: from ep_ms13_bk (mailout2.samsung.com [203.254.224.25])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KZ300H8NR68ZJ@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Thu, 11 Mar 2010 14:27:44 +0900 (KST)
Received: from ep_spt01 (ms13.samsung.com [203.254.225.109])
	by ms13.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTP id <0KZ3004IYR68SN@ms13.samsung.com> for
	alsa-devel@alsa-project.org; Thu, 11 Mar 2010 14:27:44 +0900 (KST)
Content-return: prohibited
MIME-version: 1.0
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "ben@simtec.co.uk" <ben@simtec.co.uk>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "jkysela@redhat.com" <jkysela@redhat.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi All,
 
Just to add to my previous post.
This problem of underrun is happening towards the end of the short audio.
This causes unclear sound.This underrun is not happening with regular 
music (long duration audio).

ALSA version:1.0.18a
 
Regards,
anish
