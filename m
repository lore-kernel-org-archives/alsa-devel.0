From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Help with supporting Emu10k1x  and question
Date: Sun, 22 Feb 2004 08:58:32 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0402220857560.1872@pnote.perex-int.cz>
References: <BAY10-F84ueolj8Jecd00000c83@hotmail.com> <40380089.9040806@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <40380089.9040806@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, 22 Feb 2004, James Courtier-Dutton wrote:

> Bastien Aracil wrote:
> > At Mon, 16 Feb 2004 18:39:46 -0500,
> > Francisco Moraes wrote:
> > 
> >> I am trying to get the Emu10k1x chip supported in alsa. Anyone willing 
> >> to give me a hand, please > email me. I've got a few register dumps 
> >> and I am trying to get it working.
> > 
> > 
> > I'm will be pleased to help you. I got recently a SB Live 5.1! from DELL 
> > and so have no sound with Linux. I'm not an expert of sound card driver 
> > put I'm motivated to make mine working under linux.
> > 
> > Let me known what I can do
> > 
> > Bastien
> > 
> 
>  From what I can see for the emu10k1x (aka. sb Live 5.1 from Dell) is 
> almost exactly the same as the Audigy LS.
> 
> It is a very simple device, and the driver should be based more like the 
>   snd-intel8x0 driver than the snd-emu10k1 driver.
> It has no dsp, and no hardware mixing, and is a single open device. 
> Very similar to the intel8x0 feature wise.
> 
> If someone will send me a sample sound card, I will get it working.

Do you have any information about this hardware? Datasheet or sources or 
something else? I am very interested.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
