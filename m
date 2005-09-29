From: Eric Shattow <lucent@gmail.com>
Subject: Re: Hercules PC DJ Console (Windows Edition) information
Date: Thu, 29 Sep 2005 13:53:02 -0500
Message-ID: <2c746f6205092911534dacb588@mail.gmail.com>
References: <2c746f6205092906046546188c@mail.gmail.com>
	 <Pine.HPX.4.33n.0509291514120.4499-100000@studcom.urz.uni-halle.de>
Reply-To: Eric Shattow <lucent@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0509291514120.4499-100000@studcom.urz.uni-halle.de>
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
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 9/29/05, Clemens Ladisch <clemens@ladisch.de> wrote:
> Eric Shattow wrote:
> > I tried the above patch, and applied it to debian alsa-source package
> > 1.0.9b4, and now the DJ Console is recognized.
> >
> > However, using amidi -d -p hw:2,0,n  does not yield any output when
> > moving the controls.
>
> Probably the devices user a different protocol than I was assuming.
> Please uncomment the DUMP_PACKETS line near the top of usbmidi.c and
> show any "received packet" lines that end up in the system log.
>
>
> Regards,
> Clemens
>
>

I tried your suggestion for DUMP_PACKETS and there was no output with
1.0.9b4+patches. I will now try CVS with the above usbquirk.h patch
and #define DUMP_PACKETS to see what happens:

Sep 29 13:54:18 [kernel] input: USB HID v1.10 Joystick [Hercules
Hercules DJ Console] on usb-0000:00:02.1-3
Sep 29 13:54:18 [kernel] input: USB HID v1.10 Mouse [Hercules Hercules
DJ Console] on usb-0000:00:02.1-3
Sep 29 13:54:18 [kernel] input: USB HID v1.10 Keyboard [Hercules
Hercules DJ Console] on usb-0000:00:02.1-3
Sep 29 13:54:18 [kernel] snd-usb-audio: probe of 2-3:1.5 failed with error =
-5
Sep 29 13:54:18 [kernel] ALSA
/tmp/alsa-cvs20050929/alsa-driver/usb/usbmixer.c:669: 2:6: cannot get
min/max values for control 8 (id 2)

I think I've seen error -5 mentioned on the list archives, how to fix this?


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
