From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [linux-usb-devel] usb_reset_configuration on a composite device
Date: Mon, 17 Oct 2005 18:03:14 +0200
Message-ID: <1129564994.4353cb424604a@domainfactory-webmail.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Laurent Pinchart <laurent.pinchart@kamikazes.be>, USB development list <linux-usb-devel@lists.sourceforge.net>, ALSA development list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Alan Stern wrote:

> On Sat, 15 Oct 2005, Laurent Pinchart wrote:
>
> > While reading the ALSA USB sound driver's source code to find out
> > how it handles interface association, I noticed that the driver
> > calls usb_reset_configuration in its probe function. While that's
> > fine for normal devices, wouldn't it be a problem with composite
> > devices like my webcam ?
>
> I don't know why the ALSA driver calls usb_reset_configuration.
> Normally it shouldn't be needed, as you said, but perhaps the driver
> has some special reason.

It was just copied from audio.c.
I'll remove it (since the call in audio.c got removed years ago).


Regards,
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
