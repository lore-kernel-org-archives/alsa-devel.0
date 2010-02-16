From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Verifying mixer dB data/Invalid dB data from
 USB	cards, especially Aureon 5.1 MkII
Date: Tue, 16 Feb 2010 23:42:12 +0100
Message-ID: <20100216224212.GA1486@tango.0pointer.de>
References: <20100215192451.GA17938@tango.0pointer.de>
	<4B7A5268.5050704@ladisch.de>
	<alpine.LNX.2.00.1002160912140.28127@eeebox2.perex-int.cz>
	<20100216143200.GB25489@tango.0pointer.de>
	<20100216144047.GB10586@sirena.org.uk>
	<20100216154015.GA612@tango.0pointer.de>
	<alpine.LNX.2.00.1002161711400.28127@eeebox2.perex-int.cz>
	<20100216210703.GA18109@tango.0pointer.de>
	<20100216223938.GA23623@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 239AF2449D
	for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2010 23:42:38 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20100216223938.GA23623@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 16.02.10 22:39, Mark Brown (broonie@opensource.wolfsonmicro.com) wrote:

> 
> On Tue, Feb 16, 2010 at 10:07:03PM +0100, Lennart Poettering wrote:
> > On Tue, 16.02.10 17:29, Jaroslav Kysela (perex@perex.cz) wrote:
> 
> > > Basically, if I remember correctly the discussion, 0dB on all elements 
> > > should main unchanged volume, <0dB attenuation and >0dB gain.
> 
> > But you need some kind of "anchor" for that. What you write above
> > applies only for elements that have some kind of analog input and
> > output. But the most interesting components are probably the DAC and
> > ADC (i.e. the "innermost" elements), and it's not clear what level they
> > output, so the "anchor" for the relative dB values is missing...
> 
> Typically the DACs and ADCs will have a full scale signal at line
> reference level - it should generally be a good approximation with
> nothing else to go on.

"line reference level"? What is that?

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
