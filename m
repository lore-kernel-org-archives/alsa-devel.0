From: "Baek Chang" <baeksan@ccrma.stanford.edu>
Subject: Re: S24_BLE does not play using aplay.
Date: Thu, 13 Nov 2008 10:44:49 -0800
Message-ID: <aceb60a00811131044o47c6c616ndf79ae68082aeeb@mail.gmail.com>
References: <aceb60a00811061659o11eec5f4s6c5b6c4ba470b873@mail.gmail.com>
	<49144BD2.3070400@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gv-out-0910.google.com (gv-out-0910.google.com [216.239.58.191])
	by alsa0.perex.cz (Postfix) with ESMTP id BF19A10380E
	for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2008 19:44:50 +0100 (CET)
Received: by gv-out-0910.google.com with SMTP id i36so214824gve.24
	for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2008 10:44:50 -0800 (PST)
In-Reply-To: <49144BD2.3070400@ladisch.de>
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

I am using pulseaudio as the sound server in conjunction with alsa.  My alsa
sinks are mapped to pulseaudio in asound.conf.  Using paplay with a 24 bit
file seems to work fine, because pulseaudio just converts the S24 bit data
to 32 bit float.  Is there a way to bypass using plughw with alsa, so that
alsa can just send the 24 bit pcm data to pulseaudio, then have pulseaudio
do the neccessary conversion?

Thanks
Baek

On Fri, Nov 7, 2008 at 6:08 AM, Clemens Ladisch <clemens@ladisch.de> wrote:

> Baek Chang wrote:
> > Playing WAVE 'sine_24_48k.wav' : Signed 24 bit Little Endian in 3bytes,
> Rate 48000 Hz, Stereo
> > aplay: set_params:961: Sample format non available
>
> This error message indicates that the device does not support the sample
> format.
>
> You didn't show the aplay command line, but I'd guess that you used a
> "hw" device.  Try "plughw" or "default" to get automatic sample format
> conversion.
>
>
> HTH
> Clemens
>
>


-- 
Baek Chang
baeksan@ccrma.stanford.edu
407-267-6701
