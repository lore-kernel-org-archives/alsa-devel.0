From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Hercules PC DJ Console (Windows Edition) information
Date: Tue, 4 Oct 2005 15:29:17 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0510041451160.10984-100000@studcom.urz.uni-halle.de>
References: <2c746f620510040247h45af8fbaoa17c5276c97b8efc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <2c746f620510040247h45af8fbaoa17c5276c97b8efc@mail.gmail.com>
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

Eric Shattow wrote:
> On 10/4/05, Clemens Ladisch <clemens@ladisch.de> wrote:
> > Eric Shattow wrote:
> > > It's not getting far enough to dump any packets.
> >
> > This means that no packets are sent by the device.
> >
> > It's possible that the controller data is reported by the HID
> > interfaces.  Did you test those?
>
> How would I make it so that usbhid module does not interfere?

You wouldn't.  The 'proper' way would be to write a utility that reads
input events from the three HID interfaces and converts them to MIDI.
Otherwise, somebody would have to write a new driver for this device,
and change the usbhid driver accordingly.


Regards,
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
