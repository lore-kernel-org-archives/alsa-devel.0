From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: ASoC: Intel: sst: Add IPC handling
Date: Tue, 25 Nov 2014 12:20:31 +0300
Message-ID: <20141125092031.GA21784@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by alsa0.perex.cz (Postfix) with ESMTP id 516562604B6
 for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2014 10:20:46 +0100 (CET)
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
To: vinod.koul@intel.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Vinod Koul,

The patch ea12aa4acd70: "ASoC: Intel: sst: Add IPC handling" from Oct
16, 2014, leads to the following static checker warning:

	sound/soc/intel/sst/sst_ipc.c:340 sst_process_reply_mrfld()
	warn: we tested 'drv_id' before and it was 'true'

sound/soc/intel/sst/sst_ipc.c
   330          drv_id = msg_high.part.drv_id;
   331  
   332          /* Check for async messages first */
   333          if (drv_id == SST_ASYNC_DRV_ID) {
                              ^^^^^^^^^^^^^^^^
This is zero.

   334                  /*FW sent async large message*/
   335                  process_fw_async_msg(sst_drv_ctx, msg);
   336                  return;
   337          }
   338  
   339          /* FW sent short error response for an IPC */
   340          if (msg_high.part.result && drv_id && !msg_high.part.large) {
                                            ^^^^^^
So this is non-zero.  The thinking behind these warnings is that maybe
a different test was intended.  What does a non-zero drv_id mean which
is different from checking SST_ASYNC_DRV_ID?  The intent is not clear.

In other words, would it be more readable to test "drv_id != SST_ASYNC_DRV_ID"?
But in that case, we would just leave the test out since we obviously
tested for that earlier.

   341                  /* 32-bit FW error code in msg_low */
   342                  dev_err(sst_drv_ctx->dev, "FW sent error response 0x%x", msg_low);
   343                  sst_wake_up_block(sst_drv_ctx, msg_high.part.result,
   344                          msg_high.part.drv_id,
   345                          msg_high.part.msg_id, NULL, 0);
   346                  return;
   347          }
   348  

regards,
dan carpenter
