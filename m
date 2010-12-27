From: Radivoje Jovanovic <radivojejovanovic@gmail.com>
Subject: Alsa and Gstreamer?
Date: Mon, 27 Dec 2010 15:08:56 -0800
Message-ID: <AANLkTikvON_6pkbhwroTj8qCYcVCXvwoRvO-BMe96NRp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id D715F103833
	for <alsa-devel@alsa-project.org>; Tue, 28 Dec 2010 00:08:57 +0100 (CET)
Received: by wwe15 with SMTP id 15so8750978wwe.20
	for <alsa-devel@alsa-project.org>; Mon, 27 Dec 2010 15:08:56 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,
I have the stereo driver working on my system. If I try playing wave files
with aplay everything works just fine. The problem shows up when I try
playing movies through gstreamer. When I play the movie (I have 2 decoders ,
many movies and they all behave the same) the sound comes choppy. If I add
following change in the pcm_lib.c file snd_pcm_lib_write1 method.:
if ((err = transfer(substream, appl_ofs, data, offset, frames)) < 0) //NO
CHANGE
            goto _end; //NO CHANGE
//THIS IS THE  LINE I ADDED THAT INVALIDATES CACHE SO DMA IS 100% CORRECT
dma_sync_single_range_for_device(0, runtime->dma_buffer_p->addr , 0,
runtime->dma_buffer_p->bytes, DMA_TO_DEVICE);
I must say that memory allocation in my driver is done through
snd_pcm_lib_preallocate_pages_for_all and I am not sure why would data be
stuck in cache, so I cannot explain why this line makes the difference.

Now if I play just sound part in the gstreamer like this:

gst-launch-0.10 filesrc location=MY_MOVIE.mp4 ! qtdemux name=t ! queue !
faad ! alsasink

the sound plays just fine.

Also, if I play just video part it plays just fine. But if I play audio and
video together like this:
gst-launch-0.10 filesrc location=MY_MOVIE.mp4 ! qtdemux name=t ! queue  !
my_decoder ! my_video_sink t. ! queue ! faad ! alsasink

the whole clip plays much faster (if video is 36 seconds long now it will
last 25 seconds. Of course video and audio skip a lot).
Does anyone have an idea where can I even start looking for a problem?
Cheers,
Ogi
