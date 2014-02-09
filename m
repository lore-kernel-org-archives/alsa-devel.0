From: Thilo Schulz <thilo@tjps.eu>
Subject: Workaround for "[AO_ALSA] Unable to set buffer time
	near: Invalid argument" error on HDMI 5.1 output
Date: Sun, 9 Feb 2014 22:24:52 +0100
Message-ID: <201402092224.53074.thilo@tjps.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tjps.eu (tjps.eu [176.9.53.212])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D217260786
 for <alsa-devel@alsa-project.org>; Sun,  9 Feb 2014 22:24:58 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mplayer-users@mplayerhq.hu
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

the purpose of this message is just to document my workaround solution I found 
to a bug (probably in ALSA) on a stable Debian system. This took me the better 
of a fine sunday and I'm posting this to spare anyone who might run into a 
similar problem the same trouble. And I'm posting this so the alsa devs may 
look into this (if it's not already fixed in recent alsa versions).

Using mplayer, I recently tried outputting a 6 channel test wave file to the 
HDMI output on my Acer Aspire with a HDA Intel PCH card.

2 channels work fine, but trying to output 6 channels results in:

$ mplayer test.wav -ao alsa:device=hdmi -channels 6
[...]
[AO_ALSA] Unable to set buffer time near: Invalid argument
Failed to initialize audio driver 'alsa:device=hdmi'

Obviously, this code from mplayer's ao_alsa.c fails:

    unsigned int alsa_buffer_time = 500000; /* 0.5 s */
[...]
        if ((err = snd_pcm_hw_params_set_buffer_time_near(alsa_handler, \ 
alsa_hwparams, &alsa_buffer_time, NULL)) < 0)
          {
            mp_msg(MSGT_AO,MSGL_ERR,MSGTR_AO_ALSA_UnableToSetBufferTimeNear,
                   snd_strerror(err));
            return 0;
          }

A similar issue seems to have been discussed in this thread on alsa-devel:
http://mailman.alsa-project.org/pipermail/alsa-devel/2011-March/037450.html

And as a workaround it is suggested there to raise some memory preallocation 
parameter:
$ cat /proc/asound/card0/pcm3p/sub0/prealloc
64

like so:
$ echo 128 > /proc/asound/card0/pcm3p/sub0/prealloc

this indeed fixes the problem and mplayer plays fine. Now here comes the curious 
part. _Lowering_ the parameter like this:

$ echo 63 > /proc/asound/card0/pcm3p/sub0/prealloc

makes the problem go away as well. Strange.
For followup replies, please CC me, as I'm subscribed to neither mailing 
lists.
To ALSA devs: I would be willing to help debug this issue if you'd give a few 
instructions (where to put a few printk messages in the module, etc)

-- 
Beste regards,
Thilo Schulz
