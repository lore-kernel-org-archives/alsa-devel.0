From: Howard Mitchell <hm@hmbedded.co.uk>
Subject: Re: pcm512x driver: Mixer control naming issue
Date: Mon, 16 Mar 2015 09:47:07 +0000
Message-ID: <5506A69B.1010601@hmbedded.co.uk>
References: <5500DE5B.2020401@hmbedded.co.uk>	<5502DAE1.30609@hmbedded.co.uk>	<20150313182729.GE28806@sirena.org.uk>	<55060771.7060200@hmbedded.co.uk>
 <s5h8uexqt8r.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avasout05.plus.net (avasout05.plus.net [84.93.230.250])
 by alsa0.perex.cz (Postfix) with ESMTP id C015F2605C3
 for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2015 10:49:37 +0100 (CET)
In-Reply-To: <s5h8uexqt8r.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Gordon Garrity <gordon.garrity@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 16/03/15 07:47, Takashi Iwai wrote:
> At Sun, 15 Mar 2015 22:28:01 +0000,
> Howard Mitchell wrote:
>> On 13/03/15 18:27, Mark Brown wrote:
>>> On Fri, Mar 13, 2015 at 12:41:05PM +0000, Howard Mitchell wrote:
>>>
>>>> Boost Volume) provides a boost of +0.8dB. The hardware reset value of both
>>>> of these gain controls is 0dB, however, in the Raspbian distribution
>>>> 'Playback Volume' is being defaulted to -6dB.
>>>>    * Either change the names of these controls to something that's not
>>>>      affected by the alsa restore mechanism,
>>> You say "these controls" but it seems like only "Playback Volume" has
>>> a problem?  My first suggestion would be to define "Analog" or
>>> "Analogue" as a prefix in ControlNames and then use that, that would
>>> avoid confusing applications while still fittig in with the naming
>>> convention.
>> Yes you are correct that it's only "Playback Volume" that is causing a
>> problem. However, I included "Playback Boost Volume" as it also provides
>> a selection of analogue gain so I think it should be treated similarly
>> for consistency.
> Did you read Documentation/sound/alsa/ControlNames.txt?
> It shows why "Playback Volume" is taken in that way while "Playback
> Boost Volume" not.  Namely, the latter implies a volume control named
> "Playback Boost" which is applied generically -- i.e. the direction is
> unknown or applied to both playback and capture.
Sorry, what I meant by "treated similarly for consistency" is that 
whatever solution is decided upon to fix the issue with "Playback 
Volume" should also be applied to "Playback Boost Volume".

Your comment about the direction being unknown for "Playback Boost 
Volume" is interesting though as when running alsamixer I find that 
"Playback Volume" is also listed as a capture control. Neither makes 
sense of course as this device does not have a capture path.

- Howard
