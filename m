From: William <walsac3@orthoset.com>
Subject: Re: [PATCH] emu10k1 multichannel support
Date: Wed, 19 Jan 2005 14:38:12 GMT
Message-ID: <200501191438.OAA11750@orthoset.com>
References: <1106091073.24484.60.camel@krustophenia.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1106091073.24484.60.camel@krustophenia.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:
>
> As promised, here's an updated patch to add real multichannel playback
> support (and improved multichannel capture) to the emu10k1 driver.
> 
> http://www.alsa-project.org/~rlrevell/emu10k1-multichannel-v001.patch
> 
> Please test it and report any problems.

I tested it on 2.6.10 with alsa 1.0.8 and have found what looks like
a possible problem with the emu10k1 synth support.
Soundfonts still load ok but despite mixer levels being ok
("Music=Master=...etc...=100%") there is no sound at all when using the
emu10k1 wavetable synth, e.g. with aplaymidi.

> I am especially interested in any regressions that impact regular
> PCM playback (the hw:0,0 device).

PCM playback and recording both seem to work ok.

> QuickStart:
> 
> $ jackd -R -v -d alsa -P hw:0,3 -C hw:0,2 -S
> 
> This also adds some new register info including a per channel half loop
> interrupt that I have discovered by reverse engineering the Windows drivers.
> Improvements over previous versions:

Excellent work!  Very well done.

William


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
