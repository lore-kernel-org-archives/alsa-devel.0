From: saeed bishara <saeed.bishara@gmail.com>
Subject: Re: [patch 0/6] kirkwood openrd client audio support
Date: Wed, 12 May 2010 06:47:36 +0000 (UTC)
Message-ID: <loom.20100512T084431-320@post.gmane.org>
References: <20100511162342.640158675@mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id CF8172494A
	for <alsa-devel@alsa-project.org>;
	Wed, 12 May 2010 08:50:03 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1OC5lb-0003LU-CZ
	for alsa-devel@alsa-project.org; Wed, 12 May 2010 08:50:03 +0200
Received: from galiil.marvell.com ([199.203.130.254])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 12 May 2010 08:50:03 +0200
Received: from saeed.bishara by galiil.marvell.com with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 12 May 2010 08:50:03 +0200
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

 <apatard <at> mandriva.com> writes:

> 
> 
> This patchset aims at adding ASoC support to ARM kirkwood systems and
> more precisely to openrd client boards.
> 
> Arnaud Patard
> 

Hi Arnaud,
   this i2s controller was first added into the Orion-1-90 (88F6183), and also
it's found on dove soc. so can you please rename to orion to make more generic?

saeed
