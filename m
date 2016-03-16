From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: ALSA: lx6464es - driver for the digigram lx6464es
	interface
Date: Wed, 16 Mar 2016 10:43:57 +0300
Message-ID: <20160316074357.GE12860@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by alsa0.perex.cz (Postfix) with ESMTP id 42D80261A0D
 for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2016 08:44:05 +0100 (CET)
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
To: tim@klingt.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Tim Blechmann,

The patch 02bec4904508: "ALSA: lx6464es - driver for the digigram
lx6464es interface" from Mar 24, 2009, leads to the following static
checker warning:

	sound/pci/lx6464es/lx_core.c:647 lx_pipe_wait_for_state()
	error: uninitialized symbol'current_state'.

sound/pci/lx6464es/lx_core.c
   612  int lx_pipe_state(struct lx6464es *chip, u32 pipe, int is_capture, u16 *rstate)
   613  {
   614          int err;
   615          u32 pipe_cmd = PIPE_INFO_TO_CMD(is_capture, pipe);
   616  
   617          mutex_lock(&chip->msg_lock);
   618          lx_message_init(&chip->rmh, CMD_0A_GET_PIPE_SPL_COUNT);
   619  
   620          chip->rmh.cmd[0] |= pipe_cmd;
   621  
   622          err = lx_message_send_atomic(chip, &chip->rmh);

lx_message_send_atomic() returns either negative error codes or a bit
mask.

   623  
   624          if (err != 0)
                    ^^^^^^^^

This code assumes that all non-zero values are errors which seems not
true since it could be a bit mask.

   625                  dev_err(chip->card->dev, "could not query pipe's state\n");
   626          else
   627                  *rstate = (chip->rmh.stat[0] >> PSTATE_OFFSET) & 0x0F;
   628  
   629          mutex_unlock(&chip->msg_lock);
   630          return err;
   631  }
   632  
   633  static int lx_pipe_wait_for_state(struct lx6464es *chip, u32 pipe,
   634                                    int is_capture, u16 state)
   635  {
   636          int i;
   637  
   638          /* max 2*PCMOnlyGranularity = 2*1024 at 44100 = < 50 ms:
   639           * timeout 50 ms */
   640          for (i = 0; i != 50; ++i) {
   641                  u16 current_state;
   642                  int err = lx_pipe_state(chip, pipe, is_capture, &current_state);
   643  
   644                  if (err < 0)
                            ^^^^^^^
This code assume that only negatives are errors.

   645                          return err;
   646  
   647                  if (current_state == state)
                            ^^^^^^^^^^^^^^^^^^^^^^
This is potentially slightly buggy because we returned a bit mask so we
didn't initialize it.  It not terribly harmful but the warning message
is annoying.

   648                          return 0;
   649  
   650                  mdelay(1);
   651          }
   652  
   653          return -ETIMEDOUT;
   654  }

regards,
dan carpenter
