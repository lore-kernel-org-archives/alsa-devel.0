From: The Orqwith Vagrant <theorqwithvagrant@bredband.net>
Subject: Re: Re: [Alsa-user] Audigy SPDIF Output Sample Rate
Date: Tue, 01 Mar 2005 08:45:18 +0100
Message-ID: <1109663118.24651.30.camel@cthulhu.rlyeth.net>
References: <1108880895.6773.50.camel@radium.gaugetheory.org>
	 <1109351825.9681.43.camel@krustophenia.net>
	 <1109367868.6245.9.camel@cthulhu.rlyeth.net>
	 <1109368727.13193.10.camel@krustophenia.net>
	 <1109371150.14056.2.camel@krustophenia.net>
	 <1109499431.1590.819.camel@radium.gaugetheory.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <1109499431.1590.819.camel@radium.gaugetheory.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Brian L Scipioni <brian@gaugetheory.org>
Cc: Lee Revell <rlrevell@joe-job.com>, alsa-user@lists.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 2005-02-27 at 05:17 -0500, Brian L Scipioni wrote:
> Lee,
> 
> > Please try the attached patch (revert the last patch first).
> 
> I tried this patch (emu10k1-96-fix2.patch) against the Saturday, 2/26,
> CVS and I still get 41000 alsamixer = 96000 IEC958 out.
> 
> I never tried the previous patch, so did not revert it.  Do I have the
> right versions of CVS+patch?
> 
> thanks,
> brian
> 

Yes, that's the cvs version i applied the patch against, and it
definitely works right for me. Are you positive you got the old driver
completely unloaded before you tried loading the new one? Or maybe you
forgot to do a "make install" after the ./cvscompile? I've ended up
scratching my head after forgotting that step a couple of times myself.
Happens to the best of us. :)



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
