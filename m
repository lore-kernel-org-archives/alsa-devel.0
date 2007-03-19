From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: Presario ALC260 info
Date: Mon, 19 Mar 2007 15:50:52 +1030 (CST)
Message-ID: <200703190520.l2J5Kqf7015207@turbo.physics.adelaide.edu.au>
References: <200703181221.39532.david.friggens@mcs.vuw.ac.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200703181221.39532.david.friggens@mcs.vuw.ac.nz> from "David
	Friggens" at Mar 18, 2007 01:21:38 PM
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: David Friggens <david.friggens@mcs.vuw.ac.nz>
Cc: alsa-devel@lists.sourceforge.net, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
List-Id: alsa-devel@alsa-project.org

Hi David

> Hi. Sorry for my late reply - I was out Friday night and most of 
> yesterday.

No problem - I've been kind of busy myself.

> > It's probably worth noting that the EAPD line is shared with the same
> > pin used for SPDIF Input.  Laptops which support SPDIF input would
> > have to use GPIO to switch any external amplifiers in use, but for
> > those which don't (which I assume includes the HP at the centre of
> > the present discussion) they could use EAPD if desired.
> 
> The specs say "SPDIF (supported via adapter connected through headphone 
> out)"
> 
> http://h10010.www1.hp.com/wwpc/au/en/ho/WF06b/1090709-1116637-1123071-1123071-1123071-12833604-78011799.html

Hmm.  My netlink is down at present so I can't check this.  If this refers
only to SPDIF *output* then this is still OK - EAPD is on the same pin as
SPDIF *input*.  However, if the machine can also do SPDIF input via this
"adapter" then that may indicate that the ALC260's EAPD functionality isn't
used since that pin is required for SPDIF input.  Then again, having said
that, I think it is possible they could use the same pin for both with some
clever engineering.

Anyway, I'll try to get a patch done up soon to test the theory.  Then we'll
know for sure.

Regards
  jonathan

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
