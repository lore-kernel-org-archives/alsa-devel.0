Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44BFFC433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Mar 2022 07:03:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 822D5171C;
	Mon, 14 Mar 2022 08:02:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 822D5171C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1647241399;
	bh=pZzaT3IA54NCzjk7vvt2GcBK5voMM481inTgGi/ulSA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=huZVOWntuIDdav9GnQcEWDFdx5wZYMgNSU2KkaduMJ578v6eIckJOGqdvYjK3SSYq
	 86fWVQQmn5zqrW23bpKFtdmoumTCp6Pqv+0YQhaaJw110yg6jUBAgEQfizFiF1PSVS
	 aUrn1Cxqzg9yXlzC0w6HMS6j0HnLfCm/P8PSdsho=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0FC1DF80552;
	Mon, 14 Mar 2022 07:59:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 508FBF80238; Fri, 11 Mar 2022 11:34:41 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 64000F80085
 for <alsa-devel@alsa-project.org>; Fri, 11 Mar 2022 11:34:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 64000F80085
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com
 header.b="iNIvX7qi"
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 79D72210FB;
 Fri, 11 Mar 2022 10:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1646994873; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wxQGvXlNGe5HCBbR63oBE/kK35uYM5cAEXtsbUcwkZQ=;
 b=iNIvX7qiHCHs8as2v0+a/C6Wf9AM41VW8O+o2xwFxi1cw2QRDGGMgZ/U+wVya50NqXLinC
 i0LxZhXeNa6Kvoq6FYdE1Rn7t/eAOn4geBVM9tpVaCf3Bq2EMzIQrENQGGyoxOfZbZapRr
 hZujw3UMlrZhO11g0/T3KzHa4Umc+Jk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A827013A85;
 Fri, 11 Mar 2022 10:34:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Kh3tJ7glK2LxdQAAMHmgww
 (envelope-from <jgross@suse.com>); Fri, 11 Mar 2022 10:34:32 +0000
From: Juergen Gross <jgross@suse.com>
To: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-integrity@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org,
 v9fs-developer@lists.sourceforge.net
Subject: [PATCH 0/2] xen/grant-table: do some cleanup
Date: Fri, 11 Mar 2022 11:34:27 +0100
Message-Id: <20220311103429.12845-1-jgross@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 14 Mar 2022 07:58:51 +0100
Cc: Latchesar Ionkov <lucho@ionkov.net>, alsa-devel@alsa-project.org,
 David Airlie <airlied@linux.ie>, Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 Peter Huewe <peterhuewe@gmx.de>, Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Jakub Kicinski <kuba@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Eric Van Hensbergen <ericvh@gmail.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 Jarkko Sakkinen <jarkko@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 "David S. Miller" <davem@davemloft.net>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
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

Cleanup grant table code by removing unused functionality.

Juergen Gross (2):
  xen/grant-table: remove gnttab_*transfer*() functions
  xen/grant-table: remove readonly parameter from functions

 drivers/block/xen-blkfront.c                |   8 +-
 drivers/char/tpm/xen-tpmfront.c             |   2 +-
 drivers/gpu/drm/xen/xen_drm_front_evtchnl.c |   2 +-
 drivers/input/misc/xen-kbdfront.c           |   4 +-
 drivers/net/xen-netfront.c                  |  13 +-
 drivers/pci/xen-pcifront.c                  |   2 +-
 drivers/scsi/xen-scsifront.c                |   4 +-
 drivers/usb/host/xen-hcd.c                  |   4 +-
 drivers/xen/gntalloc.c                      |   2 +-
 drivers/xen/gntdev-dmabuf.c                 |   2 +-
 drivers/xen/grant-table.c                   | 151 +++-----------------
 drivers/xen/pvcalls-front.c                 |   6 +-
 drivers/xen/xen-front-pgdir-shbuf.c         |   3 +-
 include/xen/grant_table.h                   |  13 +-
 net/9p/trans_xen.c                          |   8 +-
 sound/xen/xen_snd_front_evtchnl.c           |   2 +-
 16 files changed, 50 insertions(+), 176 deletions(-)

-- 
2.34.1

