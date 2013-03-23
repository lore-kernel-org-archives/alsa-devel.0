From: Daniel Mack <zonque@gmail.com>
Subject: Re: ASoC: BeagleBoard driver development (PCM3168)
Date: Sat, 23 Mar 2013 16:57:13 +0100
Message-ID: <514DD0D9.1080800@gmail.com>
References: <CAGxc5aCJisVLrC09YsWAoh3U9_kKGKwFqiK4KM-u7JZ7SpW58w@mail.gmail.com>
 <5118F700.90006@ti.com>
 <CAGxc5aCZarD+-4EqSA9QZx_RvXRvJuGpKXtp=RiUPdcATuxFng@mail.gmail.com>
 <51235D8E.7040705@ti.com>
 <CAGxc5aDQ5btyvhcEnCcvNJZhRuCZWz8XS9SxOqcgmgBSx+bYZQ@mail.gmail.com>
 <5124D1EB.9030404@ti.com> <514DBE3A.3040502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f49.google.com (mail-bk0-f49.google.com
 [209.85.214.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B158265287
 for <alsa-devel@alsa-project.org>; Sat, 23 Mar 2013 16:57:07 +0100 (CET)
Received: by mail-bk0-f49.google.com with SMTP id w11so2273759bku.22
 for <alsa-devel@alsa-project.org>; Sat, 23 Mar 2013 08:57:07 -0700 (PDT)
In-Reply-To: <514DBE3A.3040502@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Wendelin Klimann <wklimann@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 23.03.2013 15:37, Wendelin Klimann wrote:
> Hello Peter
> 
> I am stuck again in my ASoc driver development and it would be really 
> nice if you could give me an hint how i could solve this.
> 
> Acctually i try to connect my PCM3168 Audio Codec to the McBSP on the 
> BeagleBoard.
> My new driver loads fine and i got 2 soundcards:
> 
> *root@beagleboard:/lib/modules/3.7.4+/kernel/sound/soc/omap# aplay -l*
>     **** List of PLAYBACK Hardware Devices ****
>     card 0: omap3beagle [omap3beagle], device 0: TWL4030 twl4030-hifi-0 []
>       Subdevices: 1/1
>       Subdevice #0: subdevice #0
>     card 1: pcm3168 [pcm3168], device 0: PCM3168 pcm3168-hifi-0 []
>       Subdevices: 1/1
>       Subdevice #0: subdevice #0
> 
> Your TWL4030 driver is still working perfect with:
> 
> *root@beagleboard:/lib/modules/3.7.4+/kernel/sound/soc/omap# aplay 
> -Dhw:0,0 /home/root/fifi.wav*
>     [ 1245.302551] omap-dma-engine omap-dma-engine: allocating channel 
> for 33
>     Playing WAVE '/home/root/fifi.wav' : Signed 16 bit Little Endian, 
> Rate 44100 Hz, Stereo
> 
> but when i play the same file with my new driver i get an error (as 
> codec master and also as codec slave):
> 
> *root@beagleboard:/lib/modules/3.7.4+/kernel/sound/soc/omap# aplay 
> -Dhw:1,0 /home/root/fifi.wav*
>     [ 1128.677337] omap-dma-engine omap-dma-engine: allocating channel 
> for 17
>     Playing WAVE '/h[ 1128.689544] can't set codec DAI configuration - 
> pcm3168

This is where your trouble starts, and the reason is that when you call
snd_soc_dai_set_fmt() on your codec dai, the core will do this:

        if (dai->driver->ops->set_fmt == NULL)
                return -ENOTSUPP;

And because you didn't implement that callback in your codec driver, the
setup will fail. You need to implement that callback, and acknowledge
that the codec is able to operate under the wanted conditions. See other
codec drivers for a reference.

Also, you seem to wildly mix machine and codec code, which is exactly
what ASoC tries to prevent. Codec drivers are completely separated from
the machine part, because they are supposed to be exchangeable. See what
other machine code and codec drivers do. In general, as soon you as you
import a machine or platform specific header file from your codec code,
you're doing something wrong.


HTH,
Daniel
