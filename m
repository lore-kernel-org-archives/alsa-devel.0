From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] ASoC: Intel: Refactor common IPC/mailbox
 code into generic APIs
Date: Tue, 10 Oct 2017 11:14:44 +0300
Message-ID: <20171010081444.7x2svg6lqpq27hui@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id 3048426727C
 for <alsa-devel@alsa-project.org>; Tue, 10 Oct 2017 10:14:58 +0200 (CEST)
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
To: yao.jin@linux.intel.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Jin Yao,

The patch a33c1ec5cf82: "ASoC: Intel: Refactor common IPC/mailbox
code into generic APIs" from Apr 7, 2015, leads to the following
static checker warning:

	sound/soc/intel/common/sst-ipc.c:242 sst_ipc_reply_find_msg()
	error: uninitialized symbol 'mask'.

sound/soc/intel/common/sst-ipc.c
   226  struct ipc_message *sst_ipc_reply_find_msg(struct sst_generic_ipc *ipc,
   227          u64 header)
   228  {
   229          struct ipc_message *msg;
   230          u64 mask;
   231  
   232          if (ipc->ops.reply_msg_match != NULL)
   233                  header = ipc->ops.reply_msg_match(header, &mask);

What should "mask" be initialized to if ops.reply_msg_match is NULL?

   234  
   235          if (list_empty(&ipc->rx_list)) {
   236                  dev_err(ipc->dev, "error: rx list empty but received 0x%llx\n",
   237                          header);
   238                  return NULL;
   239          }
   240  
   241          list_for_each_entry(msg, &ipc->rx_list, list) {
   242                  if ((msg->header & mask) == header)
                             ^^^^^^^^^^^^^^^^^^
Used uninitialized here.

   243                          return msg;
   244          }
   245  
   246          return NULL;
   247  }

regards,
dan carpenter
