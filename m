From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: About bt87x
Date: Wed, 9 Mar 2005 13:13:21 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0503091305480.12279-100000@studcom.urz.uni-halle.de>
References: <7fe20599050309030051e073c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <7fe20599050309030051e073c3@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Joe Hsu <nagual.hsu@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Joe Hsu wrote:
>     I have a bt878 audio device. It can work only at digital
> sample rate 8000HZ from TV tuner source. For this bt878 audio
> device, we have modified some source of the kernel module
> btaudio. The only difference between the original module and
> the modified one is the value of GPIO_DMA_CTL register.

Which field has to be changed?  Is it the physical format of samples
on the serial bus?

>    Now, I have tried to modify alsa bt87x to work for me. I add
> another pci_device_id to represent 8000HZ sample rate. I changed
> three fields of snd_bt87x_digital_hw to represent mono 8000HZ. But
> still don't work.

Those changes wouldn't affect the control register.

> And then I changed the value of GPIO_DMA_CTL register as I did in
> the btaudio module. Well, it worked in slow motion when I played
> the captured pcm data.

This indicates that the actual sample rate is higher than 8 kHz.  Or
probably some stereo/mono mismatch.


Could you please post your changes to btaudio.c?


Regards,
Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
