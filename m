From: John Rigg <ad@carbon-black.co.uk>
Subject: Re: pcm_multi poll timeout error
Date: Fri, 9 Dec 2005 17:16:05 +0000
Message-ID: <20051209171605.GA4132@localhost.localdomain>
References: <E1EkRD2-00016x-Kb@localhost.localdomain> <s5hr78mzega.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hr78mzega.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 09, 2005 at 12:40:05PM +0100, Takashi Iwai wrote:
> The link_fd returns the file descriptor for linking multiple PCM
> streams.  If you comment it out, it means that no link is possible.
> It means that snd_pcm_link() didn't do anything in fact after your
> patch.

Hi Takashi

Thanks for the information. Now I'm puzzled. I assumed that pcm_multi
was working from the messages from jackd -v, but didn't actually try
recording and playing back simultaneously (haven't got that far setting
up my system). However, I just received the following info from another
user who tried my makeshift patch:

>> On Fri, Dec 09, 2005 at 02:10:49PM +0100, Achim_Kuntz wrote:
>> 
>>>I can confirm your results with my 2 x hdsp 9652 setup.
>>>With your patch applied jackd works in duplex mode using the multi device.
.... 
>> Can you actually record and play back simultaneously?
....
>Yes, I can record and play back simultaneously with the patch applied.
>I tested playback for all 2*24=48 channels of the multi device while 
>recording audio from the first channel of the first hdsp card, i.e. I 
>tested all playback channels but not all recording channels. Everything 
>seemed to work as intended.

I can't understand why this works after my patch broke snd_pcm_link .

John


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
