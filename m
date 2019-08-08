From: Giuliano Zannetti - ART S.p.A. <giuliano.zannetti@artgroup-spa.com>
Subject: multi pcm plugin issue
Date: Thu, 8 Aug 2019 00:09:47 +0000
Message-ID: <AM5P192MB01809959F8AC046FAC258809C5D70@AM5P192MB0180.EURP192.PROD.OUTLOOK.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur03on0626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0a::626])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C0382F800E4
 for <alsa-devel@alsa-project.org>; Thu,  8 Aug 2019 02:09:49 +0200 (CEST)
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

I have a performance related problem using the multi PCM plugin.


---------------------------------------------------------------------
    THE ISSUE
---------------------------------------------------------------------

The following scenario triggers the issue. The CPU load is up to 90%.

plug - - > upmix - - > multi - - > forward_dmix
                             - - > loopback_dmix

pcm.giuliano_plug
{
  type plug
  slave.pcm giuliano_upmix
  slave.channels 2
}

pcm.giuliano_upmix
{
  type route
  slave.pcm giuliano_multi
  slave.channels 4
  ttable.0.0 1
  ttable.0.1 1
  ttable.1.2 1
  ttable.1.3 1
}

pcm.giuliano_multi
{
  type multi
  slaves
  {
    slave0
    {
      pcm forward_dmix
      channels 2
    }
    slave1
    {
      pcm loopback_dmix
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
  master 0
}

pcm.forward_dmix
{
  type dmix
  ipc_key 1000
  ipc_key_add_uid 1
  ipc_perm 0600
  slave.period_time 10000
  slave.period_size 480
  slave.buffer_size 1920
  slave.rate 48000
  slave.pcm "hw:0,0"
}

pcm.loopback_dmix
{
  type dmix
  ipc_key 1001
  ipc_key_add_uid 1
  ipc_perm 0600
  slave.period_time 10000
  slave.period_size 480
  slave.buffer_size 1920
  slave.rate 48000
  slave.pcm loopback_out
}

pcm.loopback_out
{
  type hw
  card Loopback
  device 0
  subdevice 0
}

pcm.loopback_dsnoop
{
  type dsnoop
  ipc_key 1002
  ipc_key_add_uid 1
  ipc_perm 0600
  slave.period_time 10000
  slave.period_size 480
  slave.buffer_size 1920
  slave.rate 48000
  slave.pcm loopback_in
}

pcm.loopback_in
{
  type hw
  card Loopback
  device 1
  subdevice 0
}

The following scenario does not trigger the issue. The CPU load is at most 2%.

plug - - > upmix - - > downmix - - > forward_dmix

pcm.giuliano_plug
{
  type plug
  slave.pcm giuliano_upmix
  slave.channels 2
}

pcm.giuliano_upmix
{
  type route
  slave.pcm giuliano_downmix
  slave.channels 4
  ttable.0.0 1
  ttable.0.1 1
  ttable.1.2 1
  ttable.1.3 1
}

pcm.giuliano_downmix
{
  type route
  slave.pcm forward_dmix
  slave.channels 2
  ttable.0.0 1
  ttable.1.1 1
  ttable.2.0 1
  ttable.3.1 1
}


---------------------------------------------------------------------
    DEBUG PRINTS IN FUNCTION snd_pcm_write_areas IN FILE pcm.c
---------------------------------------------------------------------

For each while iteration the log prints the available frames (avail) and the frames
to be written (size). In the multi scenario the several while iterations decrease the
performances and the CPU load is high. In the normal scenario i see that at most two iterations
of the while are needed. In other words, in the multi scenario the avail frames are not enough
to stop the loop. You can see below the prints: avail < size for 28 iterations. Note that
this behaviour does not occurs only at startup, but every time during the playback.

snd_pcm_sframes_t snd_pcm_write_areas(snd_pcm_t *pcm, const snd_pcm_channel_area_t *areas,
                      snd_pcm_uframes_t offset, snd_pcm_uframes_t size,
                      snd_pcm_xfer_areas_func_t func)
{
    snd_pcm_uframes_t xfer = 0;
    snd_pcm_sframes_t err = 0;
    snd_pcm_state_t state;

    if (size == 0)
        return 0;

    int giuliano_i = 0;

    __snd_pcm_lock(pcm); /* forced lock */
    while (size > 0) {
        snd_pcm_uframes_t frames;
        snd_pcm_sframes_t avail;
    _again:
        state = __snd_pcm_state(pcm);
        switch (state) {
        case SND_PCM_STATE_PREPARED:
        case SND_PCM_STATE_PAUSED:
            break;
        case SND_PCM_STATE_RUNNING:
            err = __snd_pcm_hwsync(pcm);
            if (err < 0)
                goto _end;
            break;
        default:
            err = pcm_state_to_error(state);
            if (!err)
                err = -EBADFD;
            goto _end;
        }
        avail = __snd_pcm_avail_update(pcm);

        fprintf(
            stderr,
            "giuliano | pcm.c | snd_pcm_write_areas | (%d) avail=%ld, size=%ld\n",
            giuliano_i, avail, size
        );
        giuliano_i ++;

        if (avail < 0) {
            err = avail;
            goto _end;
        }
        if (state == SND_PCM_STATE_RUNNING &&
            size > (snd_pcm_uframes_t)avail) {
            if (snd_pcm_may_wait_for_avail_min(pcm, avail)) {
                if (pcm->mode & SND_PCM_NONBLOCK) {
                    err = -EAGAIN;
                    goto _end;
                }

                err = snd_pcm_wait_nocheck(pcm, -1);

                if (err < 0)
                    break;

                goto _again;
            }
            /* the snd_pcm_may_wait_for_avail_min may check against the
             * updated hw.ptr (slaves), get the avail again here
             */
            avail = __snd_pcm_avail_update(pcm);
            if (avail < 0) {
                err = avail;
                goto _end;
            }
        }
        frames = size;
        if (frames > (snd_pcm_uframes_t) avail)
            frames = avail;
        if (! frames)
            break;
        err = func(pcm, areas, offset, frames);
        if (err < 0)
            break;
        frames = err;
        if (state == SND_PCM_STATE_PREPARED) {
            snd_pcm_sframes_t hw_avail = pcm->buffer_size - avail;
            hw_avail += frames;
            /* some plugins might automatically start the stream */
            state = __snd_pcm_state(pcm);
            if (state == SND_PCM_STATE_PREPARED &&
                hw_avail >= (snd_pcm_sframes_t) pcm->start_threshold) {
                err = __snd_pcm_start(pcm);
                if (err < 0)
                    goto _end;
            }
        }
        offset += frames;
        size -= frames;
        xfer += frames;
    }
_end:
    __snd_pcm_unlock(pcm);
    return xfer > 0 ? (snd_pcm_sframes_t) xfer : snd_pcm_check_error(pcm, err);
}


---------------------------------------------------------------------
    DEBUG PRINTS OUTPUT
---------------------------------------------------------------------

## Multi scenario ##

giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=1920
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=1920
giuliano | pcm.c | snd_pcm_write_areas | (0) avail=1920, size=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=1440
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=1440
giuliano | pcm.c | snd_pcm_write_areas | (0) avail=1440, size=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=960
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=960
giuliano | pcm.c | snd_pcm_write_areas | (0) avail=960, size=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=480
giuliano | pcm.c | snd_pcm_write_areas | (0) avail=480, size=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=0
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=0
giuliano | pcm.c | snd_pcm_write_areas | (0) avail=0, size=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=0
*** snd_pcm_wait() FATAL ERROR!!!
avail_min = 480, avail_update = 0
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=0
giuliano | pcm.c | snd_pcm_write_areas | (1) avail=0, size=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=0
*** snd_pcm_wait() FATAL ERROR!!!
avail_min = 480, avail_update = 0
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=0
giuliano | pcm.c | snd_pcm_write_areas | (2) avail=0, size=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=0
*** snd_pcm_wait() FATAL ERROR!!!
avail_min = 480, avail_update = 0
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=0
giuliano | pcm.c | snd_pcm_write_areas | (3) avail=0, size=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=0
*** snd_pcm_wait() FATAL ERROR!!!
avail_min = 480, avail_update = 0
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=0
giuliano | pcm.c | snd_pcm_write_areas | (4) avail=0, size=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=0
*** snd_pcm_wait() FATAL ERROR!!!
avail_min = 480, avail_update = 0
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=0
giuliano | pcm.c | snd_pcm_write_areas | (5) avail=0, size=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=0
*** snd_pcm_wait() FATAL ERROR!!!
avail_min = 480, avail_update = 0
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=0
giuliano | pcm.c | snd_pcm_write_areas | (6) avail=0, size=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=0
*** snd_pcm_wait() FATAL ERROR!!!
avail_min = 480, avail_update = 0
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=0
giuliano | pcm.c | snd_pcm_write_areas | (7) avail=0, size=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=0
*** snd_pcm_wait() FATAL ERROR!!!
avail_min = 480, avail_update = 0
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=0
giuliano | pcm.c | snd_pcm_write_areas | (8) avail=0, size=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=0
*** snd_pcm_wait() FATAL ERROR!!!
avail_min = 480, avail_update = 0
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=0
giuliano | pcm.c | snd_pcm_write_areas | (9) avail=0, size=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=0
*** snd_pcm_wait() FATAL ERROR!!!
avail_min = 480, avail_update = 0
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=0
giuliano | pcm.c | snd_pcm_write_areas | (10) avail=0, size=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=0
*** snd_pcm_wait() FATAL ERROR!!!
avail_min = 480, avail_update = 0
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=0
giuliano | pcm.c | snd_pcm_write_areas | (11) avail=0, size=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=0
*** snd_pcm_wait() FATAL ERROR!!!
avail_min = 480, avail_update = 0
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=0
giuliano | pcm.c | snd_pcm_write_areas | (12) avail=0, size=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=0
*** snd_pcm_wait() FATAL ERROR!!!
avail_min = 480, avail_update = 0
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=0
giuliano | pcm.c | snd_pcm_write_areas | (13) avail=0, size=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=0
*** snd_pcm_wait() FATAL ERROR!!!
avail_min = 480, avail_update = 0
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=0
giuliano | pcm.c | snd_pcm_write_areas | (14) avail=0, size=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=0
*** snd_pcm_wait() FATAL ERROR!!!
avail_min = 480, avail_update = 0
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=0
giuliano | pcm.c | snd_pcm_write_areas | (15) avail=0, size=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=0
*** snd_pcm_wait() FATAL ERROR!!!
avail_min = 480, avail_update = 0
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=960
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=384
giuliano | pcm.c | snd_pcm_write_areas | (16) avail=384, size=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=960
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=384
*** snd_pcm_wait() FATAL ERROR!!!
avail_min = 480, avail_update = 384
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=960
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=384
giuliano | pcm.c | snd_pcm_write_areas | (17) avail=384, size=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=960
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=384
*** snd_pcm_wait() FATAL ERROR!!!
avail_min = 480, avail_update = 384
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=960
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=384
giuliano | pcm.c | snd_pcm_write_areas | (18) avail=384, size=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=960
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=384
*** snd_pcm_wait() FATAL ERROR!!!
avail_min = 480, avail_update = 384
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=960
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=384
giuliano | pcm.c | snd_pcm_write_areas | (19) avail=384, size=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=960
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=384
*** snd_pcm_wait() FATAL ERROR!!!
avail_min = 480, avail_update = 384
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=960
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=384
giuliano | pcm.c | snd_pcm_write_areas | (20) avail=384, size=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=960
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=384
*** snd_pcm_wait() FATAL ERROR!!!
avail_min = 480, avail_update = 384
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=960
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=384
giuliano | pcm.c | snd_pcm_write_areas | (21) avail=384, size=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=960
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=384
*** snd_pcm_wait() FATAL ERROR!!!
avail_min = 480, avail_update = 384
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=960
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=384
giuliano | pcm.c | snd_pcm_write_areas | (22) avail=384, size=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=960
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=384
*** snd_pcm_wait() FATAL ERROR!!!
avail_min = 480, avail_update = 384
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=960
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=384
giuliano | pcm.c | snd_pcm_write_areas | (23) avail=384, size=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=960
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=384
*** snd_pcm_wait() FATAL ERROR!!!
avail_min = 480, avail_update = 384
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=960
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=384
giuliano | pcm.c | snd_pcm_write_areas | (24) avail=384, size=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=960
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=384
*** snd_pcm_wait() FATAL ERROR!!!
avail_min = 480, avail_update = 384
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=960
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=384
giuliano | pcm.c | snd_pcm_write_areas | (25) avail=384, size=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=960
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=384
*** snd_pcm_wait() FATAL ERROR!!!
avail_min = 480, avail_update = 384
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=960
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=384
giuliano | pcm.c | snd_pcm_write_areas | (26) avail=384, size=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=960
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=384
*** snd_pcm_wait() FATAL ERROR!!!
avail_min = 480, avail_update = 384
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=960
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=384
giuliano | pcm.c | snd_pcm_write_areas | (27) avail=384, size=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=1440
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=576
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=1440
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=576
giuliano | pcm.c | snd_pcm_write_areas | (28) avail=576, size=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=960
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=96
giuliano | pcm.c | snd_pcm_write_areas | (0) avail=96, size=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=960
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=96
*** snd_pcm_wait() FATAL ERROR!!!
avail_min = 480, avail_update = 96
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=960
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=96
giuliano | pcm.c | snd_pcm_write_areas | (1) avail=96, size=480
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=0, avail=960
giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=1, avail=96
*** snd_pcm_wait() FATAL ERROR!!!
avail_min = 480, avail_update = 96

## Normal scenario ##

giuliano | pcm.c | snd_pcm_write_areas | (0) avail=1920, size=480
giuliano | pcm.c | snd_pcm_write_areas | (0) avail=1440, size=480
giuliano | pcm.c | snd_pcm_write_areas | (0) avail=960, size=480
giuliano | pcm.c | snd_pcm_write_areas | (0) avail=480, size=480
giuliano | pcm.c | snd_pcm_write_areas | (0) avail=0, size=480
giuliano | pcm.c | snd_pcm_write_areas | (1) avail=480, size=480
giuliano | pcm.c | snd_pcm_write_areas | (0) avail=0, size=480
giuliano | pcm.c | snd_pcm_write_areas | (1) avail=480, size=480
giuliano | pcm.c | snd_pcm_write_areas | (0) avail=0, size=480
giuliano | pcm.c | snd_pcm_write_areas | (1) avail=480, size=480
giuliano | pcm.c | snd_pcm_write_areas | (0) avail=0, size=480
giuliano | pcm.c | snd_pcm_write_areas | (1) avail=480, size=480
giuliano | pcm.c | snd_pcm_write_areas | (0) avail=0, size=480
giuliano | pcm.c | snd_pcm_write_areas | (1) avail=480, size=480
giuliano | pcm.c | snd_pcm_write_areas | (0) avail=0, size=480
giuliano | pcm.c | snd_pcm_write_areas | (1) avail=480, size=480
giuliano | pcm.c | snd_pcm_write_areas | (0) avail=0, size=480
giuliano | pcm.c | snd_pcm_write_areas | (1) avail=480, size=480
giuliano | pcm.c | snd_pcm_write_areas | (0) avail=0, size=480
giuliano | pcm.c | snd_pcm_write_areas | (1) avail=480, size=480
giuliano | pcm.c | snd_pcm_write_areas | (0) avail=0, size=480
giuliano | pcm.c | snd_pcm_write_areas | (1) avail=480, size=480


---------------------------------------------------------------------
    DEBUG PRINTS IN FUNCTION snd_pcm_wait_nocheck IN FILE pcm.c
---------------------------------------------------------------------

As you can see in the debug prints above i have enabled the error message
in the function snd_pcm_wait_nocheck.

That message lead me to think that the issue is a poll related one, may be?

int snd_pcm_wait_nocheck(snd_pcm_t *pcm, int timeout)
{
  struct pollfd *pfd;
  unsigned short revents = 0;
  int npfds, err, err_poll;

  npfds = __snd_pcm_poll_descriptors_count(pcm);
  if (npfds <= 0 || npfds >= 16) {
    SNDERR("Invalid poll_fds %d\n", npfds);
    return -EIO;
  }
  pfd = alloca(sizeof(*pfd) * npfds);
  err = __snd_pcm_poll_descriptors(pcm, pfd, npfds);
  if (err < 0)
    return err;
  if (err != npfds) {
    SNDMSG("invalid poll descriptors %d\n", err);
    return -EIO;
  }
  do {
    __snd_pcm_unlock(pcm);
    err_poll = poll(pfd, npfds, timeout);
    __snd_pcm_lock(pcm);
    if (err_poll < 0) {
            if (errno == EINTR && !PCMINABORT(pcm))
                    continue;
      return -errno;
                }
    if (! err_poll)
      break;
    err = __snd_pcm_poll_revents(pcm, pfd, npfds, &revents);
    if (err < 0)
      return err;
    if (revents & (POLLERR | POLLNVAL)) {
      /* check more precisely */
      err = pcm_state_to_error(__snd_pcm_state(pcm));
      return err < 0 ? err : -EIO;
    }
  } while (!(revents & (POLLIN | POLLOUT)));
#if 1 /* very useful code to test poll related problems */
  {
    snd_pcm_sframes_t avail_update;
    __snd_pcm_hwsync(pcm);
    avail_update = __snd_pcm_avail_update(pcm);
    if (avail_update < (snd_pcm_sframes_t)pcm->avail_min) {
      printf("*** snd_pcm_wait() FATAL ERROR!!!\n");
      printf("avail_min = %li, avail_update = %li\n", pcm->avail_min, avail_update);
    }
  }
#endif
  return err_poll > 0 ? 1 : 0;
}
#endif


---------------------------------------------------------------------
    DEBUG PRINTS IN FUNCTION __snd_pcm_avail_update IN pcm_multi.c
---------------------------------------------------------------------

As you can see in the prints above, i put some debugs logs in the function
__snd_pcm_avail_update. I can read there the number of avail frames for each slave of
the multi. I see also that the minimum numbers of frames is taken among the slaves.

static snd_pcm_sframes_t snd_pcm_multi_avail_update(snd_pcm_t *pcm)
{
  snd_pcm_multi_t *multi = pcm->private_data;
  snd_pcm_sframes_t ret = LONG_MAX;

    snd_pcm_sframes_t giuliano_temp = 0;

  unsigned int i;
  for (i = 0; i < multi->slaves_count; ++i) {
    snd_pcm_sframes_t avail;
    avail = snd_pcm_avail_update(multi->slaves[i].pcm);
        fprintf(
            stderr,
            "giuliano | pcm_multi.c | snd_pcm_multi_avail_update | slave=%d, avail=%d\n",
            i, avail
        );
    if (avail < 0)
      return avail;
    if (ret > avail)
      ret = avail;
  }
  snd_pcm_multi_hwptr_update(pcm);

    return ret;
}



I hope that my debug prints are useful to find the issue.



Thanks

Giuliano Zannetti
