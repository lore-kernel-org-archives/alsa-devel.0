From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: hda_intel ATI SB450 - unknown subsystem
	ID	1025:009f
Date: Sun, 24 Sep 2006 08:48:10 -0700
Message-ID: <1159112890.7201.191.camel@razman>
References: <ab3226c20609240702q16d4a4f1x2c88fd9faf983b75@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <ab3226c20609240702q16d4a4f1x2c88fd9faf983b75@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: =?iso-8859-2?Q?Stanis=B3aw_Raczy=F1ski?= <sutashu@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, 2006-09-24 at 16:02 +0200, Stanis=B3aw Raczy=F1ski wrote:
> Hello,
> =

> It seems to me that the Intel HDA-based audio card on my new Turion64
> X2 laptop (Acer Aspire 5102WLMi) is not yet properly
> supported. I can't make the alsamixer to start (I tried many different
> model settings infor the snd-hda-intel module): =

> =

> alsamixer: function snd_mixer_load failed: Invalid argument
> =

> I was searching through alsa-kernel/pci/hda/patch_realtek.c and
> alsa-kernel/Documentation/ALSA-Configuration.txt files and could not
> find my model there, but the second file instructed me to post here.
> Here's the lspci -nv snippet: =

> =

> 00:14.2 0403: 1002:437b (rev 01)
>   Subsystem: 1025:009f
>   Flags: bus master, slow devsel, latency 64, IRQ 18
>   Memory at c0000000 (64-bit, non-prefetchable) [size=3D16K]
>   Capabilities: [50] Power Management version 2 =

>   Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=3D0/0
> Enable-
> =

> Best wishes,
> Stanislaw Raczynski

Try adding "model=3Dacer" to your modprobe.conf file.  Also, which version
of alsa are you trying?

Could you post the output from "cat /proc/asound/card0/codec*"?  This
will help identify the exact codec that you have.
-- =

Tobin Davis <tdavis@dsl-only.net>


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
