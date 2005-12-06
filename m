From: Trevor Feeney <trev@feens.org>
Subject: Re: M-Audio Revolution 5.1 Support
Date: Tue, 6 Dec 2005 14:46:13 +0000 (UTC)
Message-ID: <loom.20051206T154004-517@post.gmane.org>
References: <loom.20051201T152934-108@post.gmane.org> <loom.20051201T211819-384@post.gmane.org> <s5h1x0vhib0.wl%tiwai@suse.de> <4390B421.9030304@seznam.cz> <s5h1x0rmjkj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

> The question is again how it's connected.  Does it use another codec
> chip or the same one with a different channel?
> 
> In the former case, it might be set/reset with another GPIO pin as the
> chip select (CS).  Usually this is used to select a given code to set
> up, and to initialize/finish the I2C/SPI transfer.

Was taking a look at the source for the Revo 5.1, noticed a few things.  
You set it up as using only 6 DACs, going by the 5.1 I figure, but when 
you consider that it also has the headpone out, it would have the same 
number of DACs as the 7.1 (8 DACs in all).

>From what I've read, the 5.1 only uses one codec, and the headphones would just
be a separate channel.  I tried adjusting the number of DACs to 8 in the driver,
and did manage to get two DAC mixer sliders.  I'm not really sure if that was
the way to go or not.  I tried adjusting the asound plugin to output to 8
channels, pcm 
device surround71, but that didn't seem to work.  I wondering if it needs to be
setup separately thant the other 6 channels so that it would be considered it's
own PCM device.  That goes a bit beyond my realm of knowledge for driver 
development though...still trying to learn this.  Been reading a lot of the 
documents and such. 

Anyways, just thought I'd try and help where I could.

Trevor 





-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
