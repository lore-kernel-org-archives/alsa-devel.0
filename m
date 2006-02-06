From: list@phasorlab.de (Matthias =?utf-8?Q?K=C3=B6nig?=)
Subject: Re: list all available devices
Date: Mon, 06 Feb 2006 19:30:52 +0100
Message-ID: <874q3ce3vn.fsf@zebra.localdomain>
References: <43E71617.9090101@gmx.de>
	<Pine.LNX.4.58.0602061118060.20834@denise.shiny.it>
	<1139248850.2791.261.camel@mindpipe> <43E79108.7050300@gmx.de>
	<1139249612.2791.269.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1139249612.2791.269.camel@mindpipe> (Lee Revell's message of
	"Mon, 06 Feb 2006 13:13:31 -0500")
Sender: alsa-devel-admin@lists.sourceforge.net
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

Hi,

Lee Revell <rlrevell@joe-job.com> writes:

> It's insane to expect every app to use 100 lines of code list to list
> available PCMs.  It should be a single function call.

Hmm, doesn't this exist already? What about this:

int snd_names_list(const char *iface, snd_devname_t **list)
Give a list of device names and associated comments for selected interface. 

Regards,
Matthias


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
