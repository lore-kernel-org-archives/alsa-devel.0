From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: devices/subdevices, hw:/plughw:
Date: Sat, 21 Sep 2002 07:44:20 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0209210741360.503-100000@pnote.perex-int.cz>
References: <3D8B5A8E.7000709@boosthardware.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3D8B5A8E.7000709@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: Florian Bomers <Florian.Bomers@sun.com>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 21 Sep 2002, Patrick Shirkey wrote:

> Florian Bomers wrote:
> > (I initially posted this to alsa-user without answers. Hope to get more lucky
> > here...)
> > 
> > Hi,
> > 
> > sorry for those general questions, but I wasn't able to find anything on the
> > archives or in the ALSA documentation.
> > 
> > What is the meaning of devices vs. subdevices ? What is an example where a
> > device would have several subdevices, as opposed to the card having several
> > devices ? 
> 
> A card is a device. The available pcm channels are sub devices.

Not really. A card can have several PCM devices. Each PCM device can have 
1-N PCM subdevices (where N is not limited). Note that each subdevices 
should have same parameters. Mostly, subdevices are used for cards 
allowing multi-open (hardware sample mixing).

> yes plughw:0,0 is the same as hw:0,0 but with automatic sample rate 
> conversion.

Right.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
