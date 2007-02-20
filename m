From: Jean-Marc Valin <jean-marc.valin@usherbrooke.ca>
Subject: Re: Quality resampling code for libasound
Date: Wed, 21 Feb 2007 09:45:00 +1100
Message-ID: <45DB79EC.2030900@usherbrooke.ca>
References: <45D92131.50601@usherbrooke.ca>	<s5hirdy72ue.wl%tiwai@suse.de>	<45D99DF7.90204@usherbrooke.ca>	<s5hhcti70pa.wl%tiwai@suse.de>	<45D9A848.9040803@usherbrooke.ca>	<s5h7iue6yyi.wl%tiwai@suse.de>	<45DA8CD2.1040606@usherbrooke.ca>	<s5hps85rtsr.wl%tiwai@suse.de>	<45DAE188.6010405@usherbrooke.ca>	<s5hfy91rprn.wl%tiwai@suse.de>
	<45DAEBB8.70808@usherbrooke.ca> <45DB713F.9090804@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <45DB713F.9090804@superbug.co.uk>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> Unfortunately, the real problem with the alsa resamplers is not the
> quality of the algorithm. If it was just that, we would have fixed it
> ages ago.
> The real problem is related how the "period" model that ALSA currently
> uses functions.
> We need to implement new timers at the application rate, instead of
> trying to use the hardware rate. This would then require some extra
> buffer management. Currently, none of the ALSA developers have had
> enough time to implement the changes required.

So in the nearly 10 years of ALSA existing, the problem has been known
but nobody managed fix it (I realise it's hard)?

> Here is a small example of what the problem really is:
> Hardware does 48000. We have the hardware period set at 1024, with 2
> periods per buffer.
> The software application wishes to do 44100. So, the software
> application tries to set a period of 1024, with 2 periods per buffer.
> But, due to the restrictions of the current periods model, one can only
> do 44100/48000 * 1024 = 940.8
> Now, we cannot use fractions of a period, so we return 940 as the max
> period size to the application. This results of a real application rate
> 44062.5.
> What we really need is for the application to get it's 44100, 1024
> period size and 2 periods, and alsa-lib to provide the required
> abstraction to deliver 48000, 1024 period size and 2 periods to the
> hardware.
> 
> So, as you can see, it is not an easy quick fix.

So until ALSA is fixed to do things properly, would it be possible to at
least pass the information so that the resampler can actually use a
ratio of 44062.5/48000 instead of attempting to do 44100/48000
and then dropping samples? Considering most soundcards have shitty
clocks anyway, the problem may not be too bad (unless using really small
period sizes of course).

	Jean-Marc

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
