From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Digitech GNX-4 Guitar Workstation ( w/ usb audio/midi
 ports)
Date: Wed, 22 Mar 2006 12:31:51 +0100
Message-ID: <20060322113151.GC7675@turing.informatik.uni-halle.de>
References: <1142980408.13175.15.camel@Pippin.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate2.urz.uni-halle.de (mailgate2.urz.uni-halle.de [141.48.3.8])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B9C701A3
	for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2006 12:32:49 +0100 (MET)
In-reply-to: <1142980408.13175.15.camel@Pippin.home>
Content-disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: John Shillinglaw <jshillinglaw@hotpop.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

John Shillinglaw wrote:
> I just purchased a Digitech gnx-4 guitar workstation. It has an usb port
> which provides 4 channels of audio to the pc, 2 back down, midi in/out,
> and a cf readable from the pc.
> 
> I've been testing it under linux, and it seems to work, but doesn't seem
> to be explicitly listed in the usb drivers. The cf card will show up
> under linux, and the midi ports show up under aplaymidi -l. The audio
> seems to be present, but doesn't show up under the mixer.

Please show the output of "lsusb -v" for this device, but I guess it
doesn't have any mixer controls that would be accessible from the
computer.

Please add it to the database at <http://qbik.ch/usb/devices/>.


Regards,
Clemens


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
