From: Dan Sharon <dansharon-ScDXFp4xN3PN+rMO2ozGnw@public.gmane.org>
Subject: Re: ALSA issue on DA850/OMAP-L138/AM18x
Date: Thu, 20 Jan 2011 10:33:23 -0500
Message-ID: <AANLkTin-xRaiwsj05h7aL3r=3nbAMDFPkjPo0gzGCbwf@mail.gmail.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59302484734E0@dbde02.ent.ti.com>
	<AANLkTi=X3KRngiNz5iQzojh_-h4W-iRDsbq8Hvy6Lm1x@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024850919E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0985645527=="
Return-path: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024850919E-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: "Rajashekhara, Sudhakar" <sudhakar.raj-l0cyMroinI0@public.gmane.org>
Cc: "khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org" <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

--===============0985645527==
Content-Type: multipart/alternative; boundary=000e0cd76264a1e7b3049a48da7a

--000e0cd76264a1e7b3049a48da7a
Content-Type: text/plain; charset=ISO-8859-1

Hi Sudhakar,

you're quite right - if 'arecord -f dat | aplay -f dat' is executed
immediately after boot, indeed I do get the same errors as you.

Thank you very much for the patches.
Regards,
/Dan

On Thu, Jan 20, 2011 at 12:05 AM, Rajashekhara, Sudhakar <
sudhakar.raj-l0cyMroinI0@public.gmane.org> wrote:

> Hi Dan,
>
> Thanks for testing this patch. I'll add your Tested-by tag when I submit
> this patch.
>
> On Wed, Jan 19, 2011 at 00:32:21, Dan Sharon wrote:
> > These patches apply cleanly to 'v2.6.37'
> > 3c0eee3fe6a3a1c745379547c7e7c904aa64f6d5
> >
> > of
> > git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-davinci.git.
> >
> > The kernel was built with the 'da8xx_omapl_defconfig' from the
> omap-l1tree,
> > and 'make menuconfig' to enable ASoC (the defconfig already has
> CONFIG_REGULATOR=y,
> > CONFIG_REGULATOR_DUMMY=y, and CONFIG_REGULATOR_TPS6507X=y).
> >
> > Testing was done on a da850evm by tftp'ing the kernel into ram, and using
> the
> > SPI-flash-based rootfs from the PSP that shipped with the board.
> >
> > Using 'arecord -r 48000 -c 2 -f S32_BE -t raw -v -d 1 > /tmp/arecord.cap'
> produced
> > a file of 384000 bytes (48000 x 2 x 4 bytes/sample).
> > 'arecord -r 48000 -c 2 -f S32_BE -t raw -v > /dev/null' ran flawlessly
> for several
> > hours.
> >
> > I was not able to reproduce Sudhakar's problems with 'arecord -f dat |
> aplay -f dat'.
> >
>
> Did you try the above, immediately after the da850evm boots? I am not
> facing the issue if I run arecod and aplay together after executing
> arecord or aplay individually.
>
> Thanks,
> Sudhakar
>

--000e0cd76264a1e7b3049a48da7a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Sudhakar,<br><br>you&#39;re quite right - if &#39;arecord -f dat | aplay=
 -f dat&#39; is executed immediately after boot, indeed I do get the same e=
rrors as you.<br><br>Thank you very much for the patches.<br>Regards,<br>
/Dan<br><br><div class=3D"gmail_quote">On Thu, Jan 20, 2011 at 12:05 AM, Ra=
jashekhara, Sudhakar <span dir=3D"ltr">&lt;<a href=3D"mailto:sudhakar.raj@t=
i.com">sudhakar.raj-l0cyMroinI0@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class=3D"gm=
ail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(2=
04, 204, 204); padding-left: 1ex;">
Hi Dan,<br>
<br>
Thanks for testing this patch. I&#39;ll add your Tested-by tag when I submi=
t this patch.<br>
<div class=3D"im"><br>
On Wed, Jan 19, 2011 at 00:32:21, Dan Sharon wrote:<br>
&gt; These patches apply cleanly to &#39;v2.6.37&#39;<br>
&gt; 3c0eee3fe6a3a1c745379547c7e7c904aa64f6d5<br>
&gt;<br>
&gt; of<br>
&gt; git://<a href=3D"http://git.kernel.org/pub/scm/linux/kernel/git/khilma=
n/linux-davinci.git" target=3D"_blank">git.kernel.org/pub/scm/linux/kernel/=
git/khilman/linux-davinci.git</a>.<br>
&gt;<br>
&gt; The kernel was built with the &#39;da8xx_omapl_defconfig&#39; from the=
 omap-l1tree,<br>
&gt; and &#39;make menuconfig&#39; to enable ASoC (the defconfig already ha=
s CONFIG_REGULATOR=3Dy,<br>
&gt; CONFIG_REGULATOR_DUMMY=3Dy, and CONFIG_REGULATOR_TPS6507X=3Dy).<br>
&gt;<br>
&gt; Testing was done on a da850evm by tftp&#39;ing the kernel into ram, an=
d using the<br>
&gt; SPI-flash-based rootfs from the PSP that shipped with the board.<br>
&gt;<br>
&gt; Using &#39;arecord -r 48000 -c 2 -f S32_BE -t raw -v -d 1 &gt; /tmp/ar=
ecord.cap&#39; produced<br>
&gt; a file of 384000 bytes (48000 x 2 x 4 bytes/sample).<br>
&gt; &#39;arecord -r 48000 -c 2 -f S32_BE -t raw -v &gt; /dev/null&#39; ran=
 flawlessly for several<br>
&gt; hours.<br>
&gt;<br>
&gt; I was not able to reproduce Sudhakar&#39;s problems with &#39;arecord =
-f dat | aplay -f dat&#39;.<br>
&gt;<br>
<br>
</div>Did you try the above, immediately after the da850evm boots? I am not=
<br>
facing the issue if I run arecod and aplay together after executing<br>
arecord or aplay individually.<br>
<br>
Thanks,<br>
<font color=3D"#888888">Sudhakar<br>
</font></blockquote></div><br>

--000e0cd76264a1e7b3049a48da7a--

--===============0985645527==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0985645527==--
