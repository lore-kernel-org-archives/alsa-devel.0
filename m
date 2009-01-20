From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 1/2] Remove definition for surround sound
 devices on ICE1712.
Date: Tue, 20 Jan 2009 17:19:40 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0901201718390.8466@tm8103.perex-int.cz>
References: <1232455075-27712-1-git-send-email-flameeyes@gmail.com>
	<Pine.LNX.4.61.0901201434500.8466@tm8103.perex-int.cz>
	<m2iqoa9jem.fsf@gmail.com>
	<200901201526.51060.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id B38151037E3
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2009 17:19:40 +0100 (CET)
In-Reply-To: <200901201526.51060.gineera@aspect135.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alan Horstmann <gineera@aspect135.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, flameeyes@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, 20 Jan 2009, Alan Horstmann wrote:

> On Tuesday 20 January 2009 13:49, Diego E. 'Flameeyes' Petten? wrote:
> > Jaroslav Kysela <perex@perex.cz> writes:
> > > Do you have seen M-Audio Delta 1010 ?
> 
> Or DMX6fire, or Hoontech/ST.Audio dsp2000, or rest of a list... It seems to me 
> that only a few cut-down card versions have only 2 analogue in/out.
> 
> > Still, as they are the devices are non-functional at least on my card,
> > and I'm ready to bet that the same would happen on the Delta 1010 given
> > that the number of channels is not coherent (you try to open surround71
> > as 8-channels and it'll fail because this minimal card has 10; if the
> > 1010 has the same amount of channels, it'll still fail).
> 
> Here (on a rather old Alsa version)  on DMX6fire:
> 
> aplay -Dfront try1.wav
> 
> does fail unless try1.wav is a 10-channel file, whereupon just the first 2 
> channels play out.  A standard stereo wav file fails with a sample format 
> error.  So there is something not quite right with the config files.

Note that front and surround devices does not support automatic sample 
conversion. Use plug:front, plug:surround40 etc. devices.

					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
