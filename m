From: "Gupta, Kshitij" <kshitij@ti.com>
Subject: buffer producer/consumer sync
Date: Tue, 9 Mar 2004 15:21:46 +0530
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <F509E6111989D311B63700805FA761DA09F2906A@DBDE01>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C405BC.1DC67DDE"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C405BC.1DC67DDE
Content-Type: text/plain;
	charset="iso-8859-1"


> hi ,
> 	While debugging my alsa driver , some observations...
> 
> The flow goes like this
> 
> - cat  test.raw > /dev/pcm
> - Middle layer fills up the buffer (size = period_size).   Why does middle
> layer only fills up period_size ??????
> - ...(open / init etc)
> - Trigger with PLAY command is called
> 	a) audio_dma_process routine is called
> 		This routine starts a dma transfer for a size of period_size
> 	
> 	b) We get a end of transfer interrupt and our callback is called.
> In the callback function we call snd_pcm_period_elapsed to notify that one
> period is finished.  This function causes Trigger to be called again with
> STOP and then START again.  And the reason which I found after much
> debugging is this  :
> 		
> --------------------------------------------------------------------------
> ------------------------------------------------
> 	 if (avail >= runtime->stop_threshold) {
>                 snd_pcm_stop(substream,
>                              runtime->status->state ==
> SNDRV_PCM_STATE_DRAINING ?
>                              SNDRV_PCM_STATE_SETUP :
> SNDRV_PCM_STATE_XRUN);
> 
> this code is a part of snd_pcm_update_hw_ptr_post function in
> sound/core/pcm_lib.c
> --------------------------------------------------------------------------
> ------------------------------------------------
> 
> avail value is coming equal to runtime->stop_threshold and that is why we
> are getting a stop.  A trace of these values is :
> 
> initially 
> 	hw_ptr = 0	appl_ptr = period_size		avail =
> runtime->buffersize    	stop_threshold = runtime->buffersize
> (this is set by default)
> 
> after one DMA transfer 
> 	hw_ptr = period_size	appl_ptr = period_size(still the same value
> ... middle layer should have filled in more data and updated this )
> 	
> 	avail = hw_ptr + runtime->buffersize  - appl_ptr
> 
> 	so again avail = runtime->buffersize  , since hw_ptr is equal to
> appl_ptr.  
> 
> What we analyzed here is that After the DMA transfer starts and before the
> finish of the DMA transfer the alsa middle layer should fill up data from
> application layer (cat command in this context).   So probably DMA
> transfer is happening at a much faster rate than the middle layer can fill
> up more application buffers. 
> 
> Can someone comment on this and guide a little bit to solve this problem.
> 
> warm regards
> -kshitij

------_=_NextPart_001_01C405BC.1DC67DDE
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
5.5.2657.73">
<TITLE> buffer producer/consumer sync</TITLE>
</HEAD>
<BODY>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Arial">hi ,</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Arial">While debugging my alsa driver , some =
observations...</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">The flow goes like this</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">- cat&nbsp; test.raw &gt; =
/dev/pcm</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">- Middle layer fills up the buffer =
(size =3D period_size).&nbsp;&nbsp; Why does middle layer only fills up =
period_size ??????</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">- ...(open / init etc)</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">- Trigger with PLAY command is =
called</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Arial">a) audio_dma_process routine is called</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Arial">This routine starts a dma transfer for a size of =
period_size</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Arial">b) We get a end of transfer interrupt and our callback =
is called.&nbsp; In the callback function we call =
snd_pcm_period_elapsed to notify that one period is finished.&nbsp; =
This function causes Trigger to be called again with STOP and then =
START again.&nbsp; And the reason which I found after much debugging is =
this&nbsp; :</FONT></P>

<P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
<BR><FONT SIZE=3D2 =
FACE=3D"Arial">---------------------------------------------------------=
-----------------------------------------------------------------</FONT>=
</P>

<P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<FONT SIZE=3D2 =
FACE=3D"Arial"> if (avail &gt;=3D runtime-&gt;stop_threshold) {</FONT>
<BR><FONT SIZE=3D2 =
FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; snd_pcm_stop(substream,</FONT>
<BR><FONT SIZE=3D2 =
FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; runtime-&gt;status-&gt;state =
=3D=3D SNDRV_PCM_STATE_DRAINING ?</FONT>
<BR><FONT SIZE=3D2 =
FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SNDRV_PCM_STATE_SETUP : =
SNDRV_PCM_STATE_XRUN);</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">this code is a part of =
snd_pcm_update_hw_ptr_post function in sound/core/pcm_lib.c</FONT>
<BR><FONT SIZE=3D2 =
FACE=3D"Arial">---------------------------------------------------------=
-----------------------------------------------------------------</FONT>=
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">avail value is coming equal to =
runtime-&gt;stop_threshold and that is why we are getting a stop.&nbsp; =
A trace of these values is :</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">initially </FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Arial">hw_ptr =3D 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; appl_ptr =3D =
period_size&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; avail =3D =
runtime-&gt;buffersize&nbsp;&nbsp;&nbsp;&nbsp; stop_threshold =3D =
runtime-&gt;buffersize&nbsp;&nbsp;&nbsp; (this is set by =
default)</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">after one DMA transfer </FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Arial">hw_ptr =3D period_size&nbsp;&nbsp;&nbsp; appl_ptr =3D =
period_size(still the same value ... middle layer should have filled in =
more data and updated this )</FONT></P>

<P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Arial">avail =3D hw_ptr + runtime-&gt;buffersize&nbsp; - =
appl_ptr</FONT>
</P>

<P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Arial">so again avail =3D runtime-&gt;buffersize&nbsp; , since =
hw_ptr is equal to appl_ptr.&nbsp; </FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">What we analyzed here is that After =
the DMA transfer starts and before the finish of the DMA transfer the =
alsa middle layer should fill up data from application layer (cat =
command in this context).&nbsp;&nbsp; So probably DMA transfer is =
happening at a much faster rate than the middle layer can fill up more =
application buffers. </FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Can someone comment on this and guide =
a little bit to solve this problem.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">warm regards</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">-kshitij</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C405BC.1DC67DDE--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
