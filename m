From: "sandeep lahane" <sandeep.lahane@gmail.com>
Subject: Accessing alsa user space buffer from external io type
	plugin
Date: Mon, 24 Mar 2008 16:13:41 -0700
Message-ID: <2d51cbf80803241613n3782b150x4c7ee6ea16e2db81@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.228])
	by alsa0.perex.cz (Postfix) with ESMTP id 891FE10387F
	for <alsa-devel@alsa-project.org>; Tue, 25 Mar 2008 00:13:43 +0100 (CET)
Received: by wx-out-0506.google.com with SMTP id t11so3791410wxc.23
	for <alsa-devel@alsa-project.org>; Mon, 24 Mar 2008 16:13:42 -0700 (PDT)
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

I am debugging an userspace external io type plugin, written for an ARM
based board where the plugin
interacts with DSP directly using shared memory.

Every time I have to send period_size data to the DSP, I have my own
write/read methods to do so.

I am having a problem accessing the alsa ring buffer, my transfer function
looks like following.


static   char * temp;
static snd_pcm_sframes_t alsa_transfer(snd_pcm_ioplug_t *io,
                   const snd_pcm_channel_area_t *areas,
                   snd_pcm_uframes_t offset,
                   snd_pcm_uframes_t size)
{

           ......

         temp = malloc(period_size);
         memcpy(temp,  unsigned char *)areas->addr + (areas->first +
areas->step * offset) / 8, period_size);
          write_to_dsp(temp, period_size);
          .......
}

All the book keeping is done properly, the first chunk of data is sent
properly to DSP and pointer() returns correct value,
next time when transfer is called, the memcpy gives segfault. ALSA buffer is
an interleaved buffer and I am not using mmap
mode. Any idea what might be wrong?

When I do something like this:
        memcpy(temp,  "test data test data", period_size);
the data is sent properly to DSP, but alsa buffer data is not getting
accessed properly.





-- 

Regards,
Sandeep.
