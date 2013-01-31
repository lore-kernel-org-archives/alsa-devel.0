From: Brent Weatherall <brentweatherall@gmail.com>
Subject: PandaBoard ES Audio Problems
Date: Thu, 31 Jan 2013 08:51:35 -0800
Message-ID: <CAAo96ZCNBTGBToLbKnvQ1k_eewJcg94KZBRKt7TKkE3T8xqsQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A2892615D5
 for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2013 17:51:36 +0100 (CET)
Received: by mail-pb0-f51.google.com with SMTP id un15so1684963pbc.38
 for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2013 08:51:35 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello.

     While developing with OpenMax and ALSA on the PandaBoard ES (OMAP 4460
armhf), I ran into a strange problem.

At a high level, when configuring the built in audio device (3.5 mm jack),
the device accepts ANY rate requested (via snd_pcm_set_rate_near).  it
accepts unsupported rates without alteration.  If the rate is actually not
supported, then 'snd_pcm_hw_params' fails with error '-22'.  After this
happens, it is not possible to reconfigure the rate without closing the
device and starting over to completely re-configure from the start (calling
snd_pcm_open, etc...).  It is not possible to simply try another rate.
 Technical details below:

When 'snd_pcm_set_rate_near' is called, during the min and max rate
probing, the code reaches

interval_inline.h:71      INTERVAL_INLINE int snd_interval_min(const
snd_interval_t *i)

During this call, line '74              return i->min;' executes.  This
function ALWAYS returns the same rate value requested in
'snd_pcm_set_rate_near' as the minimum possible rate.  If I request a rate
near 44100, the minimum rates comes back as 44100.  If I request a rate
near 8000, the minimum is returned as 8000 and so forth.

To recap, the 'snd_pcm_set_rate_near' call ALWAYS succeeds without altering
the rate passed to it the first time.  The only way to find out if the rate
is actually supported is to call 'snd_pcm_hw_params' and then see if that
fails with err == -22 (invalid argument).  Furthermore, once the failure
occurs, another rate value cannot be tried unless the PCM device is closed
and the entire configuration process is repeated.  After the failure,
subsequent calls to 'snd_pcm_set_rate_near' with ANY different value always
get set back to the original bad value.  Example, I request 44100 and it
fails.  So I try 8000 and it returns 44100 (and of course fails again if I
try 'snd_pcm_hw_params').

I am not sure yet, but is the value at 'interval_inline.h:74
 return i->min;' determined directly by the hardware?  It seems like it is,
but I don't know the code well enough yet to make that assertion.

I also haven't yet examined the 'snd_interval_max' command, but my gut
tells me it is behaving the same way, since after a bad rate is set, any
higher or lower rate setting attempts ALWAYS come back as the original
rate.  How would i determine if it is hardware or maybe something bad with
the hardware.software interface?

I checked the PCM state value and it was correct the entire time.

Here are short snippets of two gdb sessions where I found the issue and
below that is test program output showing the state values as I try to
configure two different rates:

Code snippet in ALSA lib file interval_inline.h:

71      INTERVAL_INLINE int snd_interval_min(const snd_interval_t *i)
72      {
73              assert(!snd_interval_empty(i));
74              return i->min;
75      }

Run #1 with 44100 'snd_pcm_set_rate_near' call:
(gdb) s
74              return i->min;
(gdb) print i->min
$6 = 44100

Run #2 with 8000 'snd_pcm_set_rate_near' call:
(gdb) s
74              return i->min;
(gdb) print i->min
$8 = 8000

Here is a log of the high level test program:

snd_pcm_hw_params_set_rate_near succeeded.
Rate set to 44100.
snd_pcm_hw_params_set_channels succeeded.
cannot set buffer time (Invalid argument)
cannot set buffer period time (Invalid argument)
Before commit, state is: SND_PCM_STATE_OPEN
cannot set parameters (Invalid argument)
After failure, state is: SND_PCM_STATE_OPEN
Trying to re-configure rate param.
Before calling 'snd_pcm_drop', state is: SND_PCM_STATE_OPEN
cannot drop (Input/output error)
After calling 'snd_pcm_drop', state is: SND_PCM_STATE_OPEN
Trying rate 8000.
snd_pcm_hw_params_set_rate_near succeeded.
Rate set to 44100.
snd_pcm_hw_params_set_buffer_time_near succeeded.
Buffer size actually set to 22050.
cannot set buffer period time (Invalid argument)
cannot set parameters (Invalid argument)
cannot prepare audio interface for use (Input/output error)
Rate 44100 supported: FAIL

Please let me know your thoughts on this and if there is a good way to
prove if this is a hardware error or a software error.  I am running 'Linux
version 3.4.0-1487-omap4' and using the standard repositories with apt-get
to install ALSA.  I used 'apt-get source' to obtain 'alsa-lib-1.0.25'
source files and I am running 'libasound2-dbg' to enable GDB debugging.

Regards,

Brent
