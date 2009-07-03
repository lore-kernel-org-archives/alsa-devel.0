From: Daniel Drake <dsd@laptop.org>
Subject: Re: Conexant CX20582 HDA codec support
Date: Fri, 03 Jul 2009 21:05:37 +0100
Message-ID: <1246651537.2174.86.camel@polyethylene>
References: <1246277454.2182.6.camel@polyethylene>
	<20090629122625.GF11855@sirena.org.uk> <s5htz1znr3r.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f226.google.com (mail-ew0-f226.google.com
	[209.85.219.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 39A1E103956
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Jul 2009 22:05:42 +0200 (CEST)
Received: by ewy26 with SMTP id 26so2972247ewy.32
	for <alsa-devel@alsa-project.org>; Fri, 03 Jul 2009 13:05:41 -0700 (PDT)
In-Reply-To: <s5htz1znr3r.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On Mon, 2009-06-29 at 14:48 +0200, Takashi Iwai wrote:
> At Mon, 29 Jun 2009 13:26:26 +0100,
> Mark Brown wrote:
> > 
> > On Mon, Jun 29, 2009 at 01:10:53PM +0100, Daniel Drake wrote:
> > 
> > > 1. Volume range is ridiculous, you can go all the way down to -74dB
> > > gain.  Beyond -42dB you can barely hear anything from the speakers, and
> > > I note that all my other systems only go down as far as -46.5dB.
> > 
> > This is normally just a case of drivers exposing whatever control they
> > get from the hardware.  Devices will often expose very high degrees of
> > attenuation since they're doing it anyway in order to implement the mute
> > functionality.
> 
> Yep.  There are some workaround for each codec chip.
> See create_controls_idx() in patch_sigmatel.c, for example.

Great.
Do you have any other examples?
This does not seem so easy for a non-virtual master.

This is my kcontrol for master:
	HDA_CODEC_VOLUME("Master Playback Volume", 0x10, 0x00, HDA_OUTPUT),

Thanks,
Daniel
