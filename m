From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Audigy: recording level much too low (microphone)
Date: Fri, 10 Aug 2007 13:29:45 +0100
Message-ID: <46BC5A39.50201@superbug.co.uk>
References: <20070810110217.GA7011@sarge.my.own.domain.no-net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anchor-post-32.mail.demon.net (anchor-post-32.mail.demon.net
	[194.217.242.90])
	by alsa0.perex.cz (Postfix) with ESMTP id 04234103843
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Aug 2007 14:29:51 +0200 (CEST)
In-Reply-To: <20070810110217.GA7011@sarge.my.own.domain.no-net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Zbigniew Baniewski <zb@ispid.com.pl>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Zbigniew Baniewski wrote:
> Hallo,
>
> I've got a problem with Audigy (it's SB0230 release) soundcard: the
> recording level, when taking the sound from microphone, is much too low.
>
> I've sent a mail to "users" list, so here I'm just pointing to that mail:
> http://www.mail-archive.com/alsa-user@lists.sourceforge.net/msg20235.html
> ...and so I won't repeat it all here.
> (I made a mistake in the subject there, writing about "Audigy2")
>
> My card is seen by 1.0.14 ALSA as ( cat /proc/asound/cards ):
>
> 0 [Audigy   ]: Audigy - Audigy 1 [Unknown]
>                Audigy 1 [Unknown] (rev.3, serial:0x5a1102) at 0xc400, irq 11
>
>
> As I understand, there is some variable (or register?), which controls that
> recording level for microphone input - perhaps someone of the developers
> could tell me, which variable is it, and which file should I search? In such
> way perhaps I could fix it on my own - just by setting higher max. level, or
> in similar way. But searching all that files on my own could take serious
> amount of time, I'm afraid.
>
> Or perhaps there's another way to fix it (some special settings)?
>   

This requires a change to the DSP code in the driver.
Basically, the sound from the mic is a 32bit value, but the DSP only 
sends 16bits to the user, and currently the 16bits sent are the top 
16bits but most of the sound from the MIC is in the middle 16bits.
I need to modify the DSP code to add a new mixer control to provide 
amplification of the sound, so it will be possible to put the a better 
value in the 16bit value. E.g. multiply the value by 256, but have it 
variable so the user can adjust to get the levels right.
I think this approach will be better than attenuating the 24bit value so 
that it only occupies 16bits as this would merge values together.
I am not exactly sure which approach I should take as they all 
potentially loose captured information.

James
