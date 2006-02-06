From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: [ALSA - driver 0001806]: SPDIF and Wordclock I/O is broken on Delta 1010LT
Date: Mon, 6 Feb 2006 14:45:16 +0000
Message-ID: <200602061445.16645.gineera@aspect135.co.uk>
References: <68c7bcdb75e965f940ce3ea34a123fd6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <68c7bcdb75e965f940ce3ea34a123fd6@bugtrack.alsa-project.org>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Doug McLain <doug@nostar.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Monday 06 February 2006 11:05, bugtrack@alsa-project.org wrote:
> ----------------------------------------------------------------------
>  nostar - 02-06-06 11:41
> ----------------------------------------------------------------------
> This patch fixes SPDIF I/O, and adds a few very useful lines to the current
> proc output.
>
(driver.diff)

I am glad you have made good progress!  What was it that actually solved the 
problem?  In driver.diff, which is wanted, mutex_init or init_MUTEX?  Is the 
patch hunk the right way round?  Also there are 2 hunks of spurious 
white-space changes; I normally edit these out of diff files.

> ----------------------------------------------------------------------
>  nostar - 02-06-06 12:05
> ----------------------------------------------------------------------
> envy.diff fixes the problem of not being able toselect word clock directly
> from an internal clock source (on all cards, not just the 1010LT).
>
You're right to point out that internal_clock_set(13) is an anomaly, since it 
is an external clock source!  I suppose we have to live with that, as the 
driver treats SPDIF in the internal clock routines.

Extra '=' -typo well spotted, although it has compiled for me without 
problems.  It was mine, I think.

Alan



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
