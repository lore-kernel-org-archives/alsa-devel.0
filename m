From: Frank Barknecht <fbar@footils.org>
Subject: Re: usb_get_device_descriptor when building for 2.6.2-rc3
Date: Mon, 2 Feb 2004 19:22:24 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040202182224.GA7305@fliwatut.scifi>
References: <20040202163144.GA4349@fliwatut.scifi> <s5hoeshuzyh.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hoeshuzyh.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hallo,
Takashi Iwai hat gesagt: // Takashi Iwai wrote:

> At Mon, 2 Feb 2004 17:31:44 +0100,
> Frank Barknecht wrote:
> > I'm trying to build ALSA-CVS for 2.6.2-rc3, because that kernel has
> > support for the emi62m firmware. Now I get unresolved symbols in
> > snd-usb-audio: 
> > 
> > request_module: failed /sbin/modprobe -- snd-card-1. error = 256
> > snd_usb_audio: Unknown symbol usb_get_device_descriptor
> 
> do you enable the modle version?

No, I didn't enable mod versions. Should I?

> then you'll need to rebuild alsa-driver, too.

Yes, I did that. I ran configure again and "make dep; make; make
install-modules"

Previously there was Kernel 2.6.1 installed, so the modules were
installed into another, new directory anyways.

ciao
-- 
 Frank Barknecht                               _ ______footils.org__


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
