From: John Rigg <ad@carbon-black.co.uk>
Subject: Re: pcm_multi poll timeout error
Date: Fri, 9 Dec 2005 20:15:02 +0000
Message-ID: <20051209201502.GA3751@localhost.localdomain>
References: <20051209171605.GA4132@localhost.localdomain> <200512091755.jB9HtR5i008279@sith.maoz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200512091755.jB9HtR5i008279@sith.maoz.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jeremy Hall <jhall@maoz.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 09, 2005 at 12:55:27PM -0500, Jeremy Hall wrote:
> In the new year, John Rigg wrote:
> > On Fri, Dec 09, 2005 at 12:40:05PM +0100, Takashi Iwai wrote:
> > > The link_fd returns the file descriptor for linking multiple PCM
> > > streams.  If you comment it out, it means that no link is possible.
> > > It means that snd_pcm_link() didn't do anything in fact after your
> > > patch.
> > 
> > I can't understand why this works after my patch broke snd_pcm_link .
>
> It probably works because the rme cards are synced by an external means 
> such as word clock or the entity they are connected to has master sync

Makes sense. So, the situation appears to be:
1 - The link code is unnecessary for duplex operation of multiple
clock-synchronised sound cards with jackd.
2 - It breaks the above when present.

John


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
