From: Eliot Blennerhassett <eblennerhassett@audioscience.com>
Subject: Re: asihpi: Control naming
Date: Fri, 01 Oct 2010 09:23:52 +1300
Message-ID: <4CA4F1D8.50800@audioscience.com>
References: <4CA4078E.6010601@audioscience.com> <s5h62xng4wm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 8E6F5103969
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Sep 2010 22:24:04 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1P1Pfe-0005GK-VA
	for alsa-devel@alsa-project.org; Thu, 30 Sep 2010 22:24:02 +0200
Received: from 121-72-250-62.cable.telstraclear.net ([121.72.250.62])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 30 Sep 2010 22:24:02 +0200
Received: from eblennerhassett by 121-72-250-62.cable.telstraclear.net with
	local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 30 Sep 2010 22:24:02 +0200
In-Reply-To: <s5h62xng4wm.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Cc: Eliot Blennerhassett <linux@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks Takashi,

On 30/09/10 18:46, Takashi Iwai wrote:
> At Thu, 30 Sep 2010 16:44:14 +1300,
> Eliot Blennerhassett wrote:
>>
>> Hi all,
>>
>> I'm struggling with getting the correct names for controls, so that they
>> show up correctly in the Playback or Capture modes of alsamixer
>>
>> E.g. "PCM 3 Capture Meter" appears in the playback controls?
>>
>> How is capture vs playback display determined?
>> or to put it another way: What are the rules for creating control names.
> 
> The rule is simple.  The control name consists of three parts,
> base-name, direction, and suffix.  The direction is either "Playback"
> or "Capture", and the suffix is either "Volume" or "Switch".
> Then the direction and the capture are omitted, and grouped together
> with other controls with the same base name.
> (There are a few exceptional cases, but in general the rule above is
>  applied.)
> 
> "PCM 3 Capture Meter" is regarded as a playback control since it has
> an invalid (unknown) suffix.  If it's "PCM 3 Meter Capture Volume",

But it is not a volume, it is a level meter?!
We also have controls for tuners, microphones, equalizers, sampleclocks
etc.  Surely these can't be all "Volume" or "Switch"
I'm not sure why the suffix has any bearing on the direction?

> in mixer, it'll become "PCM 3 Meter".  Also, you can (better to) use
> an index for each control, so it can be expressed as "PCM Meter" with
> index 3, too.

We used to have it this way.
It makes sense for the controls attached to the single node e.g. player
or lineout.
However, it is confusing for identifying the volumes between play1 and
lineout0?

Without using indices I have (consistent)

PCM 0 Playback Volume
PCM 1 Playback Volume
PCM 0 to Lineout 0 Playback Volume
PCM 0 to Lineout 1 Playback Volume
PCM 1 to Lineout 0 Playback Volume
PCM 1 to Lineout 1 Playback Volume
Lineout 0 Playback Volume
Lineout 1 Playback Volume

with indices (maybe)
PCM Playback Volume, 0
PCM Playback Volume, 1
PCM 0 to Lineout 0 Playback Volume
PCM 0 to Lineout 1 Playback Volume
PCM 1 to Lineout 0 Playback Volume
PCM 1 to Lineout 1 Playback Volume
Lineout Playback Volume, 0
Lineout Playback Volume, 1

Now, if I could have 2 indices, maybe ...
PCM to Lineout Playback Volume, 1, 0

Also, on the input multiplexer (route?), the options are
Linein 0
Linein 1

rather than
Linein, 0
Linein, 1


I.e. the names match, rather than using indices in one place, and
distinct names in another
