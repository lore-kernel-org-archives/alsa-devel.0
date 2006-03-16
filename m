From: boku <boku0712@gmail.com>
Subject: Re: memory allocate for substream->runtime->dma_area
Date: Thu, 16 Mar 2006 20:51:47 +0800
Message-ID: <715d90900603160451g36db25ecl7703f277b99b40c3@mail.gmail.com>
References: <715d90900603141942y6c409027sb5a99be13f5ec462@mail.gmail.com>
	 <715d90900603141943h423c0ffdydedec3f1ed50a375@mail.gmail.com>
	 <s5hoe08hve4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_2679_11715294.1142513507521"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hoe08hve4.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

------=_Part_2679_11715294.1142513507521
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Is there any example case that uses fixed address space for the DMA region?
Thanks!~


On 3/15/06, Takashi Iwai <tiwai@suse.de> wrote:
>
> At Wed, 15 Mar 2006 11:43:51 +0800,
> boku wrote:
> >
> > Dear all,
> >     Could anyone tell me where the memory allocation of
> substream->runtime is? I got
> > to refine the runtime->dma_area within a specific DMA address. But I
> can't find where
> > the dma alloc is. Thanks a lot!
>
> The driver has to allocate the DMA buffer by itself.
>
> Most drivers use the helper functions, snd_pcm_lib_preallocate_*() at
> creation and snd_pcm_lib_malloc_pages() at hw_params callback, so that
> the PCM middle layer takes over the jobs.  But, in special cases, you
> need to allocate the buffer or assign the fixed addresses by
> yourself.
>
> Anyway, better to show your code and read the documentation once, as
> Lee suggested.
>
>
> Takashi
>

------=_Part_2679_11715294.1142513507521
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>Is there any example case that uses fixed address space for&nbsp;the D=
MA region? Thanks!~</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div><span class=3D"gmail_quote">On 3/15/06, <b class=3D"gmail_sendername">=
Takashi Iwai</b> &lt;<a href=3D"mailto:tiwai@suse.de">tiwai@suse.de</a>&gt;=
 wrote:</span>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">At Wed, 15 Mar 2006 11:43:51 +08=
00,<br>boku wrote:<br>&gt;<br>&gt; Dear all,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp=
; Could anyone tell me where the memory allocation of substream-&gt;runtime=
 is? I got
<br>&gt; to refine the runtime-&gt;dma_area within a specific DMA address. =
But I can't find where<br>&gt; the dma alloc is. Thanks a lot!<br><br>The d=
river has to allocate the DMA buffer by itself.<br><br>Most drivers use the=
 helper functions, snd_pcm_lib_preallocate_*() at
<br>creation and snd_pcm_lib_malloc_pages() at hw_params callback, so that<=
br>the PCM middle layer takes over the jobs.&nbsp;&nbsp;But, in special cas=
es, you<br>need to allocate the buffer or assign the fixed addresses by<br>=
yourself.
<br><br>Anyway, better to show your code and read the documentation once, a=
s<br>Lee suggested.<br><br><br>Takashi<br></blockquote></div><br>

------=_Part_2679_11715294.1142513507521--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
