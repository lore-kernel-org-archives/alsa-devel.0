From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: seq_midi client names
Date: Thu, 13 Apr 2006 17:26:17 +0200
Message-ID: <20060413152617.GB1147@turing.informatik.uni-halle.de>
References: <200604121402.48859.gineera@aspect135.co.uk>
 <20060412155948.GB21693@turing.informatik.uni-halle.de>
 <200604131354.45544.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <200604131354.45544.gineera@aspect135.co.uk>
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
To: Alan Horstmann <gineera@aspect135.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Alan Horstmann wrote:
> The ice1712 envy24 chip provides two mpu401 uart ports.  Is this the
> same use of the term, ie the hardware wired to the panel connectors
> that midi uses; can a midi device have more than one port?  So
> rmidi->name is a device name, not port name?

Yes; yes.  Yes.

> > The id is just an internal identifier, shortname would be better.
> 
> I'll post a patch to change seq_midi to use card->shortname instead of 
> info->name for the new client name, if that is OK with you?

Yes.


Regards,
Clemens


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
