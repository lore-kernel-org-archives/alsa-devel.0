From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: hardware channel mixing
Date: Fri, 03 Sep 2004 19:30:22 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1094254221.6575.94.camel@krustophenia.net>
References: <Pine.HPX.4.33n.0409031451550.24397-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0409031451550.24397-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Patrick Dumais <pat@dumaisnet.ca>, alsa-devel <alsa-devel@lists.sourceforge.net>, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

On Fri, 2004-09-03 at 08:59, Clemens Ladisch wrote:
> Patrick Dumais wrote:
> > When I read a description of what the soundblaster Live features, I notice
> > they say "131 hardware channels". Now is this what I think it is? does it
> > mean that I can actualy write multiple (upto 131) sounds and let the card
> > mix it by itself?
> 
> Essentially, yes, but the real number is 64 voices, and each stereo
> stream needs two of them, so you can play 32 streams simultaneously.
> 

Not quite, it's 32 mono substreams, 21 stereo.  Each mono substream
requires 2 voices, each stereo substream, three.  There is an extra
voice allocated per playback substream that is silent, and is just used
to generate the period interrupts.

I have pored over the code, and I don't understand exactly why the extra
voice is needed, Jaroslav said something like "if you don't use the
extra voice the interrupts are going faster than the voice position".  I
think it might be needed so that multiple can playback, each with
different period sizes.

There is currently no way to open an 8 or 16 channel playback
substream.  There are the various plughw surround plugins, but these
seem to work by allocating several mono/stereo streams.  This is
certainly wasteful - 5.1 surround wastes 2 voices.
 
I have been planning to add another playback device to the emu10k1
driver with one 16-63 channel substream, to correspond to the hw:0,2
capture device which can record up to 64 channels.

> > If so, I haven't seen any documentation about this.
> 
> On the SB Live, the PCM device has 32 subdevices.  The subdevice
> number can be specified as the third number in the "hw:x,y,z" device
> name when opening the device.  If you don't specify a subdevice
> number, the default is -1 which means "pick the first free one".

There is some documentation, but nothing that gives a high level
overview of the emu10k1's design and how the driver works, maybe I will
write one at some point.  For now you have to use the source.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
