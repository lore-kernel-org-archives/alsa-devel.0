From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: [PATCH] Make internal speaker work on Acer C20x
	tablets
Date: Mon, 4 Dec 2006 11:30:53 +1030 (CST)
Message-ID: <200612040100.kB410rDf030126@turbo.physics.adelaide.edu.au>
References: <638836.1365.qm@web30408.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <638836.1365.qm@web30408.mail.mud.yahoo.com> from "Valentin
	Rodriguez" at Dec 01, 2006 03:21:38 PM
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Valentin Rodriguez <valemie@yahoo.com.sg>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
List-Id: alsa-devel@alsa-project.org

Hi Val

> I am sorry I have not replied earlier. ...

Not to worry.

> Except for the lower volume in the headphone jack,
> everything works fine. I just use the line jack for
> the headphone if I require a louder output.

It would be good to address the low "headphone" jack volume; what's it like
under other operating systems?  Maybe Acer's gone and done something odd
with this jack.  What is surprising is that the "line" jack (which I assume
is your "mic/line" jack) when configured for output produces more volume. 
That would almost suggest that Acer has some additional resistors or
something in the "headphone" jack circuit.  You don't happen to know the
impedence (measured in ohms) your headphones are, do you?

Thanks for the confirmation of a working system with this patch.  The
patch is now in HG and should make the next ALSA release (which I guess
will be 1.0.14).

Regards
  jonathan

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
