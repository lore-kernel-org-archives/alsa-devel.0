From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: Re: GPIO on envy24ht M-Audio 192
Date: Wed, 02 Aug 2006 20:50:59 +0100
Message-ID: <1154548259.2636.54.camel@localhost.localdomain>
References: <1154390773.1991.1.camel@server> <s5hd5bkbfrw.wl%tiwai@suse.de>
	<1154454336.3383.8.camel@server> <s5hvepbhzhx.wl%tiwai@suse.de>
	<1154536420.7149.2.camel@server> <s5hslkfhypo.wl%tiwai@suse.de>
	<1154539779.7149.7.camel@server>  <s5hk65rhwam.wl%tiwai@suse.de>
	<1154547463.7149.9.camel@server>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1154547463.7149.9.camel@server>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Cruise X Overide <cruiseoveride@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 2006-08-02 at 15:37 -0400, Cruise X Overide wrote:

> 
> how do i figure out the i2c address of each codec chip
> is this in the datasheet of the aks?
> 
> 

Yes.

Codec's usually support a few i2c addresses. The address is usually set
by the level of another codec pin being held high or low at power on.
All this information is in the codec datasheet.

Liam


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
