From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [partialy fixed] Creamware Noah,
 snd-usb-audio capable?
Date: Fri, 20 Feb 2004 12:10:21 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0402200947200.13625-100000@studcom.urz.uni-halle.de>
References: <1077228297.3053.1.camel@chief.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <1077228297.3053.1.camel@chief.local>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Hartmut Geissbauer <nwgbh@swissonline.ch>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hartmut Geissbauer wrote:
> > > The only thing that's missing now are the two playback ports.
> >
> > Please show the output of "lsusb -v".
>
>       bInterfaceNumber        2
>       iInterface              4 Noah Audio Out
>       bAlternateSetting       1
>         bFormatType             1 (FORMAT_TYPE_I)
>         bNrChannels             2
>         bBitResolution         16
>         tSamFreq[ 0]        44100
>           Transfer Type            Isochronous
>           Synch Type               Asynchronous

The descriptors look OK.

Are there any messages in the system log (dmesg) when the driver is
loaded?  If not, please compile ALSA again after running configure
with the --with-debug=detect parameter, and try again.


Regards,
Clemens




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
