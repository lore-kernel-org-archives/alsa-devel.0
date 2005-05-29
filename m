From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH] emu10k1 cleanups
Date: Sun, 29 May 2005 16:18:46 -0400
Message-ID: <1117397926.20387.7.camel@mindpipe>
References: <1117339570.19303.4.camel@mindpipe>
	 <4299947B.30202@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4299947B.30202@superbug.co.uk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 2005-05-29 at 11:07 +0100, James Courtier-Dutton wrote:
> Sorry, I can't accept this patch.
> Different chips have different capabilities, and the ca0108(Audigy 2
> Value) certainly does not have a ca0151 (P16V) chip.

That's why I used || rather than &&.  But I see your point.

> The ca0102 is the DSP chip on Audigy 2 cards (and possibly Audigy 1, I
> don't know for sure).
> emu10k2 is to indicate that the card has all the same features of the
> DSP chip found on Audigy 1 and Audigy 2 and Audigy 2 Value cards.
> So, the information is not redundent.
> 

OK, thanks for the info.  That's why I posted the rough version before
spending any serious time on it.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
