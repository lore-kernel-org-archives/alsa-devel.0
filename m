From: Irfan Shaikh <irfan.shaikh@sasken.com>
Subject: Re: Direct write (using mmap_bigin and commit)
Date: Tue, 16 Nov 2010 11:21:01 +0530
Message-ID: <16F32A3F9AF4E441B752BCD79C151ACA5D9A2EE33D@EXGMBX01.sasken.com>
References: <16F32A3F9AF4E441B752BCD79C151ACA5D9A2EE339@EXGMBX01.sasken.com>,
	<alpine.LNX.2.00.1011151415310.29422@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mta-blr1.sasken.com (mta-blr1.sasken.com [203.200.200.72])
	by alsa0.perex.cz (Postfix) with ESMTP id 71855243F3
	for <alsa-devel@alsa-project.org>; Tue, 16 Nov 2010 06:55:18 +0100 (CET)
In-Reply-To: <alpine.LNX.2.00.1011151415310.29422@eeebox2.perex-int.cz>
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
To: Jaroslav Kysela <perex@perex.cz>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


Based on your input and pcm.c i wrote folloeing code. But its showing seg fault as pointed by comment in code below. Please tell me what wrong i am doing and how do i correct.

/###################################################################################/
        unsigned int count = (alsaParams->frames/(((alsaParams->bit_per_sample)*(alsaParams->num_channel)) / 8));
        unsigned char *data = alsaParams->data;
        snd_pcm_sframes_t frames_available, frames_transmit;
        const snd_pcm_channel_area_t *area;
        snd_pcm_uframes_t offset;
        char *outbuffer;
        int result;

        /*available space in audio-buffer to write to*/
        frames_available = snd_pcm_avail_update(alsaParams->pcm_handle);

        /*
         * prepare the areas
         * and get back area, offset and frames_transmit
         * frames_transmit gives back the REAL value of available frames which could be written to in the mmaped-area
         * frames_transmit are less than frames_available
         */
        frames_transmit = frames_available;

        snd_pcm_mmap_begin(alsaParams->pcm_handle, &area, &offset, &frames_transmit);

        /*calculates the mmaped-buffer which could be written to*/
        outbuffer = ((char *) area->addr + (area->first + area->step * offset)/ 8);    // ********** SEGFAULT ************

        /*gives back the virtually written (writable) frames which should be always == frames_transmit*/
        result = snd_pcm_mmap_commit(alsaParams->pcm_handle, offset, frames_transmit);

        memcpy(outbuffer, data, count);  //data is actual data

I think if above code works fine should play sound.
/###################################################################################/

Thanks in Advance,
Irfan

________________________________________
From: Jaroslav Kysela [perex@perex.cz]
Sent: Monday, November 15, 2010 6:52 PM
To: Irfan Shaikh
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] Direct write (using mmap_bigin and commit)

On Mon, 15 Nov 2010, Irfan Shaikh wrote:

> Hello,
>
>         I am reading an raw PCM  file and want to write on PCM device using direct write (interleaved). I have gone through PCM.c test application.
> I am trying tio write PCM audio data as follows. I am unable to use  snd_pcm_mmap_begin and snd_pcm_mmap_commit properly. Please help me to use using these APIs
> Question :
> 1) How can i write to Ring buffer area (any pcm audio data)?  //Any example or explanation other than pcm.c
> 2) Do i need to write diffferently for each channel as shown in pcm.c
>
> I am trying to do following but not succeded (reading pcm file and writing content on device) . ANy thing played on audio device would help me in understanding.
>
>        snd_pcm_channel_area_t my_areas;
>        snd_pcm_uframes_t offset, frames, size;
>        snd_pcm_sframes_t avail, commitres;
>        int result;
>        char *buffer;
>
>        while(1)
>        {
>            avail = snd_pcm_avail_update(handle);
>            if(avail>=period_size)
>            {
>                size=periodsize
>                while (size > 0) {
>                        frames = size;
>                        err = snd_pcm_mmap_begin(handle, &my_areas, &offset, &frames);
>                        mybuffer=(char *)malloc(frames*2);
>                        result = fread (mybuffer,1,(frames*2),pFile);
>                        my_areas.addr=mybuffer;           // IS THIS CORRECT ? WILL THIS WORK ? How can i write my audio file data here in areas?

What's this? You just overwrite the read-only pointer value in my_areas.
Use the ring buffer pointer and do memcpy or so. Use area returned from
mmap_begin(), don't forget to add offset. Also, application must check,
if my_areas description (buffer arrangement) is expected (check for
sample step/offset).

The pcm.c is good example. Just try to understand what my_areas
really does. And no, it's not necessary to handle just one sample, if you
know the PCM ring buffer layout.

                                        Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.


SASKEN BUSINESS DISCLAIMER: This message may contain confidential, proprietary or legally privileged information. In case you are not the original intended Recipient of the message, you must not, directly or indirectly, use, disclose, distribute, print, or copy any part of this message and you are requested to delete it and inform the sender. Any views expressed in this message are those of the individual sender unless otherwise stated. Nothing contained in this message shall be construed as an offer or acceptance of any offer by Sasken Communication Technologies Limited ("Sasken") unless sent with that express intent and with due authority of Sasken. Sasken has taken enough precautions to prevent the spread of viruses. However the company accepts no liability for any damage caused by any 
 virus transmitted by this email.
Read Disclaimer at http://www.sasken.com/extras/mail_disclaimer.html
