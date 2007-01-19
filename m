From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Having issues with an I2S driver
Date: Fri, 19 Jan 2007 16:33:18 +0100
Message-ID: <1169220798.25944.1170118961@webmail.messagingengine.com>
References: <AAFF1BF1-5C84-44DD-8545-64007D2242D4@purdue.edu>
	<1169193230.11297.1170063083@webmail.messagingengine.com>
	<F9A92F07-03A7-4DC8-AF91-1FC84C52021E@purdue.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <F9A92F07-03A7-4DC8-AF91-1FC84C52021E@purdue.edu>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Chase Douglas <cndougla@purdue.edu>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Chase Douglas wrote:
> On Jan 19, 2007, at 2:53 AM, Clemens Ladisch wrote:
> > In this case, the driver should just use 32-bit samples directly and let
> > the ALSA library handle the sample format conversion.
> 
> I wouldn't mind using 32-bit samples, but, if I remember correctly, I  
> can't drive the cirrus logic cs4271 I2S codec chip at a bitrate that  
> would require. I'm currently converting from 16 bit to 24 bit samples  
> to send out to the codec chip because 16 bit samples are easier to  
> keep track of than 24 bit samples when converting to a 32 bit stream.

Well, then use 24-bit samples.

Just use the format that your hardware uses so that the driver doesn't
have to do any conversion.

> I'm sort of an alsa driver newbie so I really don't know the alsa  
> architecture very well. If Mplayer tries to play a 16 bit sampled  
> audio file and requests such sampling from alsa, but the driver only  
> supports 24 bit, does alsa take a 16 bit and do the conversion for me?

Yes.


Regards,
Clemens

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
