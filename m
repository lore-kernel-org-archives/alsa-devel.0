From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: Re: [ANNOUNCE] ASoC 0.8
Date: Thu, 01 Dec 2005 12:41:51 +0000
Message-ID: <1133440911.3450.72.camel@localhost.localdomain>
References: <1133391055.3314.175.camel@localhost.localdomain>
	 <s5hbr01ggrt.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hbr01ggrt.wl%tiwai@suse.de>
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
Cc: Giorgio Padrin <giorgio@mandarinlogiq.org>, Richard Purdie <rpurdie@rpsys.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 2005-12-01 at 13:09 +0100, Takashi Iwai wrote:

> 
> Is this version intended to submit to linux-kernel tree, too?
> Otherwise, I'd like to keep it in alsa-driver tree.
> 

Yes, that's the eventual aim. The API is not quite stable enough for
linux-kernel yet, but it is getting there.

We also don't have the big xxx_t change in ASoC yet, as our machine
development kernels are based on Linus tree (for best machine support)
and will be updated to the new naming as soon as 1.0.10 is in mainline.

I'd like to think about submitting to alsa-kernel at about xmas time.
Ideally we would be able to submit:-

 o ASoC core (including dpm)
 o platform driver for pxa2xx
 o Machine drivers for Corgi, Spitz, Borzoi, Akita, Tosa, Mainstone
 o Codec drivers for WM8731, WM8750, WM8753, WM8971, UDA1338 (from
Giorgio)

Richard, Giorgio, do you think this is reasonable for xmas time ?

I'm going to send a road map to the list later today for comments. We
should then be able to come up with a more concrete schedule. 
 
Liam 



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
