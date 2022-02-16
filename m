Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE2BC433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Feb 2022 16:28:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 678181A98;
	Wed, 16 Feb 2022 17:27:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 678181A98
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1645028923;
	bh=j8dV14i1eoNfCK4Fl8Sr3o1HodSN1gCVTU0IMDEUr6M=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=B8kGxilsbALhDYZ0w/nMD+HQSDJgAsU9dPmSR7qb5xC+W7VgktlhUmRN0f6i0BsWX
	 x6lH9DEO48Qvu0f0Z+0N2qT+NL00bLDenSbJlHtfgk0qWj24dPn/zmd+FxFlKfmbNy
	 5TwXGd/DARCgTdxMJ4jRmh2sUe4SdP08LiitTP1A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DB304F8011C;
	Wed, 16 Feb 2022 17:27:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BBDBBF800C0; Wed, 16 Feb 2022 17:27:50 +0100 (CET)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8F034F800C0
 for <alsa-devel@alsa-project.org>; Wed, 16 Feb 2022 17:27:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8F034F800C0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=axis.com header.i=@axis.com
 header.b="VYA6F/LO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis.com; q=dns/txt; s=axis-central1; t=1645028866;
 x=1676564866; h=date:from:to:subject:message-id:mime-version;
 bh=q3D8fqL2IRSQkeJFL+oSAZfd2OFZuCFrRPaM5AWuSGs=;
 b=VYA6F/LOLw6/DXc3rVzaUXhpFUowq9+su2Sl6CGqJUYkYZR/glJ9GKl4
 kPV+iiYOnjZ1Q1c0Ni4mHsOblWdP2Iz7psILtBtQ5IhJb+HkGISMVIwia
 iMr+Z7CT6fmIgwmybObKp5yluFvKN821SKQIqdO3bCq+pL+a8MQRELl+j
 Z6zjNL0VYxmsyOvunrlieZoyfRXeGvs6aUBVToNQV8j7HsfCdaOgd4d3U
 FTXD7r6d1aBA2Dxspy5D5MmI6WCmzVByh2CzQ5ft44xXnK7QphcLcSaQP
 ddktNzlNhQ+V6yzdh3zfxikfPcKr5rezlRcwIuX280pwD4y40gbJ/uEJH w==;
Date: Wed, 16 Feb 2022 17:27:34 +0100
From: Ricard Wanderlof <ricardw@axis.com>
X-X-Sender: ricardw@lnxricardw1.se.axis.com
To: alsa-devel <alsa-devel@alsa-project.org>
Subject: Multiple codecs of the same type on the same card
Message-ID: <alpine.DEB.2.21.2202161722560.17949@lnxricardw1.se.axis.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail07w.axis.com
 (10.20.40.13)
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


When adding codecs to a card, all the controls of each individual codec 
are visible as controls for the complete card. But how does one handle the 
case of multiple codecs of the same type, for instance two identical 
codecs being used in TDM mode to create a multi channel card? Is there 
some method for resolving the fact that the control names naturally 
conflict?

Or is this expected to be resolved in the machine driver? Currently I've 
been using simple-card, but perhaps this type of configuration is too 
advanced to be resolved for that, and a specialized machine driver is 
needed?

/Ricard
-- 
Ricard Wolf Wanderlof                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
