From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: ASoC: Intel: Add Haswell/Broadwell IPC
Date: Tue, 25 Feb 2014 11:34:32 +0300
Message-ID: <20140225083432.GA5023@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by alsa0.perex.cz (Postfix) with ESMTP id 94A4326517F
 for <alsa-devel@alsa-project.org>; Tue, 25 Feb 2014 09:34:26 +0100 (CET)
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
To: liam.r.girdwood@linux.intel.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Liam Girdwood,

The patch 22981243589c: "ASoC: Intel: Add Haswell/Broadwell IPC" from
Feb 20, 2014, leads to the following imaginary static checker warning:

	sound/soc/intel/sst-haswell-ipc.c:898 hsw_irq_thread()
	warn: this is always true.

sound/soc/intel/sst-haswell-ipc.c
   895                  /* Handle Immediate reply from DSP Core */
   896                  handled = hsw_process_reply(hsw, ipcx);
                                  ^^^^^^^^^^^^^^^^^
Returns 1 on success/error and -EIO on error.

   897  
   898                  if (handled) {
   899                          /* clear DONE bit - tell DSP we have completed */
   900                          sst_dsp_shim_update_bits_unlocked(sst, SST_IPCX,
   901                                  SST_IPCX_DONE, 0);
   902  
   903                          /* unmask Done interrupt */
   904                          sst_dsp_shim_update_bits_unlocked(sst, SST_IMRX,
   905                                  SST_IMRX_DONE, 0);
   906                  }

regards,
dan carpenter
