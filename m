From: Fons Adriaensen <fons@kokkinizita.net>
Subject: Re: ice1712 IPGA and ADC controls
Date: Mon, 29 Jan 2007 10:47:43 +0100
Message-ID: <20070129094743.GA5846@linux-2.site>
References: <loom.20070120T001557-202@post.gmane.org>
	<20070127123807.GA2662@localhost.localdomain>
	<loom.20070128T211007-41@post.gmane.org>
	<200701290909.05343.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200701290909.05343.gineera@aspect135.co.uk>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Alan Horstmann <gineera@aspect135.co.uk>
Cc: Tim <terminator356@users.sourceforge.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 29, 2007 at 09:09:05AM +0000, Alan Horstmann wrote:

> Also, lets not confuse the controls the alsa driver provides with how a GUI 
> mixer such as envy24control presents those to a user.  It seems (Takashi 
> please confirm) that this change is removing the separate controls from the 
> AK4524 driver code, meaning that no alsa-driver using AK4524 can provide them 
> separately.  With a single control the driver has no way to dictate labelling 
> of '0dB' level (or any other useful notes) when used in a mixer.

I missed the start of this thread, but if the idea is to combine analog and
digital gain controls into one, that would be _a very bad idea_ and make a
card useless for any pro or semi-pro use. 

If users don't understand the difference, they should be informed. If they
still don't want to understand it, they should be encouraged to switch to
some other form of entertainment.


-- 
FA

Lascia la spina, cogli la rosa.


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
