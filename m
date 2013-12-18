From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: firewire-lib: Add support for AMDTP transmit stream and PCM
	capture
Date: Wed, 18 Dec 2013 20:57:17 +0900
Message-ID: <52B18D9D.5020905@sakamocchi.jp>
References: <1385186884-8259-1-git-send-email-o-takashi@sakamocchi.jp>
	<1385186884-8259-6-git-send-email-o-takashi@sakamocchi.jp>
	<52936C65.9020602@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <52936C65.9020602@ladisch.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Clemens Ladisch <clemens@ladisch.de>, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Clemens,

(Nov 26 2013 00:27), Clemens Ladisch wrote:
> It might be a good idea to completely drop S16 support.

As long as I investigated some resources given by Echo Audio, there are 
no way to change PCM format in transmitted packet. This is the same for 
some documents related to BeBoB.

So I agree with this idea for Fireworks/BeBoB. But I don't know about 
the other devices.


Regards

Takashi Sakamoto


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
