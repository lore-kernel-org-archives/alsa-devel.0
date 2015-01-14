From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: unload Audio drivers while playback stream is
 active case kernel crash
Date: Wed, 14 Jan 2015 10:34:32 +0100
Message-ID: <54B63828.6030408@metafoo.de>
References: <857E9EDCA6C0904DB3357321AA9123EB0108B66919@NA-MBX-01.mgc.mentorg.com>
 <s5h1tmyiof7.wl-tiwai@suse.de> <20150113215412.GS4160@sirena.org.uk>
 <s5hr3ux24em.wl-tiwai@suse.de> <54B625A8.8090406@metafoo.de>
 <54B627F0.90207@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-243.synserver.de (smtp-out-243.synserver.de
 [212.40.185.243])
 by alsa0.perex.cz (Postfix) with ESMTP id 545AE2608EA
 for <alsa-devel@alsa-project.org>; Wed, 14 Jan 2015 10:34:33 +0100 (CET)
In-Reply-To: <54B627F0.90207@mentor.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: jiwang <jiada_wang@mentor.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Frkuska,
 Joshua" <Joshua_Frkuska@mentor.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 01/14/2015 09:25 AM, jiwang wrote:
> Hi
>
> On 01/14/2015 05:15 PM, Lars-Peter Clausen wrote:
>> On 01/14/2015 08:43 AM, Takashi Iwai wrote:
>>> At Tue, 13 Jan 2015 21:54:12 +0000,
>>> Mark Brown wrote:
>>>>
>>>> On Tue, Jan 13, 2015 at 06:24:44PM +0100, Takashi Iwai wrote:
>>>>> Wang, Jiada (ESD) wrote:
>>>>
>>>>>> I am using i.MX6Q sabreSD board, which have imx_wm892 machine driver,
>>>>>> wm8962 codec and SSI CPU DAI,
>>>>
>>>>>> I got Kernel crash when unloading audio drivers (playback stream is
>>>>>> active)
>>>>>> modprobe -r snd_soc_imx_wm8962
>>>>>> modprobe -r snd_soc_fsl_ssi
>>>>>> modprobe -r snd_soc_wm8962
>>>>
>>>>> The root problem is that you can unload the module while playing.
>>>>> The corresponding module refcounts should have been increased during
>>>>> used.
>>>>
>>>>> Do we miss [try_]module_get() somewhere in ASoC?
>>>>
>>>> That doesn't help, users can still forcibly unbind the driver at runtime
>>>> without loading the module - and there's always the potential for
>>>> actually hotpluggable hardware.  The teardown paths should be able to
>>>> cope somewhat gracefully.
>>>
>>> The module refcount has to be handled while being used for stopping
>>> module unload.  That's irrelevant from the dynamic unbinding support
>>> itself.  Of course, the module refcount doesn't save the world, but
>>> it's the right fix for this particular scenario.
>>
>> Refcounting won't help in this case. The issue is caused by a delayed work
>> item that gets launched when the PCM stream is stopped. So if you decrease
>> the refcount when the stream is stopped you still have a window where it
>> is possible to remove the module while the work is still being scheduled.
>>
>> And while we do flush the scheduled work when we remove the ASoC card this
>> is done before snd_card_free() is called. So when snd_card_free() is
>> called it gets re-scheduled again. I think the correct fix is to add a
>> snd_card_disconnect() at the very top of soc_cleanup_card_resources().
>>
> when stream is active, snd_card_disconnect() will trigger pcm_close() be
> executed by another thread,
> we can't ensure the pcm_close() is executed before the rest of
> soc_cleanup_card_resources().

Hm right, because that only gets called once the userspace application 
finally closes the PCM device. Takashi approach with moving things to the 
card_free callback might work better.

- Lars
