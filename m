From: Phil Gorbett <pgorbett@usc.edu.au>
Subject: Re: DELL SP2309W Monitor with Integrated microphone
Date: Sat, 11 Apr 2009 15:48:38 +1000
Message-ID: <1239428918.22783.8.camel@sundance.localdomain>
References: <1239411042.15067.41.camel@sundance.localdomain>
	<75b66ecd0904101823l4a34e297u1246a4ff6117643f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail03.syd.optusnet.com.au (mail03.syd.optusnet.com.au
	[211.29.132.184])
	by alsa0.perex.cz (Postfix) with ESMTP id 2D9AB1037EE
	for <alsa-devel@alsa-project.org>;
	Sat, 11 Apr 2009 07:48:48 +0200 (CEST)
In-Reply-To: <75b66ecd0904101823l4a34e297u1246a4ff6117643f@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2009-04-10 at 21:23 -0400, Lee Revell wrote:
> 
> arecord -v -f cd -D plughw:0 file.wav

I get:

"arecord -v -f cd -D plughw:0 file.wav
Recording WAVE 'file.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
Stereo
ALSA lib pcm_params.c:2135:(snd1_pcm_hw_refine_slave) Slave PCM not
usable
arecord: set_params:939: Broken configuration for this PCM: no
configurations available"


To disable p/a, I selected alsa in all sound prefs.  The ALSA webcam
driver is also selected for "sound capture".  I then did "sudo killall
pulseaudio" as well as "pulseaudio -k" for root (sudo) and normal user.

A file.wav was not created.

Cheers,
PG
