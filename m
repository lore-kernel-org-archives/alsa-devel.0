From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: ALSA: emu10k1: Use standard printk helpers
Date: Wed, 5 Mar 2014 14:05:09 +0300
Message-ID: <20140305110344.GA16926@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id 55A07265A81
 for <alsa-devel@alsa-project.org>; Wed,  5 Mar 2014 12:05:22 +0100 (CET)
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
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Takashi Iwai,

The patch 6f002b02166c: "ALSA: emu10k1: Use standard printk helpers"
from Feb 25, 2014, leads to the following static checker warning:

	sound/pci/emu10k1/io.c:75 snd_emu10k1_ptr_write()
	error: we previously assumed 'emu' could be null (see line 74)

sound/pci/emu10k1/io.c
    68  void snd_emu10k1_ptr_write(struct snd_emu10k1 *emu, unsigned int reg, unsigned int chn, unsigned int data)
    69  {
    70          unsigned int regptr;
    71          unsigned long flags;
    72          unsigned int mask;
    73  
    74          if (!emu) {
                    ^^^^
    75                  dev_err(emu->card->dev, "ptr_write: emu is null!\n");
                                ^^^^^^^^^^^^^^
Dereference.

    76                  dump_stack();
    77                  return;
    78          }

regards,
dan carpenter
