From: "Tehn-Yit Chin" <Tehn-Yit.Chin@greyinnovation.com>
Subject: RE: alsa dma transfer
Date: Wed, 29 Jun 2005 22:53:56 +1000
Message-ID: <9AEDBAA573BBD346BCF9637D80097D9109FF28@greysvr02.GreyInnovation.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C57CA9.9CA5E644"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-class: urn:content-classes:message
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

This is a multi-part message in MIME format.

------_=_NextPart_001_01C57CA9.9CA5E644
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Cool. I believe that I am doing the right thing.

I am calling snd_pcm_lib_malloc_pages() for the hw_params callback and =
snd_pcm_lib_free_pages() for the hw_free callback. I also call =
snd_pcm_lib_preallocate_pages_for_all() during the initialisation of the =
driver which I think is the buffer pre-allocation that Takashi Iwai is =
talking about.=20

Does the pre-allocated memory need to be freed when we are exiting the =
driver?

Tehn Yit Chin

-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de]
Sent: Wed 6/29/2005 7:26 PM
To: Tehn-Yit Chin
Cc: alsa-devel@lists.sourceforge.net
Subject: Re: [Alsa-devel] alsa dma transfer
=20
At Wed, 29 Jun 2005 16:35:21 +1000,
Tehn-Yit Chin wrote:
>=20
> From what I can tell, runtime->dma_start is a virtual memory buffer =
that
> has the audio data, and the amount of data to transfer is in
> frames_to_bytes(runtime, runtime->period_size). Is this right?

runtime->dma_area is the virtual address and runtime->dma_addr is the
physical (more exactly bus) address.  They are set up either via
snd_pcm_lib_malloc_pages() or manually by yourself in hwparams
callback.  In the former case, you'll need the buffer pre-allocation
beforehand at the creation of PCM instance.

> And how do I tell pcm layer that the device does not support =
recording?

Pass 0 to capture_count of snd_pcm_new().


Takashi


------_=_NextPart_001_01C57CA9.9CA5E644
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7232.36">
<TITLE>RE: [Alsa-devel] alsa dma transfer</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Cool. I believe that I am doing the right thing.<BR>
<BR>
I am calling snd_pcm_lib_malloc_pages() for the hw_params callback and =
snd_pcm_lib_free_pages() for the hw_free callback. I also call =
snd_pcm_lib_preallocate_pages_for_all() during the initialisation of the =
driver which I think is the buffer pre-allocation that Takashi Iwai is =
talking about.<BR>
<BR>
Does the pre-allocated memory need to be freed when we are exiting the =
driver?<BR>
<BR>
Tehn Yit Chin<BR>
<BR>
-----Original Message-----<BR>
From: Takashi Iwai [<A =
HREF=3D"mailto:tiwai@suse.de">mailto:tiwai@suse.de</A>]<BR>
Sent: Wed 6/29/2005 7:26 PM<BR>
To: Tehn-Yit Chin<BR>
Cc: alsa-devel@lists.sourceforge.net<BR>
Subject: Re: [Alsa-devel] alsa dma transfer<BR>
<BR>
At Wed, 29 Jun 2005 16:35:21 +1000,<BR>
Tehn-Yit Chin wrote:<BR>
&gt;<BR>
&gt; From what I can tell, runtime-&gt;dma_start is a virtual memory =
buffer that<BR>
&gt; has the audio data, and the amount of data to transfer is in<BR>
&gt; frames_to_bytes(runtime, runtime-&gt;period_size). Is this =
right?<BR>
<BR>
runtime-&gt;dma_area is the virtual address and runtime-&gt;dma_addr is =
the<BR>
physical (more exactly bus) address.&nbsp; They are set up either =
via<BR>
snd_pcm_lib_malloc_pages() or manually by yourself in hwparams<BR>
callback.&nbsp; In the former case, you'll need the buffer =
pre-allocation<BR>
beforehand at the creation of PCM instance.<BR>
<BR>
&gt; And how do I tell pcm layer that the device does not support =
recording?<BR>
<BR>
Pass 0 to capture_count of snd_pcm_new().<BR>
<BR>
<BR>
Takashi<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C57CA9.9CA5E644--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
