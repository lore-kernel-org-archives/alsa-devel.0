From: Giuliano Zannetti - ART S.p.A. <giuliano.zannetti@artgroup-spa.com>
Subject: loopback snd_pcm_writei
Date: Mon, 1 Apr 2019 13:51:22 +0000
Message-ID: <AM5P192MB0180EB66182156CF2353C0FFC5550@AM5P192MB0180.EURP192.PROD.OUTLOOK.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr130080.outbound.protection.outlook.com [40.107.13.80])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 164A4F89610
 for <alsa-devel@alsa-project.org>; Mon,  1 Apr 2019 15:51:23 +0200 (CEST)
Content-Language: it-IT
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I have the configuration in the asound.conf above.

my_plug - - > my_route - - > my_multi - - > slave0 (forward)
                                      - - > slave1 (loopback)

I open the plug my_plug in the block mode:

    writtenFrames = snd_pcm_writei(handle, bufferToWrite, bufferToWriteSize);

The issue I see is that there are several "writes" with 0 written frames. It seems like the snd_pcm_writei does not hold until data will be written. In general, 0 written frames sounds weird to me, because snd_pcm_writei should block itself if no space is available in the circular buffer right?

I have tried to fix the following method in pcm_multi.c, as Jaroslav Kysela suggests.

-static int snd_pcm_multi_may_wait_for_avail_min(snd_pcm_t *pcm, snd_pcm_uframes_t avail ATTRIBUTE_UNUSED)
+static int snd_pcm_multi_may_wait_for_avail_min(snd_pcm_t *pcm, snd_pcm_uframes_t avail)
{
        snd_pcm_multi_t *multi = pcm->private_data;
-       snd_pcm_t *slave = multi->slaves[multi->master_slave].pcm;
-       return snd_pcm_may_wait_for_avail_min(slave, snd_pcm_mmap_avail(slave));
+       unsigned int i;
+       for (i = 0; i < multi->slaves_count; ++i) {
+               if (snd_pcm_may_wait_for_avail_min(multi->slaves[i].pcm, avail))
+                       return 1;
+       }
+       return 0;
}

But unfortunately the issue has not been resolved.


#*************************************************
#                     PLAYBACK
#*************************************************

pcm.my_plug
{
  type plug
  slave.pcm my_route
  slave.channels 2
}

pcm.my_route
{
  type route
  slave.pcm my_multi
  slave.channels 4
  ttable.0.0 1
  ttable.0.1 1
  ttable.1.2 1
  ttable.1.3 1
}

pcm.my_multi
{
  type multi
  slaves
  {
    slave0
    {
      pcm my_dmix
      channels 2
    }
    slave1
    {
      pcm my_dmix_loop
      channels 2
    }
  }
  bindings
  {
    0 {slave slave0 channel 0}
    1 {slave slave0 channel 1}
    2 {slave slave1 channel 0}
    3 {slave slave1 channel 1}
  }
}

#-------------------- Slave 0 --------------------

pcm.my_dmix
{
  type dmix
  ipc_key 1000
  ipc_key_add_uid 1
  ipc_perm 0600
  slave.period_time 10000
  slave.period_size 480
  slave.buffer_size 3840
  slave.rate 48000
  slave.pcm "hw:0,0"
}

#-------------------- Slave 1 --------------------

pcm.my_dmix_loop
{
  type dmix
  ipc_key 1000
  ipc_key_add_uid 1
  ipc_perm 0600
  slave.period_time 10000
  slave.period_size 480
  slave.buffer_size 3840
  slave.rate 48000
  slave.pcm my_loopback_out
}

pcm.my_loopback_out
{
  type hw
  card Loopback
  device 0
  subdevice 0
}

#*************************************************
#                     CAPTURE
#*************************************************

pcm.my_dsnoop_loop
{
  type dsnoop
  ipc_key 1000
  ipc_key_add_uid 1
  ipc_perm 0600
  slave.period_time 10000
  slave.period_size 480
  slave.buffer_size 3840
  slave.rate 48000
  slave.pcm my_loopback_in
}

pcm.my_loopback_in
{
  type hw
  card Loopback
  device 1
  subdevice 0
}
