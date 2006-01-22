From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: some questions regarding multichannel devices
Date: Sun, 22 Jan 2006 17:46:49 -0500
Message-ID: <1137970009.1354.2.camel@mindpipe>
References: <43E897D5-9150-4960-8946-F6760B627283@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <43E897D5-9150-4960-8946-F6760B627283@caiaq.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, 2006-01-22 at 23:39 +0100, Daniel Mack wrote:
> Hi all,
> 
> I'm somehow confused about is the relationship between
> 
> 	- the number of registered snd_pcm_t instances
> 	- the number of substreams (4th and 5th param to snd_pcm_new()) and
> 	- the value of channels_min, channels_max in my snd_pcm_hardware_t
> 	  struct
> 

These should be set to reflect the capabilities of the hardware.
alsa-lib takes care of translating various formats and channel counts to
something the hardware can understand.  You don't have to worry about it
in the driver.

Substreams are only relevant if your device supports hardware mixing.

> If the device has multiple stereo input and outputs, where and how do I
> note that? Is it up to the caller how many streams are actually read/ 
> written?
> The hardware is not capable of only using some of the hardware channels,
> so I would have to throw away data after reception and fake data when  
> sending
> the stream, repectively.
> 
> Also, does a driver need to take care about supporting as much data  
> formats
> as possible (16/24/32 bits, LE/BE, ...)? Or is there any layer taking  
> care
> about proper conversion? And if there is such a layer, does any tool  
> make
> use of that? At least, aplay refused to play a big-endian wave file thru
> a device which only supports little-endian data transport according  
> to the
> snd_pcm_hardware_t struct.
> 
> I couldn't find any comprehensive information about that.
> 

See above - alsa-lib handles all these details for you, all you need to
consider when writing the driver is what the hardware supports.

> Thanks for any hint.
> Again, please Cc: me personally in replies, I'm still not subscribed.
> 
> Greets,
> Daniel
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
