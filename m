From: Nigel Henry <cave.dnb2m97pp@aliceadsl.fr>
Subject: Re: Can this be a driver problem? Sound works fine for
	ogg
Date: Sun, 18 Nov 2007 21:24:31 +0100
Message-ID: <200711182124.31705.cave.dnb2m97pp@aliceadsl.fr>
References: <74eb4bb50711170840j5c7de9bk374f02f1bb02a801@mail.gmail.com>
	<74eb4bb50711180948i33b7d7e6k9d222e840478f4d8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.libertysurf.net (mx-out.libertysurf.net [213.36.80.91])
	by alsa0.perex.cz (Postfix) with ESMTP id 16A39245E8
	for <alsa-devel@alsa-project.org>; Sun, 18 Nov 2007 21:24:35 +0100 (CET)
Received: from [192.168.0.230] (213.36.0.193) by mail.libertysurf.net
	(7.3.118.8) id 471E04100040E16C for alsa-devel@alsa-project.org;
	Sun, 18 Nov 2007 22:27:48 +0100
In-Reply-To: <74eb4bb50711180948i33b7d7e6k9d222e840478f4d8@mail.gmail.com>
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sunday 18 November 2007 18:48, alsa-devel.20.pris@spamgourmet.com wrote:
> > The thing is, on my system(Ubuntu Gutsy Gibbon) I get perfect sound
> > playing the example ogg files that come with the system. The system
> > sounds seem to work fine also. But I have problems when trying to
> > listen to avi or mp3 files. Can this still be an Alsa problem or is
> > this a problem of some incorrect configuration?
>
> The problems I have with avi files are: sound is very low and
> distorted. Interestingly this varies with the AVI files. There are
> some files where the sound is better, others are so bad that I can
> barely understand what is being said.

Hi. I've seen a few problems with sound on Gutsy Gibbon, and unresolved. Would 
you be kind enough to post the output of.
cat /proc/asound/version
and
uname -r   (for the kernel version)

Also, which laptop, pc, mobo is this soundcard installed on?

I only ask because amongst other distros, I only have Kubuntu Dapper 
installed, and would like to know which alsa driver comes as standard with 
Gutsy Gibbon.

Moving on to your problems. Which app are you using to play the .avi, 
and .mp3's?

I ask because I've seen folks having problems with Mplayer.

For playing .ogg, and .mp3 files I use MhWaveedit.
https://gna.org/projects/mhwaveedit/

It's a tarball . No forget that. I've just booted up Kubuntu Dapper, and see 
that it's available from the Kubuntu repo's, and I have it installed, so 
should pull in all the dependencies with no problems.

If you want to try out a few .oggs, or mp3's, try the link below. Not my 
stuff, but someone on the LAU list.

http://www.musically.me.uk/updates.html

Nigel.
