From: Hartmut Geissbauer <nwgbh@swissonline.ch>
Subject: Re: Creamware Noah, snd-usb-audio capable?
Date: Tue, 10 Feb 2004 19:36:02 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1076438161.2839.0.camel@chief.local>
References: <1076094393.2688.2.camel@chief.local>
	 <200402070220.i172KFO4020802@dhin.linuxaudiosystems.com>
	 <20040210165602.GC9524@fliwatut.scifi>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040210165602.GC9524@fliwatut.scifi>
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

Hello,
Frank Barknecht wrote:
> Hallo, 
> Paul Davis hat gesagt: // Paul Davis wrote:
> 
> > >    Interface Descriptor:
> > >      bLength                 9
> > >      bDescriptorType         4
> > >      bInterfaceNumber        0
> > >      bAlternateSetting       0
> > >      bNumEndpoints           6
> > >      bInterfaceClass       255 Vendor Specific Class
> > 				 ^^^^^^^^^^^^^^^^^^^^^
> > 
> > i don't know much about USB at, but this doesn't look good.
> 
> But it doesn't necessarily have to be that bad as well. Several of the
> (now) supported USB devices have "Vendor Specific" classes, for
> example most Edirol devices do. But I guess, that yes: you'll probably
> need quirks then in usbquirks.h for the Noah, too. 
> 
> ciao

reading the different entries in usbquirks.h it looks like they are
taken from the usb-infos like lsusb provides. Is it very difficult to
take the infos from lsusb and translate it to an quirk?
I only need some quick advice and will try it by myself. A good
(complex) example in my opinion is the "Roland SC-D70".

Thanks in advance for any help.

Hartmut  

-- 

Hartmut Geissbauer <nwgbh@swissonline.ch>



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
