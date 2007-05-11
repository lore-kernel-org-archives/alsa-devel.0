From: "Michel Benoit" <murpme@gmail.com>
Subject: soft vol
Date: Fri, 11 May 2007 12:36:01 +0200
Message-ID: <c88e466f0705110336l5596cf8fwc434b0f071f5ee15@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.231])
	by alsa0.perex.cz (Postfix) with ESMTP id 5A86B2447F
	for <alsa-devel@alsa-project.org>;
	Fri, 11 May 2007 12:36:02 +0200 (CEST)
Received: by wr-out-0506.google.com with SMTP id 58so855630wri
	for <alsa-devel@alsa-project.org>; Fri, 11 May 2007 03:36:01 -0700 (PDT)
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

Hello

Now that I have my pcm playback working with aplay with our at91 aSoc
sound driver I would like to control the volume with softvol.

I followed the instructions from
http://alsa.opensrc.org/How_to_use_softvol_to_control_the_master_volume
and I have the following asound.con file in /etc

pcm.!default {
    type             plug
    slave.pcm       "softvol"
}

pcm.softvol {
    type        softvol
    slave {
        pcm     "plughw:0,0"
    }
    control {
        name    "PCM volume"
        card    0
    }
}

When I play a wav file directly to the device it works fine:

# aplay -Dplughw:0,0 Front_Center.wav
Playing WAVE 'Front_Center.wav' : Signed 16 bit Little Endian, Rate
48000 Hz, Mono

but when I try to use the default softvol device I get the following
output (and no sound):

# aplay Front_Center.wav
Playing WAVE 'Front_Center.wav' : Signed 16 bit Little Endian, Rate
48000 Hz, Mono
ALSA sound/core/control.c:1244: unknown ioctl = 0xc2c45512
ALSA sound/core/control.c:1244: unknown ioctl = 0xc2c45512
ALSA sound/core/control.c:1244: unknown ioctl = 0xc2c45512
ALSA sound/core/control.c:1244: unknown ioctl = 0xc2c45512
ALSA sound/core/control.c:1244: unknown ioctl = 0xc2c45512
...

Does anyone have any ideas as to why this is happening?

Michel
