From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: M-Audio Sonica support
Date: Mon, 02 Sep 2002 19:24:14 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D739EBE.91D0D608@ladisch.de>
References: <s5hvg5ollt7.wl@alsa2.suse.de>
 <000601c25299$6e8ec740$0500a8c0@shwxp> <s5hd6rwe5ua.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Stephen Hassard <steve@hassard.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Stephen Hassard wrote:
> >      Interface Descriptor:
> >        bLength                 9
> >        bDescriptorType         4
> >        bInterfaceNumber        0
> >        bAlternateSetting       0
> >        bNumEndpoints           0
> >        bInterfaceClass       254
> >        bInterfaceSubClass      1
> >        bInterfaceProtocol      0
> >        iInterface              3 RAM
> >    unknown descriptor type: 07 21 05 00 01 40 00
> 
> hmm, the descriptor is apprently broken.
> usually you'll see the list of interfaces, terminals, formats,
> etc. there.
> the device might be non-standard one.  if so, the current driver
> doesn't support it, unfortuantely.

bInterfaceClass 254 = "Application-Specific"
bInterfaceSubClass 1 = "Device Firmware Update"

And they bothered to give the interface a name ("RAM").  :-)

If it were a broken descriptor, it would be easy to make the correct
information available with a quirk. In this case, however, we need the
firmware and a loader.

The download protocol is described in the "USB Device Firmware
Upgrade Specification". A loader might already exist, or is (relatively)
easy to write.

For the firmware, we could _try_ to ask Midiman. But I think a
USB snoop log from the Windows driver would have a higher
probability of success. (Unfortunately, the bmAttributes field in the
DFU functional descriptor indicates that the device is only capable
of downloading, not uploading.)
If we have luck, the firmware is stored in a DFU file (not necessarily
with that name).


HTH
Clemens


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
