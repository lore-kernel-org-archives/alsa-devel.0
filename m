From: Eric Shattow <lucent@gmail.com>
Subject: Re: Soundcard matrix update - Echoaudio
Date: Sun, 16 Oct 2005 16:07:21 -0500
Message-ID: <2c746f620510161407j657b1601w9e5c22dd3d50af1b@mail.gmail.com>
References: <20051015191158.37e0f620.pochini@shiny.it>
	 <2c746f620510151456u3d40181bi1de819300e8f85e3@mail.gmail.com>
	 <20051016160541.29f34177.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20051016160541.29f34177.pochini@shiny.it>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 10/16/05, Giuliano Pochini <pochini@shiny.it> wrote:
> On Sat, 15 Oct 2005 16:56:03 -0500
> Eric Shattow <lucent@gmail.com> wrote:
>
> > Would you like to write driver support for the Echo AudioFire series
> > of hardware? I contacted a guy at Echo who seemed positive about
> > providing information necessary. If you write the driver, I will do my
> > best to provide you with hardware to test it on (this means contacting
> > echo for a sample unit, or even funding one from my own pocket).
>
> I may write the driver for the new FW cards, but take into account that I
> work on it in my spare time, a driver for a fw soundcard is very differen=
t
> than the PCI driver, and I cannot say how much time I can take to write i=
t.
> The Freebob project http://sourceforge.net/projects/freebob/ is (very
> slowly) developing drivers for FW cards but it's still alpha version and =
it
> supports only cards with the AV/C command set (so says the page above, no
> idea what is it). Furthermore, I have to learn how to talk with the card
> kernel-side from scratch and without tutorials..
>
> --
> Giuliano.
>

Giuliano,

I have now forwarded to you my correspondence with Echo Audio
representatives. If you can think of what docs you will need, please
make the request. The technical challenges may not be so hard. I'm not
much for programming, so maybe I don't know what I'm talking about.

Freebob is an interesting project, it is focused on daisy-chaining
many bebob devices together and creating one large virtual device.
Also, Freebob does not make use of ALSA code. I am to understand that
Freebob in its present state operates directly as a JACK plugin.

ALSA as a sound device driver project would do well to define USB and
IEEE1394 APIs that when compiled for the foo protocol, result in a
base class kernel module snd-foo-audio and snd-foo-your_driver_here
modules. The monolithic snd-usb-audio module now would be a bad way to
start Firewire audio support.

 Eric


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
