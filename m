From: "Mark Knecht" <mknecht@controlnet.com>
Subject: RE: VT8233/A/8235 Clock Problem
Date: Mon, 8 Dec 2003 13:17:38 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NDBBLGIKBJENLAMOLFHGMEAIEDAB.mknecht@controlnet.com>
References: <20031208210455.GF1802@sirius.home>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20031208210455.GF1802@sirius.home>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Sergey Vlasov <vsu@altlinux.ru>, Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

> Most likely you need the dxs_support option instead of ac97_clock.
>
> With dxs_support=2 the sound should work fine, but the hardware mixing
> capability will be disabled.  Then you can try dxs_support=1 or
> dxs_support=4.
>
> By default snd-via82xx uses dxs_support=3 (except for certain known
> motherboards), this makes only 48000 sampling rate available.  The
> ALSA library can perform resampling for ALSA apps, and the kernel OSS
> emulation layer can do resampling for OSS apps, but the quality is
> often not good.
>

Sergey,
   This sounds encouraging. For those of us not in the know, can you tell me
anything about *what* dxs support is? Just point me at a web site with an
explanation if you have one. And what are dxs options 1, 2, 3 & 4 really
doing?

   Does this 2-channel motherboard sound chip actually do hardware mixing?
Or is that for other sound chips in this family?

   I'll try them all out later today.

Thanks,
Mark




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
