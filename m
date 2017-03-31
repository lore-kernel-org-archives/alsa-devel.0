From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] ALSA: oxfw: Add support for AV/C stream
 format command to get/set supported stream formation
Date: Fri, 31 Mar 2017 16:33:03 +0300
Message-ID: <20170331133302.GA11166@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by alsa0.perex.cz (Postfix) with ESMTP id DC4BB26691F
 for <alsa-devel@alsa-project.org>; Fri, 31 Mar 2017 15:33:11 +0200 (CEST)
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

The patch 5b59d8098d2a: "ALSA: oxfw: Add support for AV/C stream
format command to get/set supported stream formation" from Dec 9,
2014, leads to the following static checker warning:

	sound/firewire/oxfw/oxfw-command.c:96 avc_stream_get_format()
	warn: check that subtract can't underflow 'err - 10'

sound/firewire/oxfw/oxfw-command.c
    76          /* do transaction and check buf[1-7] are the same against command */
    77          err = fcp_avc_transaction(unit, buf, 12, buf, *len,
    78                                    BIT(1) | BIT(2) | BIT(3) | BIT(4) | BIT(5) |
    79                                    BIT(6) | BIT(7));
    80          if ((err > 0) && (err < 10))

Assume err is either 0 or 10.

    81                  err = -EIO;
    82          else if (buf[0] == 0x08)        /* NOT IMPLEMENTED */
    83                  err = -ENOSYS;
    84          else if (buf[0] == 0x0a)        /* REJECTED */
    85                  err = -EINVAL;
    86          else if (buf[0] == 0x0b)        /* IN TRANSITION */
    87                  err = -EAGAIN;
    88          /* LIST subfunction has entry ID */
    89          else if ((subfunc == 0xc1) && (buf[10] != eid))

If "err" is 10, doesn't that mean we are reading beyond the end of the
loop here?

    90                  err = -EIO;
    91          if (err < 0)
    92                  goto end;
    93  
    94          /* keep just stream format information */
    95          if (subfunc == 0xc0) {
    96                  memmove(buf, buf + 10, err - 10);

If "err" is 0 then we are going to crash here.

    97                  *len = err - 10;
    98          } else {
    99                  memmove(buf, buf + 11, err - 11);

Basically if "err" is zero we're going to crash one way or another.  But
if err is 10 and we reach this line then we will crash as well.

   100                  *len = err - 11;
   101          }
   102  
   103          err = 0;
   104  end:
   105          return err;
   106  }

regards,
dan carpenter
