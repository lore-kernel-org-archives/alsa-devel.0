From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: multiple devices per card?
Date: Sat, 5 Oct 2002 09:14:47 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0210050910140.504-100000@pnote.perex-int.cz>
References: <3D9DF89B.8090604@boosthardware.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3D9DF89B.8090604@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: Guilhem Tardy <guilhem_tardy@yahoo.com>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 5 Oct 2002, Patrick Shirkey wrote:

> Guilhem Tardy wrote:
> > Hi,
> > 
> > I am unsure what makes the most sense for multiple pcm channels on the same
> > card:
> >  a) N devices, 1 pcm channel each
> >  b) 1 device, N pcm channels each
> > 
> > In the same vein, is the mixer always one per card?
> > 
> 
> well if we have hw:0,0 hw:0,1 hw:0,2
> 
> Then it looks like option b to me. But Jaroslav confused me recently by 
> saying something that sounded like a is the case.

Nope. If channels are linked together in hardware, they should be used as 
one device. I think that our discussion was about subdevices. Here is the 
hiearchy:

card -+- device -+- subdevice
      |          |
      |          +- subdevice
      |          |
      |          ...
      |
      +- device -+- subdevice
      |          |
      |          ...
      |
      ...

In PCM API, there might be several PCM devices and several subdevices per 
a PCM device. The subdevices are used mostly for multi-open hardware, but 
if hardware offers for example 512 independent stereo streams with 1024 
discrete hardware outputs, it could use subdevices as well, because we 
have limited count of devices.

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
