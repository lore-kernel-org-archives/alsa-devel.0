From: William <walsac2@liam2.demon.co.uk>
Subject: Re: CVS ALSA failed upgrade in Linux 2.6.3
Date: Wed, 3 Mar 2004 15:54:24 GMT
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200403031554.PAA07108@liam2.demon.co.uk>
References: <40452FE3.8080202@superbug.demon.co.uk>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <40452FE3.8080202@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James@superbug.demon.co.uk
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

James Courtier-Dutton <James@superbug.demon.co.uk> wrote:
>
>The point of option 1 is to explain how to upgrade alsa if you need to. 
>Not everyone needs to upgrade.

My point was that the explanation given in option is actually confusing.
I guess it's the wiki problem of many different people collaboratively
editing a wiki page, leading to incoherency.  That wiki page would probably
benefit from having just one person rewrite it from scratch.

>If you wish to use the cvs, you have to get alsa-driver and alsa-kernel, 
>because alsa-driver uses files from ../alsa-kernel

Yes, I knew that already but what I didn't know was that it is best
to install alsa-driver not alsa-kernel to get all the new/experimental drivers.

>So, if you follow the cvs command exactly it will work.

It didn't work (Unknown symbols in snd*) but at least I know why (Takashi said
the CVS alsa-driver is currently in the middle of a major rewrite).
Thanks anyway.

William


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
