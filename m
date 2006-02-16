From: hurricane <hurricane@barmusic.com>
Subject: Re: using more than 8 boards of the same kind, at
	once, on a single system
Date: Thu, 16 Feb 2006 18:53:59 -0500
Message-ID: <1140134039.1649.7.camel@lnx.rgptech.com>
References: <1139755387.25868.1.camel@lnx.rgptech.com>
	 <20060213083240.GC8896@ifiu25.informatik.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20060213083240.GC8896@ifiu25.informatik.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Clemens,

	Thanks for the help! 32 will be just fine if I can now figure out how
to upgrade my 2.6.11-1.27_FC3smp FEDORA CORE 3 from ALSA 1.08 to
1.0.11rc3. Do you  (or anyone else) know if a YUM update or something
similar will work???? I do not know how to upgrade to the new version of
ALSA correctly. Any help on what you described would be humbly
appreciated by myself.


Thanks,
Gordon



On Mon, 2006-02-13 at 09:32 +0100, Clemens Ladisch wrote:
> hurricane wrote:
> > I have designed a video/audio USB2.0 board (WISIWYG 1.0), that I use
> > on 2.6.11-1.27_FC3smp that uses the WIS GO7007 chip, and have run into
> > a limit of 8 boards that can be recognized for audio by the WIS device
> > driver.
> 
> ALSA's latest development relase (1.0.11rc3) supports up to 32 cards
> when it is configured with --enable-dynamic-minors.
> 
> > I need to use up to 48 boards on one system.
> 
> This would require a trivial change in alsa-lib and an unknown amount of
> changes in the ALSA kernel code.
> 
> 
> HTH
> Clemens
> 


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
