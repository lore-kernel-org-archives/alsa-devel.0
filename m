From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Quality resampling code for libasound
Date: Tue, 20 Feb 2007 22:07:59 +0000
Message-ID: <45DB713F.9090804@superbug.co.uk>
References: <45D92131.50601@usherbrooke.ca>	<s5hirdy72ue.wl%tiwai@suse.de>	<45D99DF7.90204@usherbrooke.ca>	<s5hhcti70pa.wl%tiwai@suse.de>	<45D9A848.9040803@usherbrooke.ca>	<s5h7iue6yyi.wl%tiwai@suse.de>	<45DA8CD2.1040606@usherbrooke.ca>	<s5hps85rtsr.wl%tiwai@suse.de>	<45DAE188.6010405@usherbrooke.ca>	<s5hfy91rprn.wl%tiwai@suse.de>
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

Jean-Marc Valin wrote:
>>>> That's one part making alsa-lib rate plugin so complicated.
>>>> Anyways, the resampling algorithm plugin doesn't take care much about
>>>> it, so far.
>>> Are you telling me people use the high-quality sinc in libsamplerate
>>> just to have the plugin drop samples once in a while? Can we just have a
>>> resampler that actually produces valid output once and for all? I guess
>>> it's another good reason to go directly with a non-plugin resampler.
>> No, I mean that there are many black magics in the alsa rate plugin to
>> calculate the sampling buffer size constant so that the resampler side
>> doesn't take care of it so much.  And this has nothing to do with the
>> fact whether it's an external plugin or not.
> 
> OK, so plugin or not, how do you actually make sure you process all
> samples and not just the ones that are the most convenient? I can't
> believe I'm the only one here who actually cares about having correct
> audio coming in/out the soundcard.
> 
>> I understand that you would like to put that to alsa-lib.  But, it
>> would reduce neither code size and complication.  So let's prove the
>> quality and performance first as a plugin, then replace the default
>> one later.
> 
> Well, in terms of quality, Erik was kind enough to produce these graphs
> of a chirp being down-sampled from 96 kHz to 44.1 kHz:
> http://www.mega-nerd.com/tmp/speex_resampled_q10.png
> http://www.mega-nerd.com/tmp/speex_resampled_q5.png
> It should be pretty clear that the main limitation will be the 16-bit
> resolution (the aliasing lines are all below -120 dB). That, and of
> course the "discarding every N sample" problem, which is really bad.
> 
> As far as performance goes, the code is really fast in the general case
> (faster than libsamplerate according to the tests I made) and even 4x
> faster than that when doing simple conversions (integer ratio of simple
> fraction). BTW, have you tested the plugin I sent yet? In the worst
> case, the default can be set to the lower quality resampling modes,
> which are still way better than linear resampling and yet take nearly no
> CPU.
> 
>> The actual problem isn't that.  It's the restriction of "period" model
>> that the current ALSA PCM is based on.
> 
> And what's the solution to that one. What do you currently do with the
> linear resampler anyway? Drop samples again?
> 
> 	Jean-Marc
> 

Unfortunately, the real problem with the alsa resamplers is not the 
quality of the algorithm. If it was just that, we would have fixed it 
ages ago.
The real problem is related how the "period" model that ALSA currently 
uses functions.
We need to implement new timers at the application rate, instead of 
trying to use the hardware rate. This would then require some extra 
buffer management. Currently, none of the ALSA developers have had 
enough time to implement the changes required.

Here is a small example of what the problem really is:
Hardware does 48000. We have the hardware period set at 1024, with 2 
periods per buffer.
The software application wishes to do 44100. So, the software 
application tries to set a period of 1024, with 2 periods per buffer.
But, due to the restrictions of the current periods model, one can only 
do 44100/48000 * 1024 = 940.8
Now, we cannot use fractions of a period, so we return 940 as the max 
period size to the application. This results of a real application rate 
44062.5.
What we really need is for the application to get it's 44100, 1024 
period size and 2 periods, and alsa-lib to provide the required 
abstraction to deliver 48000, 1024 period size and 2 periods to the 
hardware.

So, as you can see, it is not an easy quick fix.

James



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
