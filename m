From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: Soundcard matrix update - Echoaudio
Date: Mon, 17 Oct 2005 09:32:31 +0200 (CEST)
Message-ID: <XFMail.20051017093231.pochini@shiny.it>
References: <2c746f620510161407j657b1601w9e5c22dd3d50af1b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <2c746f620510161407j657b1601w9e5c22dd3d50af1b@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Eric Shattow <lucent@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


On 16-Oct-2005 Eric Shattow wrote:

> Also, Freebob does not make use of ALSA code. I am to understand that
> Freebob in its present state operates directly as a JACK plugin.

It's a design decision. ALSA supports userspace drivers too. For
example the "disk writer" plugin (I don't recall the exact name)
is all inside alsa-lib.


> ALSA as a sound device driver project would do well to define USB and
> IEEE1394 APIs that when compiled for the foo protocol, result in a
> base class kernel module snd-foo-audio and snd-foo-your_driver_here
> modules. The monolithic snd-usb-audio module now would be a bad way to
> start Firewire audio support.

The ALSA usb core exists because nearly all usb soundcards use the
same protocol. I don't know if it's the same about firewire devices
and, in that case, if echoaudio cards follow the standard.


--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
