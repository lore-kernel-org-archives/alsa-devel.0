From: juan <jcb@niluge.net>
Subject: Re: maestro3 driver hangs dell laptop
Date: Thu, 7 Aug 2003 17:19:03 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030807151903.GA23585@athena>
References: <20030803210237.GA1176@zeus.homenet> <s5hr840kxyt.wl@alsa2.suse.de> <20030805140827.GB25707@athena> <s5hptjkkxbt.wl@alsa2.suse.de> <20030807000435.GA12100@athena> <s5h4r0tletm.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h4r0tletm.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thursday 07 August, 2003 ? 04:31:17PM +0200, Takashi Iwai wrote:
> 
> well, then it's difficult to debug...
> 
> my wild guess is that a pending irq is issued which is not processed
> nor ack'ed by snd-maestro3's interrupt handler.  or, possibly, a wrong
> set-up of GPIOs.

what method do you propose to locate the bug ?
someone suggested to put prinks in the maestro functions...
 
> but in both cases, i have no idea what can cause after two seconds,
> not immediately after the loading of the module.
> are other modules (e.g. network, etc) share the same irq?

no the card has the irq 5 for itself


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
