From: "Steve DeRosier" <derosier@pianodisc.com>
Subject: RE: Chip support for CS4270 and CS4265
Date: Fri, 24 Mar 2006 07:37:01 -0800
Message-ID: <DB99F0250CDF5F438C525F4695C888DC0DA027@exchange01-srv.pianodisc.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Class: urn:content-classes:message
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Thanks Clemens.  Makes perfect sense. =20

No particular sound card in mind; Got someone working on an embedded =
design that will eventually run linux and this is what they're looking =
at puting in the audio portion.  Though I guess since the contract says =
they're responsible for the Alsa drivers I'm not going to worry about =
it; I just hope they understand what they're doing.  ;)

- Steve

-----Original Message-----
From: Clemens Ladisch [mailto:clemens@ladisch.de]
Sent: Friday, March 24, 2006 5:22 AM
To: Steve DeRosier
Cc: Alsa-Devel
Subject: Re: [Alsa-devel] Chip support for CS4270 and CS4265


Steve deRosier wrote:
> Does anyone know if the CS4270 and CS4265 are supported in Alsa?

These chips cannot be connected directly to a PCI (or similar) bus; they
expect audio data in a simple serial format and require some controller
chip that does DMA from/to the computer's memory.

The ALSA driver, if it existed, would be for this controller chip.

Do you have some particular sound card in mind?

> I don't see either one on the matrix on the website, and also noted
> that ALL CS chips mentioned are listed as discontinued on Cirrus
> Logic's web site.

Those are chips that have a PCI or ISA interface.


HTH
Clemens


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
