From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: Speaker Sound on acer travelmate c202 with ALC260
	using test model
Date: Mon, 20 Nov 2006 09:59:52 +1030 (CST)
Message-ID: <200611192329.kAJNTqjo026476@turbo.physics.adelaide.edu.au>
References: <mailman.55930.1163948231.8777.alsa-devel@lists.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <mailman.55930.1163948231.8777.alsa-devel@lists.sourceforge.net>
	from "alsa-devel-request@lists.sourceforge.net" at Nov 19,
	2006 06:57:11 AM
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
Cc: valemie@yahoo.com.sg, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
List-Id: alsa-devel@alsa-project.org

Hi Valentin

> I managed to get speaker sound on my acer travelmate c202 tablet pc using
> the test model. Except for hard disk and memory size, the c202 is the same
> as the c204 discussed earlier as unable to get sound on the built-in
> speaker. I think the key to having speaker sound on this model is to have
> the "mono" control enabled on this "acer" model.

This is interesting; I thought there were two speakers on these laptops, in
which case it's a little surprising that they would drive them with the mono
output from the ALC260.  Stranger things have happened though.

Can you confirm for sure that it definitely is the "mono" control which lets
you get sound out of the speaker in your case?  In fact, the best thing
would be to repeat your tests and then let me know exactly which alsamixer
controls needed to be used (and at which settings) in order to get sound out
of the speaker.

> Only GPIO pin 0 have to be on to get sound. All the other GPIO pins can
> remain off.

That's consistent with other ACER models.  That's good.

Thanks for the detailed report; hopefully we can build on this and finally
get these pesky speakers working. :) At least we now know that it's
possible.

Regards
  jonathan

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
