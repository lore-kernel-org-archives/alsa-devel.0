From: Howard Mitchell <hm@hmbedded.co.uk>
Subject: Re: pcm512x driver: Mixer control naming issue
Date: Sun, 15 Mar 2015 22:28:01 +0000
Message-ID: <55060771.7060200@hmbedded.co.uk>
References: <5500DE5B.2020401@hmbedded.co.uk> <5502DAE1.30609@hmbedded.co.uk>
 <20150313182729.GE28806@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avasout02.plus.net (avasout02.plus.net [212.159.14.17])
 by alsa0.perex.cz (Postfix) with ESMTP id E24DB26046A
 for <alsa-devel@alsa-project.org>; Sun, 15 Mar 2015 23:28:03 +0100 (CET)
In-Reply-To: <20150313182729.GE28806@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Gordon Garrity <gordon.garrity@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 13/03/15 18:27, Mark Brown wrote:
> On Fri, Mar 13, 2015 at 12:41:05PM +0000, Howard Mitchell wrote:
>
>> Boost Volume) provides a boost of +0.8dB. The hardware reset value of both
>> of these gain controls is 0dB, however, in the Raspbian distribution
>> 'Playback Volume' is being defaulted to -6dB.
>>   * Either change the names of these controls to something that's not
>>     affected by the alsa restore mechanism,
> You say "these controls" but it seems like only "Playback Volume" has
> a problem?  My first suggestion would be to define "Analog" or
> "Analogue" as a prefix in ControlNames and then use that, that would
> avoid confusing applications while still fittig in with the naming
> convention.
Yes you are correct that it's only "Playback Volume" that is causing a 
problem. However, I included "Playback Boost Volume" as it also provides 
a selection of analogue gain so I think it should be treated similarly 
for consistency.

Defining a new prefix sounds like a reasonable idea in principle but 
calling it "Analog(ue)" seems like it's saying this is a proper analogue 
volume control whereas these particular controls merely provide very 
limited selections of gain. I could imagine that at some point in the 
future a default for "Analogue Playback Volume" may well be added to 
"alsactl restore" and then we end up back in the same situation. How 
about defining a prefix that is documented as saying that a default 
should not be used if there's nothing in asound.state for that control?

>>   * or remove them as mixer controls, but make them accessible some
>>     other way - e.g. device tree.
> It may not be policy that someone wants to tweak at runtime on your
> board but it almost certainly will be on someone's board.
>
Fair enough, if that's the general alsa ethos I'm happy to go along with it.
