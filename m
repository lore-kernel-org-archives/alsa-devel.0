From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: ALSA: timer: Handle disconnection more safely
Date: Fri, 22 Jan 2016 22:52:48 +0300
Message-ID: <20160122195247.GA13742@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by alsa0.perex.cz (Postfix) with ESMTP id EC0CC2602F1
 for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2016 20:53:02 +0100 (CET)
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

This is a semi-automatic email about new static checker warnings.

The patch 230323dac060: "ALSA: timer: Handle disconnection more 
safely" from Jan 21, 2016, leads to the following Smatch complaint:

sound/core/timer.c:1091 snd_timer_proc_read()
	 error: we previously assumed 'timer->card' could be null (see line 1084)

sound/core/timer.c
  1083		list_for_each_entry(timer, &snd_timer_list, device_list) {
  1084			if (timer->card && timer->card->shutdown)
                            ^^^^^^^^^^^
New test.

  1085				continue;
  1086			switch (timer->tmr_class) {
  1087			case SNDRV_TIMER_CLASS_GLOBAL:
  1088				snd_iprintf(buffer, "G%i: ", timer->tmr_device);
  1089				break;
  1090			case SNDRV_TIMER_CLASS_CARD:
  1091				snd_iprintf(buffer, "C%i-%i: ",
  1092					    timer->card->number, timer->tmr_device);
                                            ^^^^^^^^^^^^^^^^^^^
Old untested dereference.  But maybe SNDRV_TIMER_CLASS_CARD implies
non-NULL?

  1093				break;

regards,
dan carpenter
