From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] ALSA: pcm: Return -EBUSY for OSS ioctls
 changing busy streams
Date: Tue, 27 Mar 2018 15:27:30 +0300
Message-ID: <20180327122730.GA28142@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by alsa0.perex.cz (Postfix) with ESMTP id 19CB0267140
 for <alsa-devel@alsa-project.org>; Tue, 27 Mar 2018 14:27:40 +0200 (CEST)
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

The patch 40cab6e88cb0: "ALSA: pcm: Return -EBUSY for OSS ioctls
changing busy streams" from Mar 23, 2018, leads to the following
static checker warning:

	sound/core/oss/pcm_oss.c:1741 snd_pcm_oss_set_rate()
	warn: inconsistent returns 'mutex:&runtime->oss.params_lock'.
	  Locked on:   line 1734
	  Unlocked on: line 1732
	               line 1741

sound/core/oss/pcm_oss.c
  1717  static int snd_pcm_oss_set_rate(struct snd_pcm_oss_file *pcm_oss_file, int rate)
  1718  {
  1719          int idx;
  1720  
  1721          for (idx = 1; idx >= 0; --idx) {
  1722                  struct snd_pcm_substream *substream = pcm_oss_file->streams[idx];
  1723                  struct snd_pcm_runtime *runtime;
  1724                  if (substream == NULL)
  1725                          continue;
  1726                  runtime = substream->runtime;
  1727                  if (rate < 1000)
  1728                          rate = 1000;
  1729                  else if (rate > 192000)
  1730                          rate = 192000;
  1731                  if (mutex_lock_interruptible(&runtime->oss.params_lock))
  1732                          return -ERESTARTSYS;
  1733                  if (atomic_read(&runtime->oss.rw_ref))
  1734                          return -EBUSY;
                                ^^^^^^^^^^^^^
Unlock before returning?

  1735                  if (runtime->oss.rate != rate) {
  1736                          runtime->oss.params = 1;
  1737                          runtime->oss.rate = rate;
  1738                  }
  1739                  mutex_unlock(&runtime->oss.params_lock);
  1740          }
  1741          return snd_pcm_oss_get_rate(pcm_oss_file);
  1742  }

regards,
dan carpenter
