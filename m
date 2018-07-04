From: =?UTF-8?B?UmFwaGHDq2wgRGluZ8Op?= <raphael.dinge@ohmforce.com>
Subject: Can't detect "XRUNs"
Date: Wed, 4 Jul 2018 12:26:01 +0200
Message-ID: <CAL-i0qF80jHGH_7Cwxik3HO86Ng3PZH18fxf0vABk4cMUY5OdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f49.google.com (mail-oi0-f49.google.com
 [209.85.218.49])
 by alsa0.perex.cz (Postfix) with ESMTP id A6A74267214
 for <alsa-devel@alsa-project.org>; Wed,  4 Jul 2018 12:26:03 +0200 (CEST)
Received: by mail-oi0-f49.google.com with SMTP id r16-v6so9799011oie.3
 for <alsa-devel@alsa-project.org>; Wed, 04 Jul 2018 03:26:03 -0700 (PDT)
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

Hi,

I don't get audio drop notification "XRUNs" in /proc/kmsg.

Not sure if this is the right mailing list as maybe my question is
more kernel related, but I'll try a shot here.

I'm currently making a proof of concept to see if I can run a quite
CPU hungry audio application running without audio drops over time
given a set of tests. In particular I want to automate playback buffer
underruns detection so that I don't have to sit and listen closely
when they happen.

With some very extreme tests, I can hear that there are audio drops
all over the place.

I have 2 audio cards in the system, one is audio over HDMI, and the
other one is an USB audio card that supports audio class definition.
In both case the sound is working as I would expect. The system itself
is an Intel NUC i7.

I configured the kernel with CONFIG_SND_DEBUG=y,
CONFIG_SND_PCM_XRUN_DEBUG=y and CONFIG_SND_VERBOSE_PROCFS=y as well as
echo 5 > /proc/asound/cardX/pcmYp/xrun_debug with X and Y the card and
pcm stream of interest, and so hw:X,Y when opening the device with
snd_pcm_open.

Then I watch the output of the ksyslog interface using cat /proc/kmsg

When an audio drop occurs, there is nothing about XRUNs or whatever it
is called. I don't even know what kind of log message it should look
like, and can't find it on google as well.

With audio over HDMI, I have some occurence of ALSA: PCM: [Q] Lost
interrupts? that seems more of less related to audio drops, but not
always.
With the USB audio card, I have nothing.

I tried to write to the xrun_injection proc file in the stream, but
nothing happens as well.

Finally I log any occurence of snd_pcm_writei returning a negative
number, but that never happens as well.

Am I missing something completely?

Thanks for any information on that matter,

Raphael
