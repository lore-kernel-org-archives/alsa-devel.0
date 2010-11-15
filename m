From: Irfan Shaikh <irfan.shaikh@sasken.com>
Subject: Direct write (using mmap_bigin and commit)
Date: Mon, 15 Nov 2010 17:54:20 +0530
Message-ID: <16F32A3F9AF4E441B752BCD79C151ACA5D9A2EE339@EXGMBX01.sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mta-blr1.sasken.com (mta-blr1.sasken.com [203.200.200.72])
	by alsa0.perex.cz (Postfix) with ESMTP id BA8C624499
	for <alsa-devel@alsa-project.org>; Mon, 15 Nov 2010 13:24:26 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello,

         I am reading an raw PCM  file and want to write on PCM device using direct write (interleaved). I have gone through PCM.c test application.
I am trying tio write PCM audio data as follows. I am unable to use  snd_pcm_mmap_begin and snd_pcm_mmap_commit properly. Please help me to use using these APIs
Question :
1) How can i write to Ring buffer area (any pcm audio data)?  //Any example or explanation other than pcm.c
2) Do i need to write diffferently for each channel as shown in pcm.c

I am trying to do following but not succeded (reading pcm file and writing content on device) . ANy thing played on audio device would help me in understanding.

        snd_pcm_channel_area_t my_areas;
        snd_pcm_uframes_t offset, frames, size;
        snd_pcm_sframes_t avail, commitres;
        int result;
        char *buffer;

        while(1)
        {
            avail = snd_pcm_avail_update(handle);
            if(avail>=period_size)
            {
                size=periodsize
                while (size > 0) {
                        frames = size;
                        err = snd_pcm_mmap_begin(handle, &my_areas, &offset, &frames);
                        mybuffer=(char *)malloc(frames*2);
                        result = fread (mybuffer,1,(frames*2),pFile);
                        my_areas.addr=mybuffer;           // IS THIS CORRECT ? WILL THIS WORK ? How can i write my audio file data here in areas?
                        commitres = snd_pcm_mmap_commit(handle, offset, frames);
            }
        }

SASKEN BUSINESS DISCLAIMER: This message may contain confidential, proprietary or legally privileged information. In case you are not the original intended Recipient of the message, you must not, directly or indirectly, use, disclose, distribute, print, or copy any part of this message and you are requested to delete it and inform the sender. Any views expressed in this message are those of the individual sender unless otherwise stated. Nothing contained in this message shall be construed as an offer or acceptance of any offer by Sasken Communication Technologies Limited ("Sasken") unless sent with that express intent and with due authority of Sasken. Sasken has taken enough precautions to prevent the spread of viruses. However the company accepts no liability for any damage caused by any 
 virus transmitted by this email.
Read Disclaimer at http://www.sasken.com/extras/mail_disclaimer.html
