From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH] cs46xx: convert to firmware loader
Date: Tue, 8 Jun 2010 21:31:44 +0200
Message-ID: <20100608213144.28598c16.krzysztof.h1@poczta.fm>
References: <20100529151210.70cb937c.krzysztof.h1@poczta.fm>
	<s5h8w705yk0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4227649418619958975=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpo.poczta.interia.pl (smtpo.poczta.interia.pl
	[217.74.65.206]) by alsa0.perex.cz (Postfix) with ESMTP id 50368244D9
	for <alsa-devel@alsa-project.org>;
	Tue,  8 Jun 2010 21:28:05 +0200 (CEST)
In-Reply-To: <s5h8w705yk0.wl%tiwai@suse.de>
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
Cc: Alsa-devel <alsa-devel@alsa-project.org>, alan@lxorguk.ukuu.org.uk
List-Id: alsa-devel@alsa-project.org

--===============4227649418619958975==
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 May 2010 09:18:39 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> At Sat, 29 May 2010 15:12:10 +0200,
> Krzysztof Helt wrote:
> > 
> > From: Krzysztof Helt <krzysztof.h1@wp.pl>
> > 
> > The cs46xx uses unlicensed binary blob in the cs46xx_image.h file.
> > Convert this file to binary firmware and use kernel firmare loader.
> > 
> > The DSP binary contains 3 parts which are loaded at offsets 0x0,
> > 0x10000 and 0x20000. I have converted this image into 3 binary
> > images cs46xx_0.fw, cs46xx_1.fw and cs46xx_2.fw.
> > 
> > This issue was reported as the Linux kernel bug #10750.
> > 
> > Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> > ---
> > 
> > I don't know who else should be informed about this patch.
> 
> I don't think moving the stuff to firmware directory fixes anything by
> itself.  Rather the firmware data has to be *removed* from the kernel
> source tree.  Or drop the old dsp Kconfig together.
> 
> 

According to the description of the #10750 bug by Alan Cox:

"Comment #2 From  Alan   2008-09-23 03:53:25  -------

The firmware and original driver code were submitted by Cirrus Logic directly
to the kernel so they clearly intended it to be redistibutable."

"Comment #4 From  Alan   2010-01-19 17:23:25  -------

Look up 'Estoppel'

Firmware needs moving into using the firmware loader however."

the firmware was submitted by the Cirrus Logic and cannot be taken back (relicensed
to more restrictive license after submission).
I assume it means that the firmaware can be distributed but in the binary only form.

However, if you prefer to drop the old firmware completely I can make such a patch.

Regards,
Krzysztof

----------------------------------------------------------------------
Auta kilka tysięcy złotych taniej? Przebieraj wśród tysięcy ogłoszeń!
Sprawdz >>> http://linkint.pl/f2724


--===============4227649418619958975==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============4227649418619958975==--
