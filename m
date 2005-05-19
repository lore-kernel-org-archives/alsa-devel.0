From: "Derek Jones" <DJones@Interalia.ca>
Subject: ALSA PCM DMA questions
Date: Thu, 19 May 2005 15:53:29 -0600
Message-ID: <083AB380E3924D4795740AAE9A27DCABDB962B@cgy2000.interalia.ca>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C55CBD.31018B2A"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
content-class: urn:content-classes:message
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C55CBD.31018B2A
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

I am busy developing an ALSA AC97 driver for an ARM9 based SoC. I am =
pulling my hair out trying to figure out how the DMA buffers are =
supposed to work in the PCM driver.

To start with, I am only trying to get playback working.

I start the DMA after I get a SNDRV_PCM TRIGGER_START in my trigger =
routine. The DMA transfer starts from runtime->dma_addr and transfers =
period_size bytes (snd_pcm_lib_period_bytes(substream)).

After the DMA transfer completes, I call =
snd_pcm_period_elaped(substream). I'm guessing that this moves a buffer =
pointer. What I cannot figure out is how to determine where I am in the =
buffer so that I can start the next DMA from the correct position.

When the entire buffer has been DMA'ed, is the buffer overwritten with =
new PCM data from userland, or does the DMA buffer work like a circular =
buffer with userland data being transferred into the buffer at each PCM =
period.

Any help or pointers would be greatly appreciated.

Regards,

Derek Jones

------_=_NextPart_001_01C55CBD.31018B2A
Content-Type: text/html;
	charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3DWindows-1252">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.0.6249.1">
<TITLE>ALSA PCM DMA questions</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Hi,<BR>
<BR>
I am busy developing an ALSA AC97 driver for an ARM9 based SoC. I am =
pulling my hair out trying to figure out how the DMA buffers are =
supposed to work in the PCM driver.<BR>
<BR>
To start with, I am only trying to get playback working.<BR>
<BR>
I start the DMA after I get a SNDRV_PCM TRIGGER_START in my trigger =
routine. The DMA transfer starts from runtime-&gt;dma_addr and transfers =
period_size bytes (snd_pcm_lib_period_bytes(substream)).<BR>
<BR>
After the DMA transfer completes, I call =
snd_pcm_period_elaped(substream). I'm guessing that this moves a buffer =
pointer. What I cannot figure out is how to determine where I am in the =
buffer so that I can start the next DMA from the correct position.<BR>
<BR>
When the entire buffer has been DMA'ed, is the buffer overwritten with =
new PCM data from userland, or does the DMA buffer work like a circular =
buffer with userland data being transferred into the buffer at each PCM =
period.<BR>
<BR>
Any help or pointers would be greatly appreciated.<BR>
<BR>
Regards,<BR>
<BR>
Derek Jones</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C55CBD.31018B2A--


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
