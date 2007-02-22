From: Jean-Marc Valin <jean-marc.valin@usherbrooke.ca>
Subject: Re: Quality resampling code for libasound
Date: Thu, 22 Feb 2007 22:48:57 +1100
Message-ID: <45DD8329.6080809@usherbrooke.ca>
References: <45D92131.50601@usherbrooke.ca>	<s5hirdy72ue.wl%tiwai@suse.de>	<45D99DF7.90204@usherbrooke.ca>	<s5hhcti70pa.wl%tiwai@suse.de>	<45D9A848.9040803@usherbrooke.ca>	<s5h7iue6yyi.wl%tiwai@suse.de>	<45DA8CD2.1040606@usherbrooke.ca>	<s5hps85rtsr.wl%tiwai@suse.de>	<45DAE188.6010405@usherbrooke.ca>	<s5hfy91rprn.wl%tiwai@suse.de>	<45DAEBB8.70808@usherbrooke.ca>	<45DB713F.9090804@superbug.co.uk>	<45DC0E52.1060805@usherbrooke.ca>
	<s5hodnm7774.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hodnm7774.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, James Courtier-Dutton <James@superbug.co.uk>
List-Id: alsa-devel@alsa-project.org

> Thanks, now committed to HG tree.

Good, thanks.

>> So I'm attaching both a patch for rate_samplerate and a new version of
>> my resampler plugin (now BSD-licensed). Both seem to work much better
>> with the numerator and denominator in the right place. I still haven't
>> changed the code to resolve the symbol conflict, but I'll do that soon.
> 
> Regarding the license, LGPL would be suitable especailly if thinking
> about merging the code to alsa-lib tree later.  Other codes in
> alsa-lib are all LGPL, so putting a BSD piece isn't fun.  The license 
> can be changed at merge time, though.
> Of course, if you prefer BSD, it's fine.  We can keep it as is.

I don't mind at all relicensing to plugin to LGPL, since it's a part of
ALSA anyway. The resampler itself is BSD and whenever possible, I'd
really like to have any patch/fix to it available under the BSD. In any
case, since any BSD code can be easily integrated into LGPL code, it
shouldn't be a problem.

>> Can everyone give this a bit of testing? I hope we can soon get rid of
>> linear resampling as the default resampling once and for all.
> 
> Looks working good as long as I've tested.
> Could you give a short document for this plugin, too (put in
> alsa-firmware/doc)?

What kind of document do you want? I can't find anything about the other
sample rate converters, so I'm not sure what it should look like.

	Jean-Marc

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
