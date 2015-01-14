From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [alsa-devel] unload Audio drivers while playback stream is active
 case kernel crash
Date: Wed, 14 Jan 2015 09:15:36 +0100
Message-ID: <54B625A8.8090406@metafoo.de>
References: <857E9EDCA6C0904DB3357321AA9123EB0108B66919@NA-MBX-01.mgc.mentorg.com> <s5h1tmyiof7.wl-tiwai@suse.de> <20150113215412.GS4160@sirena.org.uk> <s5hr3ux24em.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hr3ux24em.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Wang, Jiada (ESD)" <Jiada_Wang@mentor.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "Frkuska, Joshua" <Joshua_Frkuska@mentor.com>
List-Id: alsa-devel@alsa-project.org

On 01/14/2015 08:43 AM, Takashi Iwai wrote:
> At Tue, 13 Jan 2015 21:54:12 +0000,
> Mark Brown wrote:
>>
>> On Tue, Jan 13, 2015 at 06:24:44PM +0100, Takashi Iwai wrote:
>>> Wang, Jiada (ESD) wrote:
>>
>>>> I am using i.MX6Q sabreSD board, which have imx_wm892 machine driver, wm8962 codec and SSI CPU DAI,
>>
>>>> I got Kernel crash when unloading audio drivers (playback stream is active)
>>>> modprobe -r snd_soc_imx_wm8962
>>>> modprobe -r snd_soc_fsl_ssi
>>>> modprobe -r snd_soc_wm8962
>>
>>> The root problem is that you can unload the module while playing.
>>> The corresponding module refcounts should have been increased during
>>> used.
>>
>>> Do we miss [try_]module_get() somewhere in ASoC?
>>
>> That doesn't help, users can still forcibly unbind the driver at runtime
>> without loading the module - and there's always the potential for
>> actually hotpluggable hardware.  The teardown paths should be able to
>> cope somewhat gracefully.
>
> The module refcount has to be handled while being used for stopping
> module unload.  That's irrelevant from the dynamic unbinding support
> itself.  Of course, the module refcount doesn't save the world, but
> it's the right fix for this particular scenario.

Refcounting won't help in this case. The issue is caused by a delayed work 
item that gets launched when the PCM stream is stopped. So if you decrease 
the refcount when the stream is stopped you still have a window where it is 
possible to remove the module while the work is still being scheduled.

And while we do flush the scheduled work when we remove the ASoC card this 
is done before snd_card_free() is called. So when snd_card_free() is called 
it gets re-scheduled again. I think the correct fix is to add a 
snd_card_disconnect() at the very top of soc_cleanup_card_resources().

- Lars
