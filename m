From: Chris Cannam <cannam@all-day-breakfast.com>
Subject: Re: alsa timer slippage
Date: Mon, 15 Dec 2003 09:16:03 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200312150916.03357.cannam@all-day-breakfast.com>
References: <E1AVXB7-00025m-JG@sc8-sf-list2.sourceforge.net> <200312150230.33546.plcl@telefonica.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200312150230.33546.plcl@telefonica.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Pedro Lopez-Cabanillas <plcl@telefonica.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Monday 15 Dec 2003 1:30 am, Pedro Lopez-Cabanillas wrote:
> The ALSA MIDI sequencer can use several timer sources. By default,
> it uses the Linux system timer functions [...]
> Other timer sources are PCM devices and the RTC timer.

Ah... so that puts Jan's comment into perspective.  I could have been 
using the soundcard to sync from, but I wasn't.  And indeed, 
switching the timer for this queue to the first PCM device gives me 
vastly better results.

This seems to suggest that the default system-based timer is doing 
something a bit naive, like assuming it was called back on time 
without actually checking.


Chris



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
