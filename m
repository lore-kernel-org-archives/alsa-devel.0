From: Anders Torger <torger@ludd.luth.se>
Subject: Re: Re: Digital sound card conventions
Date: Fri, 3 Jan 2003 22:27:47 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301032227.47848.torger@ludd.luth.se>
References: <Pine.LNX.4.33.0301032118550.500-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.it4u.net (mail.it4u.net [81.8.150.196])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id WAA07870
	for <alsa-devel@alsa-project.org>; Fri, 3 Jan 2003 22:28:20 +0100
In-Reply-To: <Pine.LNX.4.33.0301032118550.500-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Friday 03 January 2003 21.33, Jaroslav Kysela wrote:
> On Fri, 3 Jan 2003, Anders Torger wrote:
> > I'm doing a maintenance update on the rme96 driver, and I wonder if
> > there are any conventions to follow in the driver concerning
> > digital sound cards.
> >
> > The specific questions are how to handle sample rates and sound
> > formats on the input.
> >
> > The sound card supports several sample rates and formats. What
> > should happen if the user tries to open the input with 48000 kHz
> > ADAT, but the format is actually 44100 kHz and SPDIF? I can allow
> > it if I want to, the user will get data, but at 48000 kHz of
> > course.
> >
> > What should happen when there is no input signal at all? The
> > hardware supports opening the input, but should I do so in the
> > driver?
> >
> > The signal can of course change in runtime as well...
> >
> > I'm thinking of allowing it all, but I don't know if that is the
> > right way to go.
>
> This part of PCM API has not been discussed. I think that we should
> follow the most easy way: It is - allow only sample rate given by
> application, if the master clock is using another sample rate - in
> trigger() callback - driver will fail. Also it will fail, when sample
> rate is changed during operation. We probably need to add a new PCM
> state -
> SNDRV_PCM_STATE_STREAM_CHANGED (equal to DRAINING, but informative
> for applications). The notification of master clock / sample rate (or
> other parameter) changes should be implemented using the control API.

So what you are saying is, for now, do what is correct at the moment. Is 
this ok:

If no signal on the input - allow to open with any setting the hardware 
supports. The current rme96 driver will return -EIO, but that sucks if 
you're just opening the card to check some parameters, so I plan to 
change that.

If there is a signal on the input, limit the reported sound card 
capabilities to only those currently available on the input, so when 
the sound card is opened for capture, it seems only capable of 48kHz if 
that is the current sample rate.

/Anders Torger


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
