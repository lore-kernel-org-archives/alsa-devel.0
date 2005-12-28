From: John Rigg <ad@sound-man.co.uk>
Subject: Re: Re: [Jackit-devel] Real-world reports on two Delta 1010LTs/ice1712 synched?
Date: Wed, 28 Dec 2005 21:19:35 +0000
Message-ID: <20051228211935.GA4782@localhost.localdomain>
References: <20051224124823.GA4183@localhost.localdomain> <20051224144548.GA4306@localhost.localdomain> <20051224165610.GA4484@localhost.localdomain> <43AE9FA6.2020207@nostar.net> <20051226130327.GA4763@localhost.localdomain> <43B059A3.2050302@nostar.net> <20051227000428.GA3805@localhost.localdomain> <43B0A83F.1040907@nostar.net> <20051227130029.GB3770@localhost.localdomain> <43B1A8FA.8080408@nostar.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <43B1A8FA.8080408@nostar.net>
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

On Tue, Dec 27, 2005 at 03:50:02PM -0500, Doug McLain wrote:
> For now, here's a patch 
> that should fix the problem of having to press spdif before word clock. 
>  If it does work for you on the regular 1010, then the comments for 
> both the 1010 and 1010lt are backwards (where 0 = word clock and 1 = spdif).

> Index: hardware.c
> ===================================================================
> RCS file: /cvsroot/alsa/alsa-tools/envy24control/hardware.c,v
> retrieving revision 1.17
> diff -u -r1.17 hardware.c
> --- hardware.c  5 Dec 2005 21:03:06 -0000       1.17
> +++ hardware.c  27 Dec 2005 20:47:24 -0000
> @@ -128,6 +128,7 @@
>         } else if (!strcmp(what, "SPDIF")) {
>                 internal_clock_set(13);
>         } else if (!strcmp(what, "WordClock")) {
> +               internal_clock_set(13); // Hack
>                 master_clock_word_select(1);
>         } else {
>                 g_print("internal_clock_toggled: %s ???\n", what);

The extra line fixes the problem. It makes the buttons behave the way
I'd expect and I can still select either word clock or S/PDIF for sync input.

Thanks,
John


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
