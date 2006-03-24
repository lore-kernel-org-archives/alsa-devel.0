From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Chip support for CS4270 and CS4265
Date: Fri, 24 Mar 2006 14:21:49 +0100
Message-ID: <20060324132149.GD1671@turing.informatik.uni-halle.de>
References: <44206189.5070208@pianodisc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <44206189.5070208@pianodisc.com>
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
To: Steve deRosier <derosier@pianodisc.com>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

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
