From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: Re: [Jackit-devel] Real-world reports on two Delta 1010LTs/ice1712 synched?
Date: Wed, 18 Jan 2006 10:56:30 +0000
Message-ID: <200601181056.30490.gineera@aspect135.co.uk>
References: <20051224124823.GA4183@localhost.localdomain> <20060116175652.GM28738@edu.joroinen.fi> <43CBF383.3000807@nostar.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <43CBF383.3000807@nostar.net>
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

On Monday 16 January 2006 19:26, Doug McLain wrote:
> Good timing, I was just about to give a summary of my findings so far:
>
> First of all, the differences in the 1010LT vs the 1010 that are most
> relevent here, I believe, is the SPDIF i/o chips (cs8413 receiver,
> cs8404 xmitter) used on the 1010 vs the one single transceiver (cs8427)
> used on the 1010LT.  
>...
>  I am focusing on fixing spdif functionality, 
> Doug

It may be of interest to know that the Terratec DMX6fire, which I have, also 
uses the cs8427, but has both coax and optical SPDIF.  The dig out works OK 
on both, as soon as the snd-ice-1712 is loaded.  It runs without needing any 
'In' clock as you describe with 1010LT.  I can select internal clock freqs 
and detect in my mini-disc recorder 32K, 44.1K, 48K using the coax (and 
optical).  Other rates are not supported by the MD so I can't be sure.  There 
are however some issues with digital in, but by selecting in the right 
sequence this works fine also.

A look at the DMX6fire code therefore may be rewarding?

Alan



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
