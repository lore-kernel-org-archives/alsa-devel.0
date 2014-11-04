From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: ALSA: echoaudio: remove all snd_printk
Date: Tue, 4 Nov 2014 19:01:56 +0300
Message-ID: <20141104160156.GA15854@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by alsa0.perex.cz (Postfix) with ESMTP id 66D2B260623
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 17:02:10 +0100 (CET)
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
To: sudipm.mukherjee@gmail.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Sudip Mukherjee,

The patch b5b4a41b3929: "ALSA: echoaudio: remove all snd_printk" from
Nov 3, 2014, leads to the following static checker warning:

	sound/pci/echoaudio/echoaudio.c:1908 snd_echo_free()
	error: dereferencing freed memory 'chip'

sound/pci/echoaudio/echoaudio.c
  1905          /* release chip data */
  1906          free_firmware_cache(chip);
  1907          kfree(chip);
                ^^^^^^^^^^^
  1908          dev_dbg(chip->card->dev, "Chip freed.\n");
                        ^^^^^^^^^^

We have lots of printks in this function.  We could just delete them all
and no one would care.  These days you can get the same information from
ftrace.

  1909          return 0;
  1910  }

regards,
dan carpenter
