From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Hardware info for SBLive platinum
Date: Sat, 26 Mar 2005 22:04:04 +0000
Message-ID: <4245DC54.6070206@superbug.co.uk>
References: <1111873989.783.10.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
In-Reply-To: <1111873989.783.10.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:
> James,
> 
> My old SBLive! platinum is being detected as "SBLive! [Unknown]".
> Here's some info:
> 
> 0000:00:0f.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 05)
>         Subsystem: Creative Labs CT4760 SBLive!
> 
> 0000:00:0f.0 0401: 1102:0002 (rev 05)
>         Subsystem: 1102:8040
> 
> I feel like an idiot, but I don't see a model number of the form SB0xxx
> anywhere.  Is CT4760 the model number?
> 
> Lee
> 
> 

Yes, CT4760 is the model number.
See http://us.creative.com/support/identifyproduct/

I will add that ID to the snd-emu10k1 driver
Do you use any special extin/extout with it. I might add automatically
setting those to the detection code.

James



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
