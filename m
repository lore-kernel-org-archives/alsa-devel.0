From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] try to load seq drivers multiple times
Date: Mon, 14 Oct 2002 13:17:37 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0210141305170.6076-100000@studcom.urz.uni-halle.de>
References: <Pine.LNX.4.33.0210141228540.521-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <Pine.LNX.4.33.0210141228540.521-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@perex.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Mon, 14 Oct 2002, Clemens Ladisch wrote:
>
> > If the sequencer device for a card is requested unsuccessfully (e.g.
> > "pmidi -l" when a USB MIDI device isn't yet connected), the device is
> > plugged in, and then the device is accessed, ALSA doesn't load the
> > sequencer driver.
> >
> > The reason for this is that snd_seq_client_use_ptr() assumes that the
> > sequencer driver cannot be loaded when the card driver has failed to load
> > before.
> >
> > This patch removes the "!card_requested" protection from the call to
> > snd_seq_device_load_drivers().
>
> It's a bad idea. The better solution is to configure usbmgr to load usb
> driver when hardware is plugged in.

Loading usb (card) drivers (snd-usb-audio) works just fine, and the patch
doesn't change the behaviour regarding card drivers. The problem is that
the sequencer driver (snd-usb-midi) isn't loaded when the card driver has
been loaded.

> We definitely don't want to see thousands of failure messages in
> /var/log/messages.

snd_seq_device_load_drivers() has its own protection against multiple
request_module() calls (the DRIVER_REQUESTED flag), so this isn't a
problem.


Regards,
Clemens



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
