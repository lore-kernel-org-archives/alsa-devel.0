From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [RFC PATCH] Inverted internal mic
Date: Tue, 28 Feb 2012 15:19:16 +0100
Message-ID: <4F4CE264.7040008@canonical.com>
References: <4F4C9714.1080307@canonical.com> <s5haa43ux7u.wl%tiwai@suse.de>
	<4F4CA438.90103@canonical.com> <s5hvcmrp7ji.wl%tiwai@suse.de>
	<4F4CD1AF.2050409@canonical.com> <s5hboojozx7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id 8619E24675
	for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2012 15:19:18 +0100 (CET)
In-Reply-To: <s5hboojozx7.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, kailang@realtek.com, 903853@bugs.launchpad.net
List-Id: alsa-devel@alsa-project.org

On 02/28/2012 02:22 PM, Takashi Iwai wrote:
> At Tue, 28 Feb 2012 14:07:59 +0100,
> David Henningsson wrote:
>> Ok. My question was more about the following: When I look at
>> patch_realtek.c, I can find functions alc271_fixup_dmic and
>> alc269_fixup_stereo_dmic. I have also seen machines having ALC268 and
>> ALC272X that have this internal mic behaviour. Is there a way we can
>> know the corresponding processing coefficients to set for ALC268 and
>> ALC272X as well?
>
> AFAIK, no, it was specific to the codec model.

Ok, then we can only hope for Kailang to supply this information if 
possible. And if not possible we could attempt the workaround (when/if 
we agree on it...) for these devices as well?

>>> Note that in alsa-lib, the HD-audio "default" is already set up to
>>> copy left-channel for mono streams.  You can see a line setting
>>> "route_policy" to "copy" in HDA-Intel.conf.
>>>
>>> Thus, when ALSA apps run without PA, it'd work in both stereo and
>>> mono.
>>
>> Assuming the right channel is muted, yes. But not in the current
>> implementation.
>
> It should work no matter whether the right channel is muted or not.
> The plug layer will use only the left channel when a mono stream is
> recorded  since route_policy=copy is set.  Remember that it's about
> "default" PCM, not about "hw" PCM that PA uses.  We don't touch "hw"
> intentionally because it's really intended to be a raw access.

I'm talking about recording an internal mic in *stereo*, as I just wrote 
below. Or don't you agree that is a valid and probably fairly common use 
case?

>> By not making a change in the ALSA layer, it will still be broken for
>> any ALSA apps who record the Internal Mic as a stereo signal. They will
>> get a broken result as the right channel will be phase inverted. That's
>> why I think this is better dealt with in the ALSA layer.
>> Would a zeroed right channel be less broken than a phase inverted right
>> channel? I think so.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
