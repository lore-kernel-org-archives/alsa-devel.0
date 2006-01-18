From: Eric Shattow <lucent@gmail.com>
Subject: Re: Hercules PC DJ Console (Windows Edition) information
Date: Tue, 17 Jan 2006 23:25:22 -0600
Message-ID: <2c746f620601172125u6165eec0h94c79bb126262737@mail.gmail.com>
References: <2c746f620510180211hf803801mdda93f93aeae84c2@mail.gmail.com>
	 <2c746f620510182301j3419d000o857c2c72ef29880a@mail.gmail.com>
	 <2c746f620510182303k782e04f2xa18b60cea49030a@mail.gmail.com>
	 <1129746748.5203.1.camel@mindpipe>
	 <2c746f620510191410v5032b3ebp673545e5958192ac@mail.gmail.com>
	 <2c746f620601102330s337d7744r7b98dad75dbbf374@mail.gmail.com>
	 <1136964861.27255.17.camel@mindpipe>
	 <1137055672.43c617b8297f6@webmail.uni-halle.de>
	 <2c746f620601162205x4bfbfefcl493cdb330dc4b5fd@mail.gmail.com>
	 <1137504011.43ccef0ba85d6@webmail.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1137504011.43ccef0ba85d6@webmail.uni-halle.de>
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
To: alsa-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On 1/17/06, Clemens Ladisch <clemens@ladisch.de> wrote:
> Eric Shattow wrote:
> > +usb 3-1.6: new full speed USB device using ehci_hcd and address 5
> > +ALSA /usr/src/modules/alsa-driver/usb/usbaudio.c:835: cannot submit
> > datapipe for urb 0, err =3D -38
>
> Enable EHCI full speed support in the kernel configuration, or connect it
> to the computer without using a USB 2.0 hub.
>
>
> HTH
> Clemens
>
>

>From my kernel .config for 2.6.15:

...
#
# USB support
#
CONFIG_USB_ARCH_HAS_HCD=3Dy
CONFIG_USB_ARCH_HAS_OHCI=3Dy
CONFIG_USB=3Dy
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=3Dy
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_SUSPEND is not set
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=3Dm
# CONFIG_USB_EHCI_SPLIT_ISO is not set
CONFIG_USB_EHCI_ROOT_HUB_TT=3Dy
CONFIG_USB_ISP116X_HCD=3Dm
CONFIG_USB_OHCI_HCD=3Dm
# CONFIG_USB_OHCI_BIG_ENDIAN is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=3Dy
CONFIG_USB_UHCI_HCD=3Dm
CONFIG_USB_SL811_HCD=3Dm
CONFIG_USB_SL811_CS=3Dm
...

Which option are you referring to?

 Eric


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
