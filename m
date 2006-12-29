From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Sound Driver Querry
Date: Fri, 29 Dec 2006 13:11:24 +0000
Message-ID: <459513FC.1000008@superbug.co.uk>
References: <b92b327b0612272310r142092e5nc7ca9b4d50c7460e@mail.gmail.com>	<1167393462.11374.25.camel@localhost.localdomain>
	<b92b327b0612290416u49fa792axd5737a79bed3498e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <b92b327b0612290416u49fa792axd5737a79bed3498e@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Ajay Jain <ajay050@gmail.com>
Cc: alsa-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Ajay Jain wrote:
>> What arm cpu are you using ?
> 
> We are using an ARM926-EJS. The interface between the code chip and
> the cpu, is by our own proprietary I2C controller. Is it possible for
> us to integrate this?

I2C interfaces (for codec control, not audio samples) are very simple, 
so supporting that should be quite easy.
It depends what is connected to the I2C interface. If it is just the 
codec, then you can write some simple ALSA specific code. If it also 
links to other I2C devices on the same bus, then you should implement 
support for it via the Linux Kernel I2C bus.

> BTW, the patch you just mentioned, is that not in the main line
> 2.6.latest? We are using a 2.6.14, so is it possible to backport it?
> 
>> OSS audio is deprecated in the Linux 2.6 kernel.
> Ok, but we have a working & robust AC97 WM9712 driver for the same. It
> would be much more convenient for us if we have something similar in
> OSS. So is this guy (the WM8751), supported in any form in the OSS?
> 

Do you have the I2S interface already working?
The WM9751 might default to some sensible register values, so purely 
sending audio samples to the I2S interface might be enough to get your 
sound out.

James

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
