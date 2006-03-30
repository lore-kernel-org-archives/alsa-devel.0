From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: Chip support for CS4270 and CS4265
Date: Wed, 29 Mar 2006 23:22:41 -0500
Message-ID: <1143692562.15145.15.camel@mindpipe>
References: <44206189.5070208@pianodisc.com>
	 <loom.20060330T042859-767@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <loom.20060330T042859-767@post.gmane.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Leonid <leonid@a-k-a.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 2006-03-30 at 02:30 +0000, Leonid wrote:
> Steve deRosier <derosier <at> pianodisc.com> writes:
> 
> > 
> > All,
> > 
> > Does anyone know if the CS4270 and CS4265 are supported in Alsa?  I don't see
> either one on the matrix on the
> > website, and also noted that ALL CS chips mentioned are listed as discontinued
> on Cirrus Logic's web site.
> > 
> > I took a brief look through the CVS web viewer and didn't see any mention of
> them either.  Does anyone know the status?
> > 
> > Thanks,
> > - Steve
> > 
> 
> I'd like to know as well, Steve... Did anybody answer? Leonid.

Yes, quoting Clemens Ladisch:

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

-Lee




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
