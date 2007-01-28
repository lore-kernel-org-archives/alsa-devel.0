From: Tim <terminator356@users.sourceforge.net>
Subject: Re: ice1712 IPGA and ADC controls
Date: Sun, 28 Jan 2007 20:54:15 +0000 (UTC)
Message-ID: <loom.20070128T211007-41@post.gmane.org>
References: <loom.20070120T001557-202@post.gmane.org>
	<s5hbqkrf96d.wl%tiwai@suse.de>
	<loom.20070126T022638-883@post.gmane.org>
	<200701262325.33755.gineera@aspect135.co.uk>
	<20070127123807.GA2662@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Tim wrote:
> > > What happened to all the input gain controls (IPGA) in the ice1712 
driver?
Alan wrote:
> >     - ak4xxx - Remove bogus IPGA controls

I just looked at the AK4524 datasheet. 
Well, the gain and attenuation are certainly two seperate 
 parts of the chip combined into one register. But ultimately 
 are two means to an end.
Table 12, the IPGA Code Table says it all, for me.
See that gain (db) column? 
THAT is what I want to see when I look at a slider! How 'bout you?
To merge a point made previously: If users of these cards are 
 more "technical" or "professional", then they will understand
 what they are doing, either because they know, or we simply tell 
 them with a helpful line about this matter in the readme.
Right?
BTW if any mixer out there is to do this correctly it could only
 be envy24control. I don't know if any standard alsa mixer could 
 know about the specific db steps on these chips.

My spider senses tell me the envy24control devels are working on this. 
Right guys?... Hello?...

Tim.
P.S. I said I had trouble with envy24control. Switched to newest one. All OK!




-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
