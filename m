From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Jack event API - decision needed
Date: Wed, 29 Jun 2011 08:13:42 +0100
Message-ID: <4E0AD0A6.7010901@canonical.com>
References: <4DFF4D15.6050809@canonical.com>	<20110627120743.GA20707@sirena.org.uk>	<4E0A00E3.5000102@canonical.com>
	<s5hr56dykve.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 1D0A224712
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Jun 2011 09:13:47 +0200 (CEST)
In-Reply-To: <s5hr56dykve.wl%tiwai@suse.de>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Kay Sievers <kay.sievers@vrfy.org>, Lennart Poettering <lennart@poettering.net>
List-Id: alsa-devel@alsa-project.org

On 2011-06-28 17:35, Takashi Iwai wrote:
> At Tue, 28 Jun 2011 17:27:15 +0100,
> David Henningsson wrote:
>>
>> On 2011-06-27 13:07, Mark Brown wrote:
>>> On Mon, Jun 20, 2011 at 03:37:25PM +0200, David Henningsson wrote:
>>>
>>>> 1) We're continuing the path with /dev/input devices
>>>
>>>> 2a) We'll rewrite these devices to be read-only ALSA mixer controls
>>>
>>>> 2b) We'll rewrite these devices to be something within ALSA, but not
>>>> exactly mixer controls.
>>>
>>>> For options 2a) and 2b) I guess the existing /dev/input thing should be
>>>> deprecated and/or removed. So part of decision should maybe be based on
>>>> information about how widespread the usage of these devices are
>>>> currently...?
>>>
>>> So, this discussion seems to have ground to a halt.
>>
>> Yes, unfortunately, and without a clear consensus. That puts me in a
>> difficult position, because I'm trying to get the job done. And very
>> preferrable, in the next release of Ubuntu (which is to be released on
>> October this year). I've been talking to a few of my colleagues here at
>> Canonical, and here's how we reason currently:
>>
>> We have the input layer. We also have a set of patches for supporting
>> this in PulseAudio (although currently unmerged and I'm not sure about
>> their current quality/state).
>
> So, the targets are already defined, i.e. what information is actually
> required?  This wasn't very clear to me until now.

Well, for basic jack detection the current input layer will work. We 
might want to add some more information to it (e g by changing the name 
string or use the additional fields available), but that should not be 
very controversial, I think.

However, if we manage to expose all the routing between PCMs, volume 
controls and ports, we can make an even better PulseAudio, because we 
can solve other problems as well, such as the volume control naming 
problem. But figuring out how to do that in the best way API-wise and so 
on, I guess that will take some time.

>> We don't have the alternative Alsa Control API discussed in this thread.
>> Without taking a stance of whether that would be a better solution or
>> not, designing it will take some time - somewhat depending on the set of
>> problems we're aiming to solve. Regardless, it will definitely not reach
>> the 3.0 kernel (which is what we will ship in the next release of Ubuntu).
>
> If only the same functionality is required as currently done in the
> input-jack layer, re-implementing the jack-detection elements in ALSA
> control API is pretty easy.

Yes, but it is not clear to me that this is the decision, and what we 
actually want to do. So far I have only seen Kay and Lennart advocating 
for it and Mark against it. I started off this thread because I needed a 
decision, but so far no clear decision has been made.

> It means that the control element would
> have some jack name with a location prefix or such, reports the
> current jack status, and notifies the jack change.  That's all.
> Optionally, it can have a TLV data giving the HD-audio jack
> attribute, too.

I guess this will require support in alsa-lib as well then? At least if 
you want to pass through new types of TLV data.

> As already mentioned, the difficulties of implementation mainly
> depends on the requirements.  If just a flat array without structural
> connection is enough, it's easy, of course.
>
> But, it definitely won't reach to 3.0 kernel.  So, maybe this won't
> help in your case, anyway...

Well, if the changes are not too invasive, there is also the possibility 
to backport things into the Ubuntu version of the 3.0 kernel as well.

-- 
David Henningsson
http://launchpad.net/~diwic
