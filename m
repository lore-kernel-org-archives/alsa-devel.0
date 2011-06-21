From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Jack event API - decision needed
Date: Tue, 21 Jun 2011 08:57:39 +0200
Message-ID: <4E0040E3.9090309@canonical.com>
References: <csg7ltyo2ntnnwkjy445wvqj.1308577935731@email.android.com>	<BANLkTin7K_qO3ejJhOswjSjrLVh0cN2_Wg@mail.gmail.com>	<s5hoc1s4iu3.wl%tiwai@suse.de>
	<4DFF904E.3090802@canonical.com>
	<20110621002917.GF1905@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 8955410390D
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Jun 2011 08:57:41 +0200 (CEST)
In-Reply-To: <20110621002917.GF1905@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Kay Sievers <kay.sievers@vrfy.org>, Lennart Poettering <lennart@poettering.net>
List-Id: alsa-devel@alsa-project.org

On 2011-06-21 02:29, Mark Brown wrote:
> On Mon, Jun 20, 2011 at 08:24:14PM +0200, David Henningsson wrote:
>
>> Exposing what mixers affect this port is highly desirable as well to
>> get more accurate than the current name-based algorithm Pulseaudio
>> currently uses.
>
> Of course given the potential for internal routing within the card you
> can only really say that about the very edge controls that are fully
> committed to a given path - hence my comment about exposing the all the
> routing being much better.

I'm ok with exposing all the routing. Perhaps we could then add some 
convenience functions in alsa-lib (and/or UCM?) that makes it easier for 
applications to figure out what they need to know without having to 
parse the entire graph.

>> Should we design something new, I think we should start with a
>> pin/port concept rather than a jack concept. "Internal speaker"
>> would then be a port that does not have a jack, whereas "Headphone"
>> would be a port that has a jack.
>
> I think that's too edge node focused, if we're going to define new
> interfaces we may as well cover everything rather than doing half the
> job.

Rather, the ports are what we're missing. We already have PCM devices 
(which correspond to the DAC nodes) and mixer controls, so the ports are 
the only objects/nodes we're missing.

Maybe there are some other type of objects we're missing as well, but I 
don't think they're as common or important.

We're also missing the links between the nodes (it's partially exposed 
through the mixer control naming, but that's error prone).

>> (Btw, I don't know much about DAPM and how well that scales to cope
>> with these requirements, it looks very ASoC to me, but perhaps it's
>> just the SND_SOC_DAPM_* naming that fools me. But can DAPM e g send
>> events to userspace?)
>
> No, there is no userspace visiblity of the routing map.  It's pretty
> much exactly equivalent to the data HDA CODECs expose but shipped in
> source rather than parsed out of the device at runtime.

Sorry, I mixed up DAPM and the Media Controller API, but they seem 
partially overlapping to me (both are supposed to expose this codec graph).

So, if we were to use the new Media Controller API (which I think you 
have suggested?), could you explain a little where the 
boundaries/intersections between this API and the current objects (ALSA 
PCM objects, ALSA mixer control objects) would be, and how the Media 
controller API would interact with the existing ALSA APIs?

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
