From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH] cs423x: update control names
Date: Sun, 15 Nov 2009 18:34:16 +0100
Message-ID: <20091115183416.27c6bdd4.krzysztof.h1@poczta.fm>
References: <20091115150513.fa11f65b.krzysztof.h1@poczta.fm>
	<s5h7htrkcb5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp240.poczta.interia.pl (smtp240.poczta.interia.pl
	[217.74.64.240]) by alsa0.perex.cz (Postfix) with ESMTP id D4BA3244C2
	for <alsa-devel@alsa-project.org>; Sun, 15 Nov 2009 18:33:11 +0100 (CET)
In-Reply-To: <s5h7htrkcb5.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, 15 Nov 2009 17:00:46 +0100
Takashi Iwai <tiwai@suse.de> wrote:

> At Sun, 15 Nov 2009 15:05:13 +0100,
> Krzysztof Helt wrote:
> > 
> > From: Krzysztof Helt <krzysztof.h1@wp.pl>
> > 
> > Update control names to be more closer to their meaning.
> > Change the "Mono" name to the "Beep" as this line is usually
> > used to forward the PC beeper signal to sound card's output.
> > Update names for both cs423x and wss.
> > 
> > Clean up cs4235 controls according to the cs4235 doc.
> 
> Does this include the renaming of Aux controls you made?
> Or, is it another issue?
> 

Yes. The names "AuxN" are used for the cs4235 but not for the cs4236. 
The cs4236 have been using recommended line sources names (CD and Line in)
instead. I changed these names to be the same for the cs4235.

> > Also, delete one misnamed cs4231 register define.
> > 
> > Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> > ---
> 
> > It matters for the OSS layer, which does map the "Master Playback Volume"
> > as a "Volume" control, but the "Master DAC Volume" is recognized by the OSS layer.
> 
> Adding more volume names to map OSS is no problem unless it conflicts
> with other drivers.  IMO, "Master DAC" doesn't look intuitive than
> "Master Digital".
> 

I can revert that. The "Master DAC" is drawn in the docs as a mixer after 
the DAC (on the DAC analog output). For me the DAC is more intutitive
but I can revert that.

> BTW, what would "Bypass" switch do exactly?  This is also an
> unintuitive mixer element...
> 

The beep bypass switch connects directly the beep input (aka mono input) 
with the mono output (if it is used at all). The beep signal is not affected
by the "beep playback switch" and "beep playback volume" controls then
(it bypass the analog mixer). It is a routing switch.

Regards,
Krzysztof

-----------------------------------------------------------------------
Yoskine i Anna Maria Jopek zapraszaja do konkursu
Wygraj 3 luksusowe weekendy w SPA lub 10 zestawow kosmetykow od Yoskine
Sprawdz >> http://link.interia.pl/f2438
