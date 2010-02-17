From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Verifying mixer dB data/Invalid dB data from
 USB	cards, especially Aureon 5.1 MkII
Date: Wed, 17 Feb 2010 14:15:48 +0100
Message-ID: <20100217131548.GE24165@tango.0pointer.de>
References: <20100216144047.GB10586@sirena.org.uk>
	<20100216154015.GA612@tango.0pointer.de>
	<alpine.LNX.2.00.1002161711400.28127@eeebox2.perex-int.cz>
	<20100216210703.GA18109@tango.0pointer.de>
	<20100216223938.GA23623@sirena.org.uk>
	<20100216224212.GA1486@tango.0pointer.de>
	<4B7B2E9F.3080809@audioscience.com>
	<20100217001047.GB6766@tango.0pointer.de>
	<alpine.LNX.2.00.1002170924570.28127@eeebox2.perex-int.cz>
	<20100217120644.GC2032@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 5FA5B103897
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 14:16:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20100217120644.GC2032@sirena.org.uk>
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

On Wed, 17.02.10 12:06, Mark Brown (broonie@opensource.wolfsonmicro.com) wrote:

> I'd actually be surprised if there were too much of an issue with this
> beyond the data collection one (especially for USB devices).

I wonder if we could harvest this in some way from the Windows
drivers? Does Windows care about the dB data at all? Maybe one could
extract this information from their .inf files or so, if they store it
there?

At least the Vista APIs seem to expose dB data:

http://msdn.microsoft.com/en-us/library/dd371447%28VS.85%29.aspx

I wonder where they get that data from and what they do with broken
hardware like the Aureon... Now I wished I had access to a Windows
machine to figure that out...

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
