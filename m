From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: Quality resampling code for libasound
Date: Tue, 20 Feb 2007 13:50:44 -0800
Message-ID: <1172008244.22664.21.camel@cmn3.stanford.edu>
References: <45D92131.50601@usherbrooke.ca>	<s5hirdy72ue.wl%tiwai@suse.de>
	<45D99DF7.90204@usherbrooke.ca>	<s5hhcti70pa.wl%tiwai@suse.de>
	<45D9A848.9040803@usherbrooke.ca>	<s5h7iue6yyi.wl%tiwai@suse.de>
	<45DA8CD2.1040606@usherbrooke.ca>	<s5hps85rtsr.wl%tiwai@suse.de>
	<45DAE188.6010405@usherbrooke.ca> <s5hfy91rprn.wl%tiwai@suse.de>
	<45DAEBB8.70808@usherbrooke.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <45DAEBB8.70808@usherbrooke.ca>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Jean-Marc Valin <jean-marc.valin@usherbrooke.ca>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 2007-02-20 at 23:38 +1100, Jean-Marc Valin wrote:
> >>> That's one part making alsa-lib rate plugin so complicated.
> >>> Anyways, the resampling algorithm plugin doesn't take care much about
> >>> it, so far.
> >> Are you telling me people use the high-quality sinc in libsamplerate
> >> just to have the plugin drop samples once in a while? Can we just have a
> >> resampler that actually produces valid output once and for all? I guess
> >> it's another good reason to go directly with a non-plugin resampler.
> > 
> > No, I mean that there are many black magics in the alsa rate plugin to
> > calculate the sampling buffer size constant so that the resampler side
> > doesn't take care of it so much.  And this has nothing to do with the
> > fact whether it's an external plugin or not.
> 
> OK, so plugin or not, how do you actually make sure you process all
> samples and not just the ones that are the most convenient? I can't
> believe I'm the only one here who actually cares about having correct
> audio coming in/out the soundcard.

You are not alone (at least two of us? :-)

Linear interpolation works great as long as you don't have to listen to
the output :-) Maybe nobody does... If somebody needs linear interp
(slow processors?) they should be able to ask for it, but the default
should be something more usable (and a better match to the "Advanced"
part of the ALSA acronym). 

-- Fernando



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
