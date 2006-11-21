From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Long-standing 5.1ch huge LFE/rear swap annoyance
 (ALSA vs. Windows!)
Date: Tue, 21 Nov 2006 11:21:19 +0100
Message-ID: <1164104479.17922.276761381@webmail.messagingengine.com>
References: <20061118013834.GA22785@rhlx01.hs-esslingen.de>
	<1164031610.1310.276596069@webmail.messagingengine.com>
	<s5hzmamkx5j.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hzmamkx5j.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: Andreas Mohr <andi@rhlx01.fht-esslingen.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Clemens Ladisch wrote:
> > ...
> > and there is not yet an ALSA configuration file for remapping channels
> > on USB devices.
> > ...
> > I'm working on this.
> 
> What solution in sight?

Creating a surround51 device with a route plugin is trivial.

Selecting device-specific device definitions can be done with a new
card_shortname configuration function and lots of indirections.

The biggest problem is dmix.  I do no want to impose some default sample
rate/format on unknown devices because this would break most USB
headsets or other unusual devices.  I think the best solution would be
to add an option to dmix to automatically select some suitable sample
format when it's first opened.


Regards,
Clemens

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
