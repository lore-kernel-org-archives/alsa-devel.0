From: Olivier Langlois <olivier@trillion01.com>
Subject: Re: Only stereo output possible with ATI Tahiti XT
 HDMI Audio [Radeon HD 7970 Series] [1002:aaa0]
Date: Thu, 16 May 2013 09:30:21 -0400
Message-ID: <1368711021.1131.36.camel@Wailaba2>
References: <1368501319.18787.18.camel@Wailaba2>
 <1368625619.1131.11.camel@Wailaba2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from oproxy13-pub.unifiedlayer.com (oproxy13-pub.unifiedlayer.com
 [69.89.16.30]) by alsa0.perex.cz (Postfix) with SMTP id 6904B265516
 for <alsa-devel@alsa-project.org>; Thu, 16 May 2013 15:30:27 +0200 (CEST)
Received: from [173.178.227.159] (port=40271 helo=[192.168.1.104])
 by box610.bluehost.com with esmtpsa (TLSv1:CAMELLIA256-SHA:256)
 (Exim 4.80) (envelope-from <olivier@trillion01.com>)
 id 1UcyGF-0000x7-57
 for alsa-devel@alsa-project.org; Thu, 16 May 2013 07:30:23 -0600
In-Reply-To: <1368625619.1131.11.camel@Wailaba2>
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


On Wed, 2013-05-15 at 09:46 -0400, Olivier Langlois wrote:

> 
> In the meantime, I have tried to setup an alternative with my given
> wcaps:
> 
> lano1106@whippet2 ~ :( $ cat /etc/asound.conf
> pcm.mypcm {
>    type plug
>    slave {
>      pcm "hdmi:{AES0 0x6 AES1 0x82 AES2 0x0 AES3 0x2}"
>    }
> }
> 
> pcm.a52encode {
>     type a52
>     slavepcm mypcm
> }
> 
> pcm.!default pcm.a52encode
> 
> lano1106@whippet2 ~ $ speaker-test -c6
> 
> speaker-test 1.0.27
> 
> Playback device is default
> Stream parameters are 48000Hz, S16_LE, 6 channels
> Using 16 octaves of pink noise
> Access type not available for playback: Invalid argument
> Setting of hwparams failed: Invalid argument
> 
> Apparently, SND_PCM_ACCESS_RW_INTERLEAVED is not supported with my
> setup.
> 
I am grateful that noone has replied as it has allowed me to dig alsa
and appreciate further its design.

For completeness and help the next user stumbling on the same problem, I
am autoreplying to myself

Trivia quiz: What kind of access mode does the a52 plugin accept?
A: It depends...INTERLEAVED if libavcodec is old or NONINTERLEAVED if
you have a recent ffmpeg setup, in anycase, a plug shield you from
surprises....:

pcm.a52encode {
    type a52
    card 0
}

pcm.a52accessadapter {
    type plug
    slave {
      pcm a52encode
    }
}

pcm.!default pcm.a52accessadapter

Concerning ATI Tahiti 7.1 HDMI output. Looking into patch_hdmi.c and by
seeing the special secret magic handshake to enable 7.1 output for a nvidia
device made me thinking about a slight hope to do something similar for
my card. I'll report back if I find the ATI magic incantation to reach
7.1 nirvana.
