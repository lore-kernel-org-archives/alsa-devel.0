From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Using specific code for midi/gameport instead of
 generic one.
Date: Mon, 7 Feb 2005 16:40:07 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0502071626560.3379-100000@studcom.urz.uni-halle.de>
References: <42075CEC.6080101@free.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <42075CEC.6080101@free.fr>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: matthieu castet <castet.matthieu@free.fr>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

matthieu castet wrote:
> Anyway, we should check if the midi device is found by pnp for these
> chips. If it is the case, what happen if mpu401 module is load before
> the via module ?

The I/O ports and the interrupt would already have been taken by the
mpu401 module.  However, the MPU-401 interrupt is usually assumed to
be an unsharable ISA interrupt, so this would prevent the AC'97
controller driver from being loaded.

Are there really any VT686 boards that have PnP information for the
MPU-401?

> Clemens Ladisch wrote:
> > There is no reason for the gameport code, except that it would work
> > even if PnP happens to be disabled.
> >
> ns558 work even if the PnP is disable : it will try to see if there is
> something on the following ports [1]. And 0x200 is the port harcoded in
> the via driver, so it should detect it.

Then there is indeed no reason.

> But perhaps VIA_FUNC_ENABLE_GAME will be missing...

In that case, the user has disabled the gameport in the BIOS setup.



Best regards,
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
