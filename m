From: Geoffrey McRae <geoff@spacevs.com>
Subject: Re: ASUS Phoebus (CMI8888) HDA Support
Date: Thu, 5 Dec 2013 09:20:59 +1100
Message-ID: <20131205092059.52bd39f7@sarah.home.spacevs.com>
References: <20131204213613.31b9a9c9@sarah.home.spacevs.com>
 <529F098C.3020208@ladisch.de>
 <20131204215711.68b52af6@sarah.home.spacevs.com>
 <529F1890.6070003@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.spacevs.com (mail1.spacevs.com [202.174.111.252])
 by alsa0.perex.cz (Postfix) with ESMTP id B0D3426548B
 for <alsa-devel@alsa-project.org>; Wed,  4 Dec 2013 23:21:02 +0100 (CET)
In-Reply-To: <529F1890.6070003@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Interestingly I added some code to dump out the DMA addresses used and
checked it with and without IOMMU:

Without:
DMA: AREA = ffff8800dd44b000, ADDR = dd44b000

With:
DMA: AREA = ffff8803ecf15000, ADDR = 68000

Here are the registers while the device is working (with IOMMU):

      GCAP: 0x4300
      VMIN: 0x00
      VMAJ: 0x01
     INPAY: 0x0048
    OUTPAY: 0x0054
      GCTL: 0x00000101
    WAKEEN: 0x0000
   STATSTS: 0x0000
      GSTS: 0x0000
OUTSTRMPAY: 0x0030
 INSTRMPAY: 0x001d
    INTCTL: 0xc0000000
    INTSTS: 0x00000000
    WALCLK: 0xb4bdefba
 CORBLBASE: 0x00068000
 CORBUBASE: 0x00000000
    CORBWP: 0x00ad
    CORBRP: 0x00ad
   CORBCTL: 0x02
   CORBSTS: 0x00
  CORBSIZE: 0x42
 RIRBLBASE: 0x00068800
 RIRBUBASE: 0x00000000
    RIRBWP: 0x00ad
   RINTCNT: 0x0001
   RIRBCTL: 0x03
   RIRBSTS: 0x00
  RIRBSIZE: 0x42
      ICOI: 0x00000000
      ICII: 0x00000000
      ICIS: 0x0002
 DPIBLBASE: 0x00000000
 DPIULBASE: 0x00000000

CORBLBASE gets set to dd44b000, and RIRBLBASE gets set to dd44b800 when
it is without IOMMU as one would expect.

But... it is not 128bit aligned as per the HD Audio Spec.

Windows uses a DMA address of 0xdd4d0000, which is 128bit aligned. I
will do some more hacking and see if I can figure out how to give it an
aligned DMA buffer.
