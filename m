From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: list all available devices
Date: Mon, 06 Feb 2006 13:00:49 -0500
Message-ID: <1139248850.2791.261.camel@mindpipe>
References: <43E71617.9090101@gmx.de>
	 <Pine.LNX.4.58.0602061118060.20834@denise.shiny.it>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0602061118060.20834@denise.shiny.it>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Giuliano Pochini <pochini@denise.shiny.it>
Cc: Timo Steuerwald <timo.steuerwald@gmx.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 2006-02-06 at 11:19 +0100, Giuliano Pochini wrote:
> 
> On Mon, 6 Feb 2006, Timo Steuerwald wrote:
> 
> > Hi all,
> >
> > can someone point me to the right location where I can find information
> > about listing all available devices in ALSA?
> > A code sample will be also very nice :-)
> 
> aplay -l
> arecord -l

Are you sure that's good enough?  It does not list the PCMs in a format
useful to the application (like "default", hw:0", "surround51", "dmix"
etc).  AFAICT "aplay -l" doesn't give an application enough information
to populate a drop-down list.

This is a problem already for apps like "wengophone" - ALSA does not
provide a sane API for enumerating all usable PCMs so it only lists
"hw:x" PCMS and whatever is directly defined in .asoundrc (but NOT the
PCMs defined under /usr/share/alsa/* - probably it parses .asoundrc
directly, ugh)

Lee



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
