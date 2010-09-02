From: "Sebastian H." <vand2@gmx.de>
Subject: Re: alsactl adds volume controls?
Date: Thu, 02 Sep 2010 22:28:08 +0200
Message-ID: <4C8008D8.10804@gmx.de>
References: <4C77CE1D.2070501@canonical.com>
	<4C77DD09.3060909@ladisch.de>	<4C78059B.50801@canonical.com>	<AANLkTi=cgE30nh1LPj84=Jv+YfJZWTj8BF3B5kNSGMTb@mail.gmail.com>	<s5h4oec8r6f.wl%tiwai@suse.de>
	<4C7BABA9.1010100@canonical.com>	<s5hlj7ont8e.wl%tiwai@suse.de>	<4C7E549E.4080505@canonical.com>
	<s5hr5hczi06.wl%tiwai@suse.de>	<4C7F6D5D.7020101@canonical.com>	<alpine.LNX.2.00.1009021553460.10278@eeebox2.perex-int.cz>	<4C7FB2CF.5060505@ladisch.de>	<alpine.LNX.2.00.1009021721100.10278@eeebox2.perex-int.cz>	<4C7FC85B.4000009@ladisch.de>
	<alpine.LNX.2.00.1009021926120.10278@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mailout-de.gmx.net [213.165.64.23])
	by alsa0.perex.cz (Postfix) with SMTP id 5624824334
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Sep 2010 22:28:50 +0200 (CEST)
In-Reply-To: <alpine.LNX.2.00.1009021926120.10278@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Am 02.09.2010 19:28, schrieb Jaroslav Kysela:
> On Thu, 2 Sep 2010, Clemens Ladisch wrote:
> 
>> Jaroslav Kysela wrote:
>>> On Thu, 2 Sep 2010, Clemens Ladisch wrote:
>>>> What is the reason for alsactl not trying to restore inactive controls?
>>>
>>> Most (maybe all - need to check drivers) of inactive control values are
>>> reset to the original value when they're going to the active state.
>>
>> (There are both kinds of inactive controls.)
>>
>> It wouldn't hurt to restore controls that will be reset later.
>>
>>> Maybe we need to add another flag - inactive but persistent.
>>
>> This is more or less implied by the current documentation:
>> /* control does actually nothing, but may be updated */
>>
>> I'd rather add a flag for controls that will be reset by the driver,
>> because this is an action that is done in addition to the 'normal'
>> control behaviour.
>>
>> One could also say that inactive controls that will be reset have a
>> value only as long as they are active, i.e., while inactive, there is
>> no current value.  In other words, while inactive, they should be
>> neither readable nor writable.  (Hmm, one could make them just readonly
> 
> Another good idea.
> 
>> to avoid problems due to unexpected error codes in mixer applications,
>> but the last value that it had before becoming inactive isn't likely to
>> be interesting to anyone.)
> 
> The read only value can be used with a monitoring application to set the 
> original value back for a reason.
> 

Hello
(this may be a bit off topic)

Working on the alsamixer-qt4 application I found that something like
snd_mixer_selem_is_writable ( ... )
or
snd_mixer_selem_is_readable ( ... )
would be quite useful.

E.g. there are elements like "Equalizer Peaks"
or there could be elements like "Headphones plugged in"
that are only meant to be read.
But right now there's no way to tell from the snd_mixer_selem_* API
if an element/channel is read-only.
In alsamixer-qt4 this can cause floods of error messages
when a GUI-Widget tries to write to such an element.

Thinking of "Equalizer Peaks" also something like
snd_mixer_selem_needs_poll ( ... )
or maybe
snd_mixer_selem_is_volatile ( ... )
would be interesting to know about for a mixer application.

My two cents for a snd_mixer_selem_* wishlist ;-)

Regards,
Sebastian H.
