From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: old bug in au88x0_core.c
Date: Mon, 27 Jun 2016 16:03:47 +0300
Message-ID: <20160627130346.GA6787@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by alsa0.perex.cz (Postfix) with ESMTP id 7885E265881
 for <alsa-devel@alsa-project.org>; Mon, 27 Jun 2016 15:03:59 +0200 (CEST)
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
 by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id
 u5RD3tS1032529
 (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
 for <alsa-devel@alsa-project.org>; Mon, 27 Jun 2016 13:03:56 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserv0021.oracle.com (8.13.8/8.13.8) with ESMTP id u5RD3t8c016779
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
 for <alsa-devel@alsa-project.org>; Mon, 27 Jun 2016 13:03:55 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
 by userv0121.oracle.com (8.13.8/8.13.8) with ESMTP id u5RD3sZT018336
 for <alsa-devel@alsa-project.org>; Mon, 27 Jun 2016 13:03:54 GMT
Content-Disposition: inline
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

Hi ALSA devs,

The patch 1da177e4c3f4: "Linux-2.6.12-rc2" from Apr 16, 2005, leads
to the following static checker warning:

	sound/pci/au88x0/au88x0_core.c:1449 vortex_wtdma_bufshift()
	warn: mask and shift to zero

sound/pci/au88x0/au88x0_core.c
  1441  static int vortex_wtdma_bufshift(vortex_t * vortex, int wtdma)
  1442  {
  1443          stream_t *dma = &vortex->dma_wt[wtdma];
  1444          int page, p, pp, delta, i;
  1445  
  1446          page =
  1447              (hwread(vortex->mmio, VORTEX_WTDMA_STAT + (wtdma << 2)) &
  1448               WT_SUBBUF_MASK)
  1449              >> WT_SUBBUF_SHIFT;

This is always zero because:

#define WT_SUBBUF_MASK 0x3
#define WT_SUBBUF_SHIFT 0x15

  1450          if (dma->nr_periods >= 4)
  1451                  delta = (page - dma->period_real) & 3;
  1452          else {
  1453                  delta = (page - dma->period_real);
  1454                  if (delta < 0)
  1455                          delta += dma->nr_periods;
  1456          }
  1457          if (delta == 0)
  1458                  return 0;


  1493  #if 0
  1494  static void
  1495  vortex_wtdma_getposition(vortex_t * vortex, int wtdma, int *subbuf, int *pos)
  1496  {
  1497          int temp;
  1498          temp = hwread(vortex->mmio, VORTEX_WTDMA_STAT + (wtdma << 2));
  1499          *subbuf = (temp >> WT_SUBBUF_SHIFT) & WT_SUBBUF_MASK;

>From this ifdef zero code, it looks like we should shift first then do
the mask.

  1500          *pos = temp & POS_MASK;
  1501  }
  1502  
  1503  static int vortex_wtdma_getcursubuffer(vortex_t * vortex, int wtdma)
  1504  {
  1505          return ((hwread(vortex->mmio, VORTEX_WTDMA_STAT + (wtdma << 2)) >>
  1506                   POS_SHIFT) & POS_MASK);
  1507  }
  1508  #endif


regards,
dan carpenter
