From: Manuel Jander <manuel.jander@usm.cl>
Subject: Re: hardware channel mixing
Date: Fri, 03 Sep 2004 21:19:53 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1094260793.3727.19.camel@localhost>
References: <Pine.HPX.4.33n.0409031451550.24397-100000@studcom.urz.uni-halle.de>
	 <1094254221.6575.94.camel@krustophenia.net>
Reply-To: mjander@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1094254221.6575.94.camel@krustophenia.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

[snip]
> Not quite, it's 32 mono substreams, 21 stereo.  Each mono substream
> requires 2 voices, each stereo substream, three.  There is an extra
> voice allocated per playback substream that is silent, and is just used
> to generate the period interrupts.
> 
> I have pored over the code, and I don't understand exactly why the extra
> voice is needed, Jaroslav said something like "if you don't use the
> extra voice the interrupts are going faster than the voice position".  I
> think it might be needed so that multiple can playback, each with
> different period sizes.

Smells like incomplete hardware spec. Wasting a DMA channel for timing
purposes sounds pretty stupid, despite it may be the only known way to
make it work right now.

> There is currently no way to open an 8 or 16 channel playback
> substream.  There are the various plughw surround plugins, but these
> seem to work by allocating several mono/stereo streams.  This is
> certainly wasteful - 5.1 surround wastes 2 voices.
>  
> I have been planning to add another playback device to the emu10k1
> driver with one 16-63 channel substream, to correspond to the hw:0,2
> capture device which can record up to 64 channels.

There is one problem: If the DMA engine really can demultiplex that many
interleaved channels, the buffer/period *time* will be pretty low. I
think more than 4 or 6 interleaved channels per DMA is not very sane. 
Using several DMA channels would work, but again thats the same as using
several alsa pcm devices plugged together. The voice waste should be
eliminated by other means in my opinion.

Would'nt it be time to think about a resource manager ? Something like
CheckoutVoice() / CheckinVoice() ? Using a resource manager inside a
individual driver already relieves a lot of problems, but maybe using a
resource manager at ALSA-LIB level, would not be a bad idea. Just a
thought that came to my mind...

Best Regards

Manuel Jander




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
