From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: Re: Prodigy 7.1 ?
Date: Wed, 15 Oct 2003 13:41:40 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1066221700.7989.63.camel@caernarfon>
References: <3FF3EBB8.6020503@aei.ca>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3FF3EBB8.6020503@aei.ca>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Apostolos Dimitromanolakis <apostolos@aei.ca>
Cc: ALSA Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

Unfortunately WM8770 driver development is not in my immediate to do
list. However, I do remember someone had done some work on the 8770
(possibly on the Aureon Terratec card). You may want to look at this as
a starting point for your driver.

You will also have to write some code for your audio controller chip
(ICE1724). This chip controls and sends/receives audio data to the
WM8770 codec. If your lucky, this chip may also be part of another
driver.

Cheers

Liam

P.S. Your PC clock is wrong.
  
On Thu, 2004-01-01 at 09:43, Apostolos Dimitromanolakis wrote:
> Hi,
>  I got today a Audiotrak Prodigy 7.1 soundcard which is based on the 
> ICE1724 chip. Since it's a lovely card (106db SNR, 106db DR codec), i'd 
> love to get it running under linux. I downloaded the latest alsa drivers 
> but there is no support for it. I'd volunteer to write some code to get 
> it working if there isn't anybody else doing the same.
> 
> For more information see: 
> http://www.digit-life.com/articles2/audiotrak-prodigy71/
> The card is based on the wonderful WM8770 codec (which alone costs 1/5 
> of the retail price of the card :)
> See: http://www.wolfsonmicro.com/products/digital_audio/codecs/WM8770/
> for the specs.
> 
> Are there any plans on supporting this chip?
> 
> Apostolos
> 
> PS Since I'me not yet subscribed to alsa-devel please cc my personal email
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: SF.net Giveback Program.
> SourceForge.net hosts over 70,000 Open Source Projects.
> See the people who have HELPED US provide better services:
> Click here: http://sourceforge.net/supporters.php
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 
> ________________________________________________________________________
> This email has been scanned for all viruses by the MessageLabs Email
> Security System. 
> ________________________________________________________________________
-- 
Liam Girdwood <liam.girdwood@wolfsonmicro.com>


Wolfson Microelectronics plc
www.wolfsonmicro.com
T +44 131 272 7000
F +44 131 272 7001
Registered in Scotland 89839

This message may contain confidential or proprietary information. If you receive this message in error, please immediately delete it, destroy all copies of it and notify the sender. Any views expressed in this message are those of the individual sender, except where the message states otherwise. We take reasonable precautions to ensure our Emails are virus free. However, we cannot accept responsibility for any virus transmitted by us and recommend that you subject any incoming Email to your own virus checking procedures.


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
