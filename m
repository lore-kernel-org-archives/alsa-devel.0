From: rct@gherkin.frus.com (Bob Tracy)
Subject: Re: RFC: OSS driver removal, a slightly different approach
Date: Fri, 20 Jan 2006 10:09:32 -0600 (CST)
Message-ID: <20060120160932.2CE10DBA1__14485.5850878686$1137773518$gmane$org@gherkin.frus.com>
References: <m3ek34vucz.fsf@defiant.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gherkin.frus.com (gherkin.frus.com [192.158.254.49])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 176DB16B
	for <alsa-devel@alsa-project.org>; Fri, 20 Jan 2006 17:09:48 +0100 (MET)
In-Reply-To: <m3ek34vucz.fsf@defiant.localdomain> "from Krzysztof Halasa at Jan
 19, 2006 09:24:44 pm"
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

Krzysztof Halasa wrote:
> Adrian Bunk <bunk@stusta.de> writes:
> > (...)
> > SOUND_PAS
> 
> Pro Audio Spectrum. Earlier than GUS? 8-bit I think

16-bit actually.  SoundBlaster emulation capability of various kinds
was claimed by the manufacturer, but I know of few cards of that era
that *didn't* make such claims :-).

> Don't you all think a large part (if not most) of the "ALSA-unsupported"
> cards is no longed in any (Linux-related) use? I wouldn't be surprised
> if they just don't exist anymore. Who is to write drivers for them and -
> more importantly - who can test them?

I can help out with the testing of the PAS, including the SCSI side of
the Pro Audio Studio version of the card (another can of worms that the
ALSA folks rightly have no responsibility for: it never really worked
well with Linux because the driver supported the NCR chipset in polling
mode only).

As far as other old ISA soundcards I might be able to help test, I also
have a GUS with the multiple proprietary CD-ROM interfaces on it, and a
MAUI -- the latter being in a semi-modern PIII/1000 machine running FC4.

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
