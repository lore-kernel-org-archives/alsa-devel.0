From: "Prabhu Sivaraja" <prabhu.sivaraja@gmail.com>
Subject: dmix does not mix small files??
Date: Thu, 3 May 2007 00:14:24 -0700
Message-ID: <49f264960705030014v7441c188y3d2ed918472c6085@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.225])
	by alsa0.perex.cz (Postfix) with ESMTP id 65C2A2446B
	for <alsa-devel@alsa-project.org>;
	Thu,  3 May 2007 09:14:26 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id l8so394811nzf
	for <alsa-devel@alsa-project.org>; Thu, 03 May 2007 00:14:24 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

Hi,

I've been stuck on this dmix problem for the past week and have tried
everything under the sun. Please any help or comment is much appreciated.
Thanks a lot.

Background info.
-----------------------
In my ALSA driver I have thread that keeps track of hw_ptr(dmix)
appl_ptr(for all other cases) and copies the incoming data from kernal
buffer into device circular buffer(which is monitored by the device). I
allocate 64KB kernal buffer in my module_init function . (See allocation
below)
snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_CONTINUOUS,
snd_dma_continuous_data(GFP_KERNEL),  64*1024 , 64*1024);

So I monitor this kernal buffer and copy data from this to my device
circular buffer which is also 64KB.

My period size is defined as 32KB. (See below)
substream->runtime->hw.period_bytes_min = 1024*32;
substream->runtime->hw.period_bytes_max = 1024*32;
substream->runtime->hw.periods_min = 2;
substream->runtime->hw.periods_max = 2;

My asound.conf file
   pcm.mix {
        type dmix
        ipc_key 1024
        slave {
        pcm "hw:0,0"
           rate 48000
        }
    }
    pcm.!default {
        type plug
        slave.pcm "mix"
    }

Everything was working fine until I noticed something weird. When I am
playing a long wav file by invoking aplay and then try and play another
small wav file simultaneously, the second file never gets mixed if the file
is less than 64KB(my buffer size). If the second file is larger than
64KB then the second file gets mixed with the first one as it should since I
am using dmix plugin.

So in order to debug this I tried to decrease my period_size = 4KB but when
I do this my hw_ptr never moves.

My question.
1. Why do you think a file smaller than 64KB does not get mixed. (Obviously
it has something to do with my buffer size but I dont get why?)
2. When I decrease my period_size to 4KB while keeping my buffer size at
64KB, why doesnt my hw_ptr move?
3. How else would I debug this?

Thanks in advance. I would really appreciate any help.

Regards
Prabhu.
