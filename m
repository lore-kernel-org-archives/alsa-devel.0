From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Echo Indigo IO returns error -2 during probe
Date: Sat, 14 Jan 2006 21:45:12 -0500
Message-ID: <1137293112.19972.5.camel@mindpipe>
References: <43C954C8.405@cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <43C954C8.405@cornell.edu>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Vaughn <jiv3@cornell.edu>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, 2006-01-14 at 14:45 -0500, James Vaughn wrote:
> While attempting to setup an Echo Indigo IO, something complains and
> returns an error "-2".  Unfortunately, I was unable to find any
> information about what this error codes means and, as such, am unable to
> provide any assistance or information beyond the usual.
> 
> Current kernel is 2.6.11.11, ALSA version is 1.0.10 through gentoo
> (whatever the current stable package in portage is).
> 
> specific error is:

Error -2 is "No such file or
directory" (see /usr/include/linux/errno.h).

Sounds like the driver is unable to find the firmware.  Do you have the
firmware installed, and your kernel configured to enable firmware
loading?

Lee



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
