From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Subject: Re: RFC: OSS driver removal, a slightly different approach
Date: Fri, 20 Jan 2006 11:54:43 +0000
Message-ID: <20060120115443.GA16582__41070.7580078908$1137758182$gmane$org@palantir8>
References: <20060119174600.GT19398@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mra02.ch.as12513.net (mra02.ch.as12513.net [82.153.252.24])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4CF7F153
	for <alsa-devel@alsa-project.org>; Fri, 20 Jan 2006 12:54:55 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <20060119174600.GT19398@stusta.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adrian Bunk <bunk@stusta.de>, benh@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

It seems to me we can already get rid of sound/oss/dmasound now.
I cannot find anything refering to it anymore, and the ALSA powermac
driver is being maintained.

Martin

On Thu, Jan 19, 2006 at 06:46:00PM +0100, Adrian Bunk wrote:
> My proposal to remove OSS drivers where ALSA drivers for the same 
> hardware exists had two reasons:
> 
> 1. remove obsolete and mostly unmaintained code
> 2. get bugs in the ALSA drivers reported that weren't previously
>    reported due to the possible workaround of using the OSS drivers
> 
> I'm slowly getting more and more reports for the second case.
> 
> 
> The list below divides the OSS drivers into the following three 
> categories:
> 1. ALSA drivers for the same hardware
> 2. ALSA drivers for the same hardware with known problems
> 3. no ALSA drivers for the same hardware
> 
> 
> My proposed timeline is:
> - shortly before 2.6.16 is released:
>   adjust OBSOLETE_OSS_DRIVER dependencies to match exactly the
>   drivers under 1.
> - from the release of 2.6.16 till the release of 2.6.17:
>   approx. two months for users to report problems with the ALSA
>   drivers for the same hardware
> - after the release of 2.6.17 (and before 2.6.18):
>   remove the subset of drivers marked at OBSOLETE_OSS_DRIVER without
>   known regressions in the ALSA drivers for the same hardware
> 
> 
> To make a long story short:
> 
> If you are using an OSS driver because the ALSA driver doesn't work 
> equally well on your hardware, send me an email with a bug number in the 
> ALSA bug tracking system now.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
