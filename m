From: Mark Hills <mark@pogo.org.uk>
Subject: When to use sub-devices? (was Re: USB audio devices on
 Audio 4DJ and similar)
Date: Mon, 16 Apr 2012 21:55:54 +0100 (BST)
Message-ID: <1204091942090.26902@vega>
References: <201204062209.21564.gineera@aspect135.co.uk>
	<4F819CBD.2010809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wes.ijneb.com (mx.ij.cx [212.13.201.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 853E42437C
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Apr 2012 22:55:56 +0200 (CEST)
In-Reply-To: <4F819CBD.2010809@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, 8 Apr 2012, Daniel Mack wrote:

> Hi Alan,
> 
> On 06.04.2012 23:09, Alan Horstmann wrote:
> > At present I am involved with resolving some issues that have arisen from 
> > people using the Audio 4DJ interface with Portaudio, and I hoped it would be 
> > OK to check a few Alsa details with you?  Unfortunately I have limited 
> > experience of USB audio.
> 
> What are those issues? Can you elaborate?
> 
> > Apparently the 4 audio inputs/outputs appear as 2 stereo sub-devices on the 
> > first device, rather than a single 4-channel device - is this correct?
> 
> Yes.
> 
> > Assuming that is correct, does that arise as a result of the intrinsic nature 
> > of the interface, or is it by developer choice in the driver (for example so 
> > that it can be opened as 2 stereo streams)?   Is there (or could there be) a 
> > way to change this, eg by module option or udev rule?  I notice in the source
> >     #define CHANNELS_PER_STREAM  2
> 
> The device itself implements 4 audio channels which are synced to each
> other. In other words: the hardware is not able to only enable one of
> them and leave the other ones paused or set sample rates individually.
> 
> When I implemented the driver, it seem most logical to follow the way
> the device denotes it channels though. The documentation and silk screen
> presents them as pairs of stereo, and so the driver does the same thing.
> 
> > Is there a way at present that the device can be accessed as a single 
> > 4-channel stream other than by creating a custom ~asoundrc with a pcm 
> > definition using 'multi' to join the 2 stereo streams?
> 
> No, you would need to join them in software. But as all inputs and
> outputs share a single clock domain, there won't be any drift between
> them that need special attention.

I am interested in this too; what is the 'official' or proper definition 
of a subdevice in ALSA and where should they be used?

It feels like there are many different interpretations.

The Audio4DJ and other snd-usb-caiaq devices are easier for general use 
because of the sub-devices -- multiple stereo ins/outs, each on a 
subdevice.

Whereas snd-usb-audio presents all channels on one, which then have to be 
split using asoundrc files [1].

Different software prefers separate devices (eg. xwax) or a single wide 
one (eg. Mixxx)

Is it possible (or sensible) to have both co-exist? Perhaps one covering 
the whole interface, the other covering the default 'logical' layout.

Yet another example is Echo Layla3G, which presents 8 inputs on 8 
subdevices which overlap:

               hardware channels
                0 1 2 3 4 5 6 7
             ,0 x x x x x x x x
             ,1   x x x x x x x
             ,2     x x x x x x
       sub-  ,3       x x x x x
      device ,4         x x x x
             ,5           x x x
             ,6             x x
             ,7               x

Opening .0 with 2 channels only disables .1. So you can open stereo pairs 
by opening 2 channels at each of:

  hw:Layla3G,0,0
  hw:Layla3G,0,2
  hw:Layla3G,0,4
  etc.

and mono channels by opening

  hw:Layla3G,0,0
  hw:Layla3G,0,1
  hw:Layla3G,0,2
  etc.

This is very useful, but feels more 'clever' rather than the use 
originally intended.

ALSA and asoundrc is flexible enough to deal with all these cases, but it 
can be rather confusing for users.

[1] http://www.pogo.org.uk/~mark/linuxdj/

-- 
Mark
