From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] slimbus: ngd: Add qcom SLIMBus NGD driver
Date: Tue, 7 Aug 2018 15:07:07 +0300
Message-ID: <20180807120707.3yjy6ggguk3frtrr@kili.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B3FC267865
 for <alsa-devel@alsa-project.org>; Tue,  7 Aug 2018 14:07:17 +0200 (CEST)
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
To: srinivas.kandagatla@linaro.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Srinivas Kandagatla,

This is a semi-automatic email about new static checker warnings.

The patch 917809e2280b: "slimbus: ngd: Add qcom SLIMBus NGD driver" 
from Jun 19, 2018, leads to the following Smatch complaint:

    drivers/slimbus/qcom-ngd-ctrl.c:867 qcom_slim_ngd_xfer_msg()
     warn: variable dereferenced before check 'txn->msg' (see line 791)

drivers/slimbus/qcom-ngd-ctrl.c
   790	
   791		if (txn->msg->num_bytes > SLIM_MSGQ_BUF_LEN ||
                    ^^^^^^^^^
Dereference

   792				txn->rl > SLIM_MSGQ_BUF_LEN) {
   793			dev_err(ctrl->dev, "msg exeeds HW limit\n");
   794			return -EINVAL;
   795		}
   796	
   797		pbuf = qcom_slim_ngd_tx_msg_get(ctrl, txn->rl, &tx_sent);
   798		if (!pbuf) {
   799			dev_err(ctrl->dev, "Message buffer unavailable\n");
   800			return -ENOMEM;
   801		}
   802	
   803		if (txn->mt == SLIM_MSG_MT_CORE &&
   804			(txn->mc == SLIM_MSG_MC_CONNECT_SOURCE ||
   805			txn->mc == SLIM_MSG_MC_CONNECT_SINK ||
   806			txn->mc == SLIM_MSG_MC_DISCONNECT_PORT)) {
   807			txn->mt = SLIM_MSG_MT_DEST_REFERRED_USER;
   808			switch (txn->mc) {
   809			case SLIM_MSG_MC_CONNECT_SOURCE:
   810				txn->mc = SLIM_USR_MC_CONNECT_SRC;
   811				break;
   812			case SLIM_MSG_MC_CONNECT_SINK:
   813				txn->mc = SLIM_USR_MC_CONNECT_SINK;
   814				break;
   815			case SLIM_MSG_MC_DISCONNECT_PORT:
   816				txn->mc = SLIM_USR_MC_DISCONNECT_PORT;
   817				break;
   818			default:
   819				return -EINVAL;
   820			}
   821	
   822			usr_msg = true;
   823			i = 0;
   824			wbuf[i++] = txn->la;
   825			la = SLIM_LA_MGR;
   826			wbuf[i++] = txn->msg->wbuf[0];
   827			if (txn->mc != SLIM_USR_MC_DISCONNECT_PORT)
   828				wbuf[i++] = txn->msg->wbuf[1];
   829	
   830			txn->comp = &done;
   831			ret = slim_alloc_txn_tid(sctrl, txn);
   832			if (ret) {
   833				dev_err(ctrl->dev, "Unable to allocate TID\n");
   834				return ret;
   835			}
   836	
   837			wbuf[i++] = txn->tid;
   838	
   839			txn->msg->num_bytes = i;
   840			txn->msg->wbuf = wbuf;
   841			txn->msg->rbuf = rbuf;
   842			txn->rl = txn->msg->num_bytes + 4;
   843		}
   844	
   845		/* HW expects length field to be excluded */
   846		txn->rl--;
   847		puc = (u8 *)pbuf;
   848		*pbuf = 0;
   849		if (txn->dt == SLIM_MSG_DEST_LOGICALADDR) {
   850			*pbuf = SLIM_MSG_ASM_FIRST_WORD(txn->rl, txn->mt, txn->mc, 0,
   851					la);
   852			puc += 3;
   853		} else {
   854			*pbuf = SLIM_MSG_ASM_FIRST_WORD(txn->rl, txn->mt, txn->mc, 1,
   855					la);
   856			puc += 2;
   857		}
   858	
   859		if (slim_tid_txn(txn->mt, txn->mc))
   860			*(puc++) = txn->tid;
   861	
   862		if (slim_ec_txn(txn->mt, txn->mc)) {
   863			*(puc++) = (txn->ec & 0xFF);
   864			*(puc++) = (txn->ec >> 8) & 0xFF;
   865		}
   866	
   867		if (txn->msg && txn->msg->wbuf)
                    ^^^^^^^^
This check is too late.

   868			memcpy(puc, txn->msg->wbuf, txn->msg->num_bytes);
   869	

regards,
dan carpenter
