From: Olivier Langlois <olivier@trillion01.com>
Subject: Re: Only stereo output possible with ATI Tahiti XT
 HDMI Audio [Radeon HD 7970 Series] [1002:aaa0]
Date: Wed, 15 May 2013 09:46:59 -0400
Message-ID: <1368625619.1131.11.camel@Wailaba2>
References: <1368501319.18787.18.camel@Wailaba2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from oproxy13-pub.unifiedlayer.com (oproxy13-pub.unifiedlayer.com
 [69.89.16.30]) by alsa0.perex.cz (Postfix) with SMTP id 70C322615F3
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 15:47:03 +0200 (CEST)
Received: from [173.178.230.31] (port=56240 helo=[192.168.1.104])
 by box610.bluehost.com with esmtpsa (TLSv1:CAMELLIA256-SHA:256)
 (Exim 4.80) (envelope-from <olivier@trillion01.com>)
 id 1Ucc2m-0000Nc-OI
 for alsa-devel@alsa-project.org; Wed, 15 May 2013 07:47:00 -0600
In-Reply-To: <1368501319.18787.18.camel@Wailaba2>
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

Just a small update to my ALSA journey. After having read the HDA spec,
I now realize that beside the IEC958 control reg, there is not much
programmable from the HDA side and if the audio widget caps says stereo
that is pretty much it, valid ELD or not.

Something that I ommited to mention in my original request, it is that I
am using the catalyst closed source driver. Apparently the video driver
has something to do in order to have audio working as the open source
radeon card has a parameter 'radeon.audio=1'.

I have also read that the opens source driver do not support yet the
7970 (aka Radeon SI Southern Islands) but I am intrigued and now that I
have hit a dead-end on the HDA front, I'll explore the radeon driver
source code to see what it does related to audio in these cards.

In the meantime, I have tried to setup an alternative with my given
wcaps:

lano1106@whippet2 ~ :( $ cat /etc/asound.conf
pcm.mypcm {
   type plug
   slave {
     pcm "hdmi:{AES0 0x6 AES1 0x82 AES2 0x0 AES3 0x2}"
   }
}

pcm.a52encode {
    type a52
    slavepcm mypcm
}

pcm.!default pcm.a52encode

lano1106@whippet2 ~ $ speaker-test -c6

speaker-test 1.0.27

Playback device is default
Stream parameters are 48000Hz, S16_LE, 6 channels
Using 16 octaves of pink noise
Access type not available for playback: Invalid argument
Setting of hwparams failed: Invalid argument

Apparently, SND_PCM_ACCESS_RW_INTERLEAVED is not supported with my
setup.

Could I have seen it with something in /proc/asound ?
Is there a way to fix this with some kind of alsa plug setup?

Greetings and thank you in advance for your help,
Olivier
