From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC 3/4] ASoC: Intel: add the low level dsp
 driver for mrfld
Date: Wed, 7 May 2014 12:55:21 +0530
Message-ID: <20140507072521.GL28638@intel.com>
References: <1399312908-20744-1-git-send-email-vinod.koul@intel.com>
 <1399312908-20744-4-git-send-email-vinod.koul@intel.com>
 <5369CE28.5010904@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C0612652B7
 for <alsa-devel@alsa-project.org>; Wed,  7 May 2014 09:38:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <5369CE28.5010904@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.jf.intel.com>
Cc: jeeja.kp@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Wed, May 07, 2014 at 09:09:44AM +0300, Jarkko Nikula wrote:
> On 05/05/2014 09:01 PM, Vinod Koul wrote:
> >+++ b/sound/soc/intel/sst/sst.h
> ...
> >+
> >+/* SST register map */
> >+#define SST_CSR			0x00
> >+#define SST_PISR		0x08
> >+#define SST_PIMR		0x10
> >+#define SST_ISRX		0x18
> >+#define SST_ISRD		0x20
> >+#define SST_IMRX		0x28
> >+#define SST_IMRD		0x30
> >+#define SST_IPCX		0x38 /* IPC IA-SST */
> >+#define SST_IPCD		0x40 /* IPC SST-IA */
> >+#define SST_ISRSC		0x48
> >+#define SST_ISRLPESC		0x50
> >+#define SST_IMRSC		0x58
> >+#define SST_IMRLPESC		0x60
> >+#define SST_IPCSC		0x68
> >+#define SST_IPCLPESC		0x70
> >+#define SST_CLKCTL		0x78
> >+#define SST_CSR2		0x80
> Please re-use register definitions in sound/soc/intel/sst-dsp.h
> since they are the same.
Sure will add reuse that one..

-- 
~Vinod
