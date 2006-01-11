From: Daniel Mack <daniel@caiaq.de>
Subject: Re: (no subject)
Date: Wed, 11 Jan 2006 12:29:22 +0100
Message-ID: <533D5273-459F-4944-883A-CDD71CD60180@caiaq.de>
References: <5C7B81E1-2824-427D-A874-A2504CE695EA@caiaq.de> <s5hk6d8f1uv.wl%tiwai@suse.de> <1136920321.43c4070136910@webmail.uni-halle.de>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1136920321.43c4070136910@webmail.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

On Jan 10, 2006, at 8:12 PM, Clemens Ladisch wrote:
> The synchronization of the PCM output sample rate might be a  
> problem -- if the
> device doesn't use a standard USB synchronization mechanism  
> (synchronous/
> asynchronous/adaptive), the driver would have to be hacked some more.
> (Playback on the UA-1000 doesn't work because the driver doesn't  
> (yet) support
> synchronizing the output PCM stream to the input PCM stream.)

I wrote a driver stack for this device for MacOSX already and attended
the development for the Windows version. They both work fine and so I
have some code to orientate on.

> The driver currently assumes that each (output/input) PCM endpoint  
> has its
> own interface (where it can select alternate settings independently).
> Is this the case?

No. All audio data is muxed and sent over one single endpoint and  
receviced
from another.

I think I have to write it from scratch to keep it straight forward.

Thanks for your suggestions, let's see how far I get.

Daniel





-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
