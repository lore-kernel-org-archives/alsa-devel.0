From: Frank Barknecht <fbar@footils.org>
Subject: Re: Creamware Noah, snd-usb-audio capable?
Date: Tue, 10 Feb 2004 22:36:17 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040210213617.GH10941@fliwatut.scifi>
References: <1076094393.2688.2.camel@chief.local> <200402070220.i172KFO4020802@dhin.linuxaudiosystems.com> <20040210165602.GC9524@fliwatut.scifi> <1076438161.2839.0.camel@chief.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1076438161.2839.0.camel@chief.local>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hallo,
Hartmut Geissbauer hat gesagt: // Hartmut Geissbauer wrote:

> reading the different entries in usbquirks.h it looks like they are
> taken from the usb-infos like lsusb provides. Is it very difficult to
> take the infos from lsusb and translate it to an quirk?
> I only need some quick advice and will try it by myself. A good
> (complex) example in my opinion is the "Roland SC-D70".

Well, others like Takashi or Clemens will be able to give better
answers,but I guess, it helps to get familiar with the USB-audio
specification. For example, for a short time I was investigating why
the Midi jacks on the Terratec Phase 26 aren't supported. 

I looked up the specification of usb-midi in
http://www.usb.org/developers/devclass_docs/midi10.pdf and also looked
very closely and for a long time at the lsusb output.  This interface
descriptor then looks very much like it must be the midi interface: 

    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      3 
      bInterfaceProtocol      0 
      iInterface              3 TerraTec PHASE 26 USB
  unknown descriptor type: 07 24 01 00 01 41 00
  unknown descriptor type: 06 24 02 01 10 00
  unknown descriptor type: 06 24 02 02 11 00
  unknown descriptor type: 09 24 03 01 12 01 11 01 00
  unknown descriptor type: 09 24 03 02 13 01 10 01 00
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x05  EP 5 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         64
        bInterval               0
        bRefresh                0
        bSynchAddress           0
  unknown descriptor type: 05 25 01 01 10
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x86  EP 6 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         64
        bInterval               0
        bRefresh                0
        bSynchAddress           0
  unknown descriptor type: 05 25 01 01 12
  Language IDs: (length=4)
     0409 English(US)


The main reason for my assumption is the value for bInterfaceNumber
which is "3" or 0x03 as it should be according to the USB spec which
requires for a "MIDI Adapter Standard MIDIStreaming Interface
Descriptor" to have this field set as follows: 

Offset Field                Size  Value   Description
...
6      bInterfaceSubclass   1     0x03   MIDISTREAMING.
...

All other bInterfaceNumber's in the Phase 26 output are *not* 3. (See
my entry on qbik.ch).

Unfortunatly that's as far as I got. I figure, now a quirk is needed,
but I don't know which one (it probably has something to do with the
endpoints or so.)

Nevertheless I don't have the Phase 26 anymore, so I cannot dig much
deeper.

ciao
-- 
 Frank Barknecht                               _ ______footils.org__


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
