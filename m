From: "Markus Rechberger" <mrechberger@gmail.com>
Subject: Re: underrun!!! (at least 0,
	249 ms long) was (struct snd_pcm_hardware_t values)
Date: Wed, 9 Aug 2006 12:08:00 +0200
Message-ID: <d9def9db0608090308u7eb538e4y9ca7db9c212b07d1@mail.gmail.com>
References: <d9def9db0608071809x648b8febsbc6feba4930e5cfa@mail.gmail.com>
	<s5hac6fr0bv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.181])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9E6A6229
	for <alsa-devel@alsa-project.org>;
	Wed,  9 Aug 2006 12:08:01 +0200 (MEST)
Received: by py-out-1112.google.com with SMTP id b29so4182pya
	for <alsa-devel@alsa-project.org>; Wed, 09 Aug 2006 03:08:00 -0700 (PDT)
In-Reply-To: <s5hac6fr0bv.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On 8/8/06, Takashi Iwai <tiwai@suse.de> wrote:
> At Tue, 8 Aug 2006 03:09:43 +0200,
> Markus Rechberger wrote:
> >
> > Ok I managed to get rid of that garbled background noise now I get
> > underrun messages...
> >
> > $ aplay -D hw:2,1 5_5_2006__07_00_59.wav
> > Playing WAVE '5_5_2006__07_00_59.wav' : Signed 16 bit Little Endian,
> > Rate 9600 Hz, Mono
> > underrun!!! (at least 0,271 ms long)
> > underrun!!! (at least 0,248 ms long)
> > [...]
> >
> > I can hear the sound clearly, but looks like these 200ms cause a choppy
> sound...
> > I also tried to add support for this device to snd-usb-audio, but
> > since this device has no synchronisation packets the driver fails...
> > Does anyone know what causes such a buffer underrun?
>

This is fixed now I set the buffer size 3 times as high as the period
size.. though I still have the same choppy effect. Seems like a
problem with the filled USB packets.. I wonder why the supported
packet size is 128 bytes but the windows driver fills max. 38 bytes of
every packet... My driver currently fills only 20 bytes since this is
the average of what the windriver does too.

> For example, the calculation of the current pointer doesn't match with
> the actual position.
>

there might be something wrong in line 350/351 but it has a lower
priority at the moment for me...

> > I think it still has something to do with the snd_pcm_hardware_t values...
>
> My guess is that the problem is the implementation of pointer
> callback.
>
> > maybe the time will come when I'm not the only one on this ML who
> > answers my questions....
>
> Maybe you'll get more response if you show your codes more openly...
> Otherwise it's just a wild guess.
>

there we go:
http://linuxtv.org/hg/~mrechberger/v4l-dvb?mf=598d5b40d82a;path=/v4l_experimental/usbaudio/;style=gitweb

the projectwebsite:
http://alsa.opensrc.org/au600

the driver was always available uppon request... thought it would be
nice to host it in an alsa development tree or so but I haven't got
any answer regarding this a while ago.. I put it into my video4linux
development tree now..

Markus

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
