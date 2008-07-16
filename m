From: dinesh <dinesh.dua@coraltele.com>
Subject: WRITING AN SOC DRIVER WITHOUT DMA
Date: Wed, 16 Jul 2008 14:35:30 +0530
Message-ID: <1216199130.749.4.camel@dinesh.dua>
References: <20080712083929.15025.47682.stgit@trillian.secretlab.ca>
	<20080712083939.15025.31192.stgit@trillian.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.coraltele.com (unknown [122.160.64.235])
	by alsa0.perex.cz (Postfix) with ESMTP id B993E243FF
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Jul 2008 11:07:44 +0200 (CEST)
In-Reply-To: <20080712083939.15025.31192.stgit@trillian.secretlab.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, liam.girdwood@wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Hi,
I am writing a soc sound driver for MPC8323 board linux 2.6.24 in which i want to do data transfer to and from device myself using BUFFER DESCRIPTOR not with the usual DMA transfer.
Please help me.
