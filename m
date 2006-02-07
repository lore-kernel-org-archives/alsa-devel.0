From: John Rigg <ad@sound-man.co.uk>
Subject: Re: Multi Delta 1010 sync
Date: Tue, 7 Feb 2006 19:06:41 +0000
Message-ID: <20060207190641.GA3516@localhost.localdomain>
References: <20060205161525.GA2691@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20060205161525.GA2691@localhost.localdomain>
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

On Sun, Feb 05, 2006 at 04:15:25PM +0000, John Rigg wrote:
> The S/PDIF receiver OTOH uses its own internal PLL which works with 96kHz
> sample rate. However,I couldn't sync reliably using the S/PDIF in/outs with
> one card as master and the other as slave. At 96kHz jackd would die at random
> times with a floating point exception, so often it was unusable.
> At 48kHz this would still happen, but not often (every couple of hours).
> I'm guessing that this is due to a phase difference between master and
> slave clocks.

An update: the floating point exception was a divide-by-zero error
in jackd that only occurred sporadically.
The Delta 1010s sync perfectly well via the S/PDIF in/outs with one card
as master and the other as slave.

To summarize:
Word clock inputs work at 48kHz but not higher due to a hardware
limitation.
S/PDIF inputs can be used to sync up to 96kHz.

John


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
