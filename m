From: Dave Jones <davej@redhat.com>
Subject: Re: Re: RFC: OSS driver removal, a slightly different approach
Date: Thu, 19 Jan 2006 17:42:22 -0500
Message-ID: <20060119224222.GW21663@redhat.com>
References: <20060119174600.GT19398@stusta.de> <m3ek34vucz.fsf@defiant.localdomain> <1137703413.32195.23.camel@mindpipe> <1137709135.8471.73.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 06EDD11F
	for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2006 23:42:52 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <1137709135.8471.73.camel@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Lee Revell <rlrevell@joe-job.com>, Krzysztof Halasa <khc@pm.waw.pl>, Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 19, 2006 at 10:18:55PM +0000, Alan Cox wrote:
 > On Iau, 2006-01-19 at 15:43 -0500, Lee Revell wrote:
 > > Even the NeoMagic 256 which is a Pentium II era device and was in
 > > widespread use we cannot find a tester for.
 > 
 > There are plenty of neomagic audio users around, I've seen bug reports
 > about neomagic + ALSA hangs that have been filed.

They should be pretty easy to track down. Search for bug reports
with "Dell Latitude hangs" :-)

Here's three from Fedora bugzilla to start with..
http://tinyurl.com/dcy3e

(The bug is long-since fixed, but the reporters may still have the
 hardware and be willing to provide feedback to ALSA developers)

		Dave



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
