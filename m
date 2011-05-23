From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH] ALSA: HDA: Add jack detection for HDMI
Date: Mon, 23 May 2011 08:29:22 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0498A47F89@HQMAIL01.nvidia.com>
References: <4DD27C43.3050509@canonical.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0498A47E59@HQMAIL01.nvidia.com>
	<4DD75AF5.60209@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id D6DFE2442B
	for <alsa-devel@alsa-project.org>;
	Mon, 23 May 2011 17:29:27 +0200 (CEST)
In-Reply-To: <4DD75AF5.60209@canonical.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

David Henningsson wrote at Saturday, May 21, 2011 12:26 AM:
> On 2011-05-20 23:59, Stephen Warren wrote:
> > David Henningsson wrote at Tuesday, May 17, 2011 7:47 AM:
> >> Just as for headphones and microphone jacks, this patch adds reporting
> >> of HDMI jack status through the input layer.
> >
> > Some of our older HW (MCP6x, MCP7x chipsets) doesn't support unsolicited
> > responses, nor PD/ELDV/ELD data. If PulseAudio is updated to listen to
> > these new jack events on kernels where the input files are present,
> > that'll presumably cause it never to allow use of the HDMI sinks on those
> > chipsets. I don't know if other vendors have this issue or not.
> 
> Ok, thanks for the input (no pun intended ;-) ). If they support
> presence detect, we could create a polling loop. Otherwise, don't create
> the jack.

There's no unsolicited response, nor is there any way to read any of the
PD/ELD data as far as I know, nor any way for the graphics driver to pass
it into the audio HW I presume.

> Is this autodetectable or do we have to quirk it?

The relevant NVIDIA chips have custom .patch functions in
snd_hda_preset_hdmi[], which end up not calling snd_hda_eld_proc_new()
for the pins in question. I note that many of the ATI/AMD codecs are in
the same boat here. Presumably, that function sets up some data structure
that could easily be keyed off of.

-- 
nvpublic
