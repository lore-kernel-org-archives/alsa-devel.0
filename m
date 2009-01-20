From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: [PATCH 1/2] Remove definition for surround sound
	devices on ICE1712.
Date: Tue, 20 Jan 2009 15:26:51 +0000
Message-ID: <200901201526.51060.gineera@aspect135.co.uk>
References: <1232455075-27712-1-git-send-email-flameeyes@gmail.com>
	<Pine.LNX.4.61.0901201434500.8466@tm8103.perex-int.cz>
	<m2iqoa9jem.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (smtp-out-2.talktalk.net [62.24.128.232])
	by alsa0.perex.cz (Postfix) with ESMTP id D8C5F1037E3
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2009 16:10:12 +0100 (CET)
In-Reply-To: <m2iqoa9jem.fsf@gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: flameeyes@gmail.com
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tuesday 20 January 2009 13:49, Diego E. 'Flameeyes' Petten=F2 wrote:
> Jaroslav Kysela <perex@perex.cz> writes:
> > Do you have seen M-Audio Delta 1010 ?

Or DMX6fire, or Hoontech/ST.Audio dsp2000, or rest of a list... It seems to=
 me =

that only a few cut-down card versions have only 2 analogue in/out.

> Still, as they are the devices are non-functional at least on my card,
> and I'm ready to bet that the same would happen on the Delta 1010 given
> that the number of channels is not coherent (you try to open surround71
> as 8-channels and it'll fail because this minimal card has 10; if the
> 1010 has the same amount of channels, it'll still fail).

Here (on a rather old Alsa version)  on DMX6fire:

aplay -Dfront try1.wav

does fail unless try1.wav is a 10-channel file, whereupon just the first 2 =

channels play out.  A standard stereo wav file fails with a sample format =

error.  So there is something not quite right with the config files.

Does the surround and front both need the asym slave.format & slave.channel=
s =

definitions?  Right now I can't do further testing; maybe later.

Alan
