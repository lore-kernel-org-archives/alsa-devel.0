From: Doug McLain <doug@nostar.net>
Subject: Re: Re: [Jackit-devel] Real-world reports on two Delta
 1010LTs/ice1712 synched?
Date: Tue, 27 Dec 2005 15:50:02 -0500
Message-ID: <43B1A8FA.8080408@nostar.net>
References: <20051223233816.GA5102@localhost.localdomain> <43AC8990.7040900@nostar.net> <20051224124823.GA4183@localhost.localdomain> <20051224144548.GA4306@localhost.localdomain> <20051224165610.GA4484@localhost.localdomain> <43AE9FA6.2020207@nostar.net> <20051226130327.GA4763@localhost.localdomain> <43B059A3.2050302@nostar.net> <20051227000428.GA3805@localhost.localdomain> <43B0A83F.1040907@nostar.net> <20051227130029.GB3770@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040702060505020800050209"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20051227130029.GB3770@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: John Rigg <j@sound-man.co.uk>
Cc: alsa-devel@lists.sourceforge.net, jackit-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040702060505020800050209
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


> 
> With 2.6.14 or later kernel, starting envy24control (from alsa-tools-1.0.10)
> from xterm resulted in a slew of error messages saying "Unable to determine
> word clock status" scrolling off the xterm. The patch fixed that. Maybe that
> only happens with the 1010 not the 1010LT. It's possible that with the broken
> word clock on the 1010LT it wasn't even trying to determine word clock
> status so it didn't trigger the bug.
> 
> John

I asked that before I started studying the mixer and driver code 
closely.  I now have a good understanding of what the patch does, and 
why the 1010LT isnt working.  I also don't need any tests done by anyone 
that I was asking for.

It looks like the driver is the root of the problem.  There doesnt 
appear to currently be any facility provided for the 1010LT to set and 
check word clock as the master clock source, and SPDIF In only works by 
accident.

#define ICE1712_DELTA_1010LT_WORDCLOCK 0x80	/* sample clock source: 0 = 
Word Clock Input, 1 = S/PDIF Input ??? */

Doesn't appear to be correct, as SPDIF Input works wether I send a 1 or 
a 0 to the word_clock_sync snd_ctl_elem.  I'm going to keep plugging 
away at this when I get time to get back on it. For now, here's a patch 
that should fix the problem of having to press spdif before word clock. 
  If it does work for you on the regular 1010, then the comments for 
both the 1010 and 1010lt are backwards (where 0 = word clock and 1 = spdif).

Doug
--
http://nostar.net/


--------------040702060505020800050209
Content-Type: text/x-patch;
 name="envy24control-wcselect.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="envy24control-wcselect.diff"

Index: hardware.c
===================================================================
RCS file: /cvsroot/alsa/alsa-tools/envy24control/hardware.c,v
retrieving revision 1.17
diff -u -r1.17 hardware.c
--- hardware.c  5 Dec 2005 21:03:06 -0000       1.17
+++ hardware.c  27 Dec 2005 20:47:24 -0000
@@ -128,6 +128,7 @@
        } else if (!strcmp(what, "SPDIF")) {
                internal_clock_set(13);
        } else if (!strcmp(what, "WordClock")) {
+               internal_clock_set(13); // Hack
                master_clock_word_select(1);
        } else {
                g_print("internal_clock_toggled: %s ???\n", what);

--------------040702060505020800050209--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
