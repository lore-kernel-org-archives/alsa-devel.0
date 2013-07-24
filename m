From: Richard Ash <richard@audacityteam.org>
Subject: Re: [Audacity-devel] Questions about virtual ALSA
 driver (dummy), PortAudio and full-duplex drops
Date: Wed, 24 Jul 2013 19:30:29 +0100
Message-ID: <20130724193029.530a9958@scouthead>
References: <51EF41C8.2040701@imi.aau.dk>
Reply-To: Portaudio Mailing List <portaudio@music.columbia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <portaudio-bounces@music.columbia.edu>
In-Reply-To: <51EF41C8.2040701@imi.aau.dk>
List-Unsubscribe: <http://music.columbia.edu/mailman/options/portaudio>,
	<mailto:portaudio-request@music.columbia.edu?subject=unsubscribe>
List-Archive: <http://music.columbia.edu/pipermail/portaudio>
List-Post: <mailto:portaudio@music.columbia.edu>
List-Help: <mailto:portaudio-request@music.columbia.edu?subject=help>
List-Subscribe: <http://music.columbia.edu/mailman/listinfo/portaudio>,
	<mailto:portaudio-request@music.columbia.edu?subject=subscribe>
Errors-To: portaudio-bounces@music.columbia.edu
Sender: portaudio-bounces@music.columbia.edu
To: alsa-devel@alsa-project.org, portaudio@music.columbia.edu, audacity-devel@lists.sourceforge.net
Cc: sd@imi.aau.dk
List-Id: alsa-devel@alsa-project.org

On Wed, 24 Jul 2013 04:54:00 +0200
Smilen Dimitrov <sd@imi.aau.dk> wrote:

> I ran this on Ubuntu 11.04 Natty, Linux 2.6.38 and corresponding ALSA
> 1.0.24.2, audacity-1.3.13, PortAudio V19 - more about my machine and
> environment setup is in the Readme:
> 
>     http://sdaaubckp.sourceforge.net/post/alsa-patest-duplex/Readme

Please don't use such an old version of Audacity - we have updated our
Portaudio snapshot significantly since then. Bugs in obsolete code
really aren't interesting.

> In Audacity, as far as I could see, there is only one PortAudio
> callback defined (audacity-1.3.13/src/AudioIO.cpp has
> audacityAudioCallback;), so Audacity basically has a single "wire"
> callback for full-duplex.
Correct.

I can't help with anything else, sorry, except to agree with Alan that
you need to take as much as possible out of the equation to start with
- and that certainly means Audacity. If at all possible, use current
 versions of software, and a set-up that others can replicate as much
 as possible.

Richard
