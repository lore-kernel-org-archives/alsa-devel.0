From: Oleksij Rempel <linux@rempel-privat.de>
Subject: Re: acceptable noise level for mic boost
Date: Sat, 23 Nov 2013 15:35:04 +0100
Message-ID: <5290BD18.1040401@rempel-privat.de>
References: <528E29CF.3030101@rempel-privat.de>
	<1385138883.2564.8.camel@tkkaskin-mobl2.ger.corp.intel.com>
	<528F958E.4000709@rempel-privat.de>
Reply-To: General PulseAudio Discussion
	<pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <pulseaudio-discuss-bounces@lists.freedesktop.org>
In-Reply-To: <528F958E.4000709@rempel-privat.de>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@lists.freedesktop.org>
List-Help: <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=subscribe>
Sender: pulseaudio-discuss-bounces@lists.freedesktop.org
Errors-To: pulseaudio-discuss-bounces@lists.freedesktop.org
To: Tanu Kaskinen <tanu.kaskinen@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, pulseaudio-discuss@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

Am 22.11.2013 18:34, schrieb Oleksij Rempel:
> Am 22.11.2013 17:48, schrieb Tanu Kaskinen:
>> On Thu, 2013-11-21 at 16:42 +0100, Oleksij Rempel wrote:
>>> Hello all,
>>>
>>> i posted this email to ALSA, but probably PA devs have some ideas too.
>>>
>>> ======================================================================
>>> Hello Takashi,
>>>
>>> what is acceptable noise level for mic boost?
>>> My laptop has three levels of mic boost (+36dB). Level 3 is useless
>>> since noise level will be about 0db. With level 1 i get -12dB noise, so
>>> there is almost 12dB room for data... but it is not enough for normal
>>> speech, which is about 20dB.
>>>
>>> Are there any ALSA guide for HW designers, which will say some thing
>>> like acceptable levels are 90-20dB?
>>> There are some Skype and Microsoft prescriptions for certification.
>>> For example M$ prescribe 18dB or more for speech to noise ration for
>>> build in mics. It sound like good number to start.
>>>
>>> In my case, i need to remove mic boost completely to guarantee minimum
>>> 18dB SpNR. Suddenly i didn't found correct way to do it.
>>> I will be thankful for some tip.
>>>
>>> =====================================================================
>>>
>>> So my question to PA devs. Do pulse audio need to know about noise level
>>> of microphone? Will it help to make correct decisions? Especial for VoIP
>>> and automatic gain control.
>>
>> We don't currently have any idea of the noise level, so we don't have
>> code for adjusting our decisions based on that information either. So,
>> I'd say that pulseaudio doesn't *need* to know about the noise level. Of
>> course, if someone someday complains that pulseaudio does bad decisions
>> because it doesn't take the noise level into account, then we would need
>> that information.
>>
> 
> Thank you for your response.
> I have more questions:
> Skype continuously trying to adjust record level. If there is a silence
> it will try to push the input volume as close to 0dB (in pulseaudio
> terms) as possible.
> For my laptop 0dB(in PA) will mean some thing +68dB over base volume
> (ALSA). The noise will reach 0dBFS.
> Well, it wont kill any one, but it sound bad.
> 
> What 0dB mean in pulseaudio?
> Why pulseaudio has capture volume range -130 - +11dB? Is it possible to
> fit this gain to 16-bit PCM?

to answer this question by my self.
If i understand correctly pulseaudio trying to imitate professional
mixer settings. The difference is, usual mixer has 0dB settings as point
for preconfigured sound. You need to use "Gain" or "Trim" control to
configure it to acceptable level.

0dB in PulseAudio looks for me incorrect, if no preconfigurable available.

Here is one example:
http://www.youtube.com/watch?v=YXSJ1oOQ9tY

> Now to my hardware. I can blacklist in the driver 2 "mic boost" steps
> without introducing any regressions. Which will guaranty maximal noise
> level = -12dBFS. But it is still not optimal. Best experience i had with
> limit to -24dB. In this case i need to remove Mic Boost completely but
> pulseaudio will fail to make a difference between internal and external mic.
> 
> What is best solution in this case? Fix pulse or leave at least one step
> for mic boost?

After some more testing, i'm sure it should be fixed in pulseaudio.
Blacklisting microfone setting is just quick dirty hack. It will work
for internal mic. But fail on external. There is no way, ALSA can
predict some thing about it. The best thing ALSA can do here is to
provide all possible controls.

> The microphone on this laptop is a digital mic. Do it make sense to use
> hardware amp? Or is it possible to get better results with software?

Theoretically, Skype or Empathy or any other app with auto gain control
should us 0dB as target.
But since ALSA or PulseAudio can't automatically detect correct point,
PuleAudio should provide possibility to override 0dB offset.

For build in microphones can be used ALSA quirk list or some kind of
database for pulseaudio with per device default values to make better
default experience.

IMO, current solution with blacklists in ALSA is wrong.
-- 
Regards,
Oleksij
