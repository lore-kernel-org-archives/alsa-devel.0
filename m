From: Patrick Dumais <pat@dumaisnet.ca>
Subject: Re: hardware channel mixing
Date: Fri, 3 Sep 2004 09:15:06 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0409030913180.9962@pat.dumaisnet.ca>
References: <Pine.HPX.4.33n.0409031451550.24397-100000@studcom.urz.uni-halle.de>
Reply-To: pat@dumaisnet.ca
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Thanks a lot, I've been looking for that information.

So this would mean that the only solution would be to snd_pcm_open() a
device for each sound file that I want to play simultenaously?


Patrick Dumais
****************************
http://www.dumaisnet.ca:242/

On Fri, 3 Sep 2004, Clemens Ladisch wrote:

> Date: Fri, 03 Sep 2004 14:59:26 +0200 (METDST)
> From: Clemens Ladisch <clemens@ladisch.de>
> To: Patrick Dumais <pat@dumaisnet.ca>
> Cc: alsa-devel@lists.sourceforge.net
> Subject: Re: [Alsa-devel] hardware channel mixing
>
> Patrick Dumais wrote:
> > When I read a description of what the soundblaster Live features, I notice
> > they say "131 hardware channels". Now is this what I think it is? does it
> > mean that I can actualy write multiple (upto 131) sounds and let the card
> > mix it by itself?
>
> Essentially, yes, but the real number is 64 voices, and each stereo
> stream needs two of them, so you can play 32 streams simultaneously.
>
> > If so, I haven't seen any documentation about this.
>
> On the SB Live, the PCM device has 32 subdevices.  The subdevice
> number can be specified as the third number in the "hw:x,y,z" device
> name when opening the device.  If you don't specify a subdevice
> number, the default is -1 which means "pick the first free one".
>
>
> HTH
> Clemens
>


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
