From: Friedrich Ewaldt <friedrich.ewaldt@gmx.de>
Subject: Re: [PATCH] cs46xx: Center-LFE channel support + a lot
 of hacking
Date: Wed, 02 Apr 2003 22:30:47 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E8B4877.4030306@gmx.de>
References: <3E873CA2.2010607@cucumelo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3E873CA2.2010607@cucumelo.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Benny Sjostrand <gorm@cucumelo.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Benny,

I just tested your patches with my terratec DMX XFire 1024. Rear channel 
doesn't seem to work as intended:
I always get the same output out of both output jacks when I play back 
on hw:0,0 (should be on the first/front output only, I assume).
I can't hear anything from the analog outputs when playing back on 
hw:0,1 (this should be the second output, correct?).
I.e. the behaviour of the analog outputs of the XFire seems to not have 
changed.

SPDIF input no works basically again (it worked up to rc6, afterwards, 
no non-distorted digital recording was possible with the XFire -- up to 
your newest great patches :) ). That's a really great improvement! Many 
thanks for this.
I noticed that I can't change SPDIF input volume any more. Is this 
intended? For me that's o.k. For recordings it's even better to have no 
additional scaling.
SPDIF sounds good, as far I can hear with not-too-expensive headphones 
near my not-too-silent computer. But as I've looked at a spectrogram 
(short time spectra of short time windows), I noticed there are some 
errors (spikes) approx. every 0.24 second. You can see these as thin 
vertical lines that shouldn't be there in the plot I've attached. The 
errors are not very severe: Most of them you can't seen in the time 
signal, even if you know where they are an zoom into the signal ;)
I don't get these spikes when recording from analog sources or when 
recording from SPDIF under win98. Not really true: sometimes I get them 
also under win98, if I introduce many biterrors by 
disonnecting/connecting the digital input cable several times. 
Theoretically the SPDIF input should resync to the audio stream 
afterwards, but sometimes it doesn't, even with the 'original' win 
driver. Under win98, I can solve this problem by switching SPDIF input 
off/on in the driver panel.

so far my first results with the new patches. The SPDIF input results 
are very encouraging that this card will get more and more useful under 
linux thanks to your work...
  fe

Benny Sjostrand wrote:

> Hi!
>
> I've been working of lot things, hopefully all theese changes can 
> integrated painless.
>
> Pathes are available for download at:
> http://www.cucumelo.org/~gorm/cs46xx.patch  (for 
> alsa-kernel/pci/cs46xx/* changes)
> http://www.cucumelo.org/~gorm/cs46xx_include.patch (for 
> alsa-kernel/include/* changes)
>
> The main new feuture is a new PCM channel:
> - Cards with a dual CODEC configuration (2 x cs4294 || 1 x cs4297A + 1 
> x cs4294),
> like (Hercules GTXP, Santa Cruz, Terratec SixPack 5.1):
>    PCM 0 - slot 3 and 4 (Primary CODEC) main channel
>    PCM 1 - slot 7 and 8 (Seconadry CODEC) rear channel
>    PCM 2 - IEC958, SPDIF output from the DSP
>    PCM 3 - slot 6 and 9 (Seconadry CODEC) left channel is Center and 
> right is LFE
>
>    Theoretically it should also possible to support yet another analog 
> output on
>     slot 11 and 5 on primary CODEC, to support surround 7.1, (Hercules 
> GTXP
>     has done something here, but dont exaclty how stuff are wired ...)
> - Cards with a single CODEC configuration (1 x cs4294), like Terratec 
> XFire 1024:
>    (This configuration is untested)
>    PCM 0 - slot 3 and 4 (Primary CODEC) main channel
>    PCM 1 - slot 11 and 5 (Primary CODEC) rear channel
>    PCM 2 - IEC958, SPDIF output from the DSP
>
>
> - Some changes to the IEC958 input, should be functional by now, but 
> still far from
> being perfect.
>
> - There is another theoretical problem which will prevent the cs46xx 
> work on Big Endian
> architectures. I've started to work on this issue, but not finished yet.
> What's left on this point is to initialize all DSP structs with the 
> C99 style (.member = value, ...)
> a lot of painful work (anyone like to help me ? -;) )
>
> Known problems (for the moment):
> - The Terratec SixPack 5.1 card wont initialize correctly on a 
> cold/warm boot.
>   A reload of the ALSA driver fixes the problem.
> - The IEC958 input port sometimes just stop working, the only thing 
> that seems
>   to fix it is a cold boot. (a warm reboot does not seems to be enough)
> - The analog output's on the SiXPack 5.1 are very distorcionated when 
> PCM volumes
> is over ~ 65 %. The only amplified output on this cards seems to be 
> the Headphone output.
>
> That's all for now ...
>
> /Benny
>
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by:
> The Definitive IT and Networking Event. Be There!
> NetWorld+Interop Las Vegas 2003 -- Register today!
> http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>
>




-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
