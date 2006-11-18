From: Daniel Yek <dyek@real.com>
Subject: Re: Long-standing 5.1ch huge LFE/rear swap annoyance
 (ALSA vs. Windows!)
Date: Fri, 17 Nov 2006 20:43:31 -0800
Message-ID: <6.2.1.2.2.20061117194844.7a535700@mailone.real.com>
References: <20061118013834.GA22785@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20061118013834.GA22785@rhlx01.hs-esslingen.de>
References: <20061118013834.GA22785@rhlx01.hs-esslingen.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Comment at the bottom...

At 05:38 PM 11/17/2006, Andreas Mohr wrote:
>Hi,
>
>as I'm trying to improve support for my el-cheapo USB audio adapter,
>I found that one of the bigger issues is swapping of Center/LFE vs.
>rear speakers, as can be seen when running
>
>speaker-test -c 6 -D pcm.USBAudio
>
>Having ALSA use different output assignment versus the printed labels
>on the box is somewhat of a PITA, I'd say.
>
>This doesn't only happen with my card, but with many many many many many
>(yes, I did quite some research) other cards:
>
>http://cvs.icculus.org/cvs/twilight/darkplaces/snd_main.c?rev=1.53
>"// Our speaker layouts are based on ALSA. They differ from those
>// Win32 and Mac OS X APIs use when there's more than 4 channels.
>// (rear left + rear right, and front center + LFE are swapped).
>"
>(probably the most insightful comment on the entire web)
>
>http://alsa.opensrc.org/SurroundSound
>"Some of the six channel wave files that you can find on the web are in "wave
>extensible" format, which have the interleaved channels in an order differing
>from what Alsa expects (center and lfe come before left and right rear). 
>It's a
>MS thing. You can play those with sfplay, a simple command line player I
>adapted from an example program in Erik de Castro Lopo's libsndfile
>distribution. sfplay recognizes wave extensible files and flips the channel
>order so they can be played using Alsa."
>(second most insightful)
>
>http://lists.mplayerhq.hu/pipermail/mplayer-dev-eng/2003-June/019180.html
>http://blog.gmane.org/gmane.linux.alsa.devel/month=20051101
>http://www.mythtvtalk.com/forum/viewtopic.php?t=1858&view=previous
>http://www.nvnews.net/vbulletin/showthread.php?t=62108
>http://www.cse.ohio-state.edu/~bondhugu/alsamch.shtml
>http://ubuntuforums.org/showthread.php?t=253725&page=5
>etc.pp. ad nauseam.
>
>(search bug tracking for "swap" for two tons more reports of swapped channels)
>
>One could even be brave enough to ask "are there *any* 5.1 cards which
>work correctly on ALSA??" ;), as such we should think hard about adding
>generic support to compensate for this, *automatically*.
>
>[yes, I know about asoundrc hackery to semi-easily get this tweaked]
>
>My theory is that since wave extensible is an established format with 
>different
>channel ordering that some soundcards chose to use this swapped ordering
>in hardware.
>And ALSA didn't care much since it didn't want to have to expensively 
>remix samples
>into correct order?
>
>But OTOH *if* the comment above is correct and ALSA *does* employ a 
>modified channel
>order vs. Windows and Mac OS X, then it seems as if it might be 
>speaker-test which
>*doesn't* obey this ALSA ordering??? But that could probably be checked by 
>playing
>some public surround .wav samples or DVD playback or so.
>
>Could we please try to put an end to this insanity?
>
>Is there anyone who has extensive experience with 5.1 surround channel 
>ordering status
>of many different soundcards on ALSA? How many "ok", how many swapped?
>
>Oh, and if the answer is that I should try to fix this on a per-driver 
>(per-card)
>basis, then could anyone tell me where the heck I'd have to tweak 
>snd-usb-audio
>for correct channel order?
>
>Rather confused,
>
>Andreas Mohr (a non-Surround user who still cares as much as even writing 
>this whole mail)

I have just dealt with this channel-swapping issue last month:
http://sourceforge.net/mailarchive/message.php?msg_id=37102586


Microsoft's Channel Ordering API is explained in this URL:
http://www.microsoft.com/whdc/device/audio/multichaud.mspx

Default Channel Ordering and dwChannelMask are what matter most.


As it is now, there appeared to have 5.1 channels media files in 
Microsoft's channel ordering and there are others in ALSA's ordering.

There needs a systematic and comprehensive way to detect which of the two 
ordering the clip is using. Suggestion would be great.




-- 
Daniel Yek


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
