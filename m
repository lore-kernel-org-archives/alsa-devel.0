From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] ALSA: seq: obsolete change of address
	limit
Date: Tue, 11 Oct 2016 14:06:14 +0300
Message-ID: <20161011110614.GA1290@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id 52EB4261560
 for <alsa-devel@alsa-project.org>; Tue, 11 Oct 2016 13:06:28 +0200 (CEST)
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
To: o-takashi@sakamocchi.jp
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Takashi Sakamoto,

The patch e12ec251e4db: "ALSA: seq: obsolete change of address limit"
from Aug 13, 2016, leads to the following static checker warning:

	sound/core/seq/seq_compat.c:61 snd_seq_call_port_info_ioctl()
	warn: did you mean to pass the address of 'data'

sound/core/seq/seq_compat.c
    45  static int snd_seq_call_port_info_ioctl(struct snd_seq_client *client, unsigned int cmd,
    46                                          struct snd_seq_port_info32 __user *data32)
    47  {
    48          int err = -EFAULT;
    49          struct snd_seq_port_info *data;
    50  
    51          data = kmalloc(sizeof(*data), GFP_KERNEL);
    52          if (!data)
    53                  return -ENOMEM;
    54  
    55          if (copy_from_user(data, data32, sizeof(*data32)) ||
    56              get_user(data->flags, &data32->flags) ||
    57              get_user(data->time_queue, &data32->time_queue))
    58                  goto error;
    59          data->kernel = NULL;
    60  
    61          err = snd_seq_kernel_client_ctl(client->number, cmd, &data);

This should almost certainly be "cmd, data);" without the &.  Have you
tested this?  It eventually gets passed to functions like
snd_seq_ioctl_create_port().

    62          if (err < 0)
    63                  goto error;
    64  
    65          if (copy_to_user(data32, data, sizeof(*data32)) ||
    66              put_user(data->flags, &data32->flags) ||
    67              put_user(data->time_queue, &data32->time_queue))
    68                  err = -EFAULT;
    69  
    70   error:
    71          kfree(data);
    72          return err;
    73  }

regards,
dan carpenter
