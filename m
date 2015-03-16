From: Howard Mitchell <hm@hmbedded.co.uk>
Subject: Re: pcm512x driver: Mixer control naming issue
Date: Mon, 16 Mar 2015 17:37:28 +0000
Message-ID: <550714D8.5060407@hmbedded.co.uk>
References: <5500DE5B.2020401@hmbedded.co.uk> <5502DAE1.30609@hmbedded.co.uk>
 <20150313182729.GE28806@sirena.org.uk> <55060771.7060200@hmbedded.co.uk>
 <20150316113845.GM28806@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avasout05.plus.net (avasout05.plus.net [84.93.230.250])
 by alsa0.perex.cz (Postfix) with ESMTP id AF685261489
 for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2015 18:40:04 +0100 (CET)
In-Reply-To: <20150316113845.GM28806@sirena.org.uk>
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



On 16/03/15 11:38, Mark Brown wrote:
> On Sun, Mar 15, 2015 at 10:28:01PM +0000, Howard Mitchell wrote:
>
>> Defining a new prefix sounds like a reasonable idea in principle but calling
>> it "Analog(ue)" seems like it's saying this is a proper analogue volume
>> control whereas these particular controls merely provide very limited
>> selections of gain. I could imagine that at some point in the future a
> Userspace can determine how much control there is from the TLV
> information.  Ideally a smart userspace will manage to combine all the
> different controls it finds to make the best use it can of them - if it
> can use analogue volume control for some of the control that's generally
> better since it maximizes the resolution of the digital parts.

Makes sense.
>> default for "Analogue Playback Volume" may well be added to "alsactl
>> restore" and then we end up back in the same situation. How about defining a
>> prefix that is documented as saying that a default should not be used if
>> there's nothing in asound.state for that control?
> Really the problem here is using asound.state - it's far too dumb a
> means of controlling random cards, and attempting to change it is most
> likely going to break something else.  Any attempt to introduce a
> default for analogue control will inevitably result in problems on cards
> that currently work fine with digital/default control unless those are
> changed which would then cause problems for things without the analogue
> control.
So it sounds like adding an analogue prefix should be fairly safe in
which case are you happy for me to go ahead and prepare a patch?

- Howard
