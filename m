From: Willie Sippel <willie@froq.net>
Subject: Full support for Creamware Noah and SFP
Date: Tue, 09 Mar 2004 19:03:46 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1078855426.11076.36.camel@zauberwald.zeitgeist>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Hi.

As some of you may know, Creamware (http://www.creamware.de) is under
new management since 2004 - and they have changed their mind regarding
Linux support.
Porting the SFP (Noah is part of SFP) to Linux is more than writing a
mere driver, 'cause of the DSP based approach... 
It may be difficult to port the whole platform, but as an additional
benefit (a huge one), all plugins and softsynths are already platform
independent - porting the platform would give instant access to lots of
high-quality plugins - they could be used on Linux as soon as the
platform is ported (the plugins are encrypted archives containing the
DSP code and the interface description, everything from the uplading to
the interface drawing is handled by the SFP software). And the next
version of the plugin IDE will be released for free anytime soon...

But there is one problem: Creamware would open-source as much as
possible and necessary to make SFP work, but not everything. I talked to
Frank Hund of CW today, and he suggested a solution:
They would give the specs and all sources to Linux developers under an
NDA, to check what parts of the system would be needed to make the card
work with ALSA (the basic soundcard features, and the bridge to use the
SFP software). Those parts would be released under the GPL, and could
become part of ALSA. The remaining parts of the platform (those needed
to upload plugins to the DSP's) could be ported and provided binary only
by Linux developers that signed the NDA, and may be provided for several
architectures (x86, AMD64, PPC). 
Anyone interested in helping out (I'm not a coder, just a mere
musician)? If there is interest, I will forward it to Frank.

Ciao,
-- 
Willie Sippel <willie@froq.net>
[ z ] !



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
