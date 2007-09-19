From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: OSS app works but aplay does not with
 SNDRV_PCM_FMTBIT_U32_LE
Date: Wed, 19 Sep 2007 18:03:12 +0200
Message-ID: <1190217792.23470.1211502657@webmail.messagingengine.com>
References: <0MKpCa-1IXhxr0egN-0007WC@mrelay.perfora.net>
	<1190184377.23573.1211414421@webmail.messagingengine.com>
	<0MKp8S-1IY1GZ25ZF-0008LO@mrelay.perfora.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 59515245F6
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Sep 2007 18:03:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <0MKp8S-1IY1GZ25ZF-0008LO@mrelay.perfora.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Steve Strobel <steve.strobel@link-comm.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Steve Strobel wrote:
> At 12:46 AM 9/19/2007, Clemens Ladisch wrote:
> > or did you create a card-specific .conf file for your controller?
> 
> Not intentionally, but there might be one left over from the AD1836 
> driver I started with (I have just been modifying that driver, 
> planning to rename it after I get it working).  Where would I look 
> for such a file?

In /usr/share/alsa/cards/, with the driver name.


Does it work when running aplay with the parameter "-D plughw"?


Regards,
Clemens
