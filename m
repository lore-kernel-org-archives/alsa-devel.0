From: Jeremy Hall <jhall@maoz.com>
Subject: Re: pcm_multi poll timeout error
Date: Fri, 9 Dec 2005 12:55:27 -0500 (EST)
Message-ID: <200512091755.jB9HtR5i008279@sith.maoz.com>
References: <20051209171605.GA4132@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20051209171605.GA4132@localhost.localdomain> from John Rigg at
 "Dec 9, 2005 05:16:05 pm"
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: John Rigg <ad@carbon-black.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

It probably works because the rme cards are synced by an external means 
such as word clock or the entity they are connected to has master sync

_J

In the new year, John Rigg wrote:
> On Fri, Dec 09, 2005 at 12:40:05PM +0100, Takashi Iwai wrote:
> > The link_fd returns the file descriptor for linking multiple PCM
> > streams.  If you comment it out, it means that no link is possible.
> > It means that snd_pcm_link() didn't do anything in fact after your
> > patch.
> 
> Hi Takashi
> 
> Thanks for the information. Now I'm puzzled. I assumed that pcm_multi
> was working from the messages from jackd -v, but didn't actually try
> recording and playing back simultaneously (haven't got that far setting
> up my system). However, I just received the following info from another
> user who tried my makeshift patch:
> 
> >> On Fri, Dec 09, 2005 at 02:10:49PM +0100, Achim_Kuntz wrote:
> >> 
> >>>I can confirm your results with my 2 x hdsp 9652 setup.
> >>>With your patch applied jackd works in duplex mode using the multi device.
> .... 
> >> Can you actually record and play back simultaneously?
> ....
> >Yes, I can record and play back simultaneously with the patch applied.
> >I tested playback for all 2*24=48 channels of the multi device while 
> >recording audio from the first channel of the first hdsp card, i.e. I 
> >tested all playback channels but not all recording channels. Everything 
> >seemed to work as intended.
> 
> I can't understand why this works after my patch broke snd_pcm_link .
> 
> John
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
