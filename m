From: "Eliot Blennerhassett" <bigblen@icqmail.com>
Subject: Upgrade driver to 1.0.6, memory allocation?
Date: Wed, 18 Aug 2004 19:57:40 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <505401c48598$4a891ec0$72cb010a@mail2world.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_5055_01C4855D.9E2A46C0"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Class: urn:content-classes:message
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: linux@blennerhassett.gen.nz
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

------=_NextPart_000_5055_01C4855D.9E2A46C0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hello all,

with the upgrade to 1.0.6, my alsa driver broke. (asihpi)
Now I'm trying to put it together again, and could do with some tips...
Mostly it still contained lots of easy to fix snd_magic_cast() but
Can anybody confirm that the following update is the 'correct' thing to
do?

(My) old code:
call snd_malloc_pages_fallback in the open callback.

New code:
call snd_pcm_lib_malloc_pages() in the hw_params callback

and call snd_pcm_lib_preallocate_pages_for_all() in the sound card pcm
init function (in my case snd_card_asihpi_pcm()
================================
By default according to pcm_memory.c, only a maximum of 4 substreams are
allowed.
My cards have up to 16 substreams.

Chapter 10 of "Writing an alsa driver" says
"snd_pcm_lib_malloc_pages(substream, size);
Note that you have to pre-allocate to use this function. "

Does this only mean that you have to preallocate at least one buffer to
use the function?

If I read it correctly, snd_pcm_lib_malloc_pages will still try to
allocate some memory for substreams> 4, this just becomes less likely as
the system mem becomes fragmented.

Is there a rationale for making the substreams limit 4 as opposed to any
other number?
I guess I can change the max_substreams by providing a module parameter
to snd-pcm module.
============================
snd_pcm_lib_preallocate_pages1()
...
if (size> 0 && preallocate_dma && substream->number <maximum_substreams)
preallocate_pcm_pages(substream, size);
...
Maybe I'm missing something, but it seems the possible error return
value from preallocate_pcm_pages is ignored - is this intentional?
===========================
TIA for any enligtenment about the above.

-- Eliot



<P><font face="Arial, Helvetica, sans-serif" size="2" style="font-size:13.5px">_______________________________________________________________<BR><font face="Arial, Helvetica, sans-serif" size="2" style="font-size:13.5px">ICQ - You get the message, anywhere!<br>Get it @ <a href="http://www.icq.com" target=new>http://www.icq.com</a></font><br><br>&nbsp;</font></font>
------=_NextPart_000_5055_01C4855D.9E2A46C0
Content-Type: text/html
Content-Transfer-Encoding: 7bit

<HTML>
<BODY>
Hello all,<br>
<br>
with the upgrade to 1.0.6, my alsa driver broke. (asihpi)<br>
Now I'm trying to put it together again, and could do with some tips...<br>
Mostly it still contained lots of easy to fix snd_magic_cast() but<br>
Can anybody confirm that the following update is the 'correct' thing to do?<br>
<br>
(My) old code:<br>
call snd_malloc_pages_fallback in the open callback.<br>
<br>
New code:<br>
call snd_pcm_lib_malloc_pages() in the hw_params callback<br>
<br>
and call snd_pcm_lib_preallocate_pages_for_all() in the sound card pcm init function (in my case  snd_card_asihpi_pcm()<br>
================================<br>
By default according to pcm_memory.c, only a maximum of 4 substreams are allowed.<br>
My cards have up to 16 substreams.<br>
<br>
Chapter 10 of "Writing an alsa driver" says "snd_pcm_lib_malloc_pages(substream, size);<br>
Note that you have to pre-allocate to use this function. "<br>
<br>
Does this only mean that you have to preallocate at least one buffer to use the function?<br>
<br>
If I read it correctly, snd_pcm_lib_malloc_pages will still try to allocate some memory for substreams&gt; 4, this just becomes less likely as the system mem becomes fragmented.<br>
<br>
Is there a rationale for making the substreams limit 4 as opposed to any other number?<br>
I guess I can change the max_substreams by providing a module parameter to snd-pcm module.<br>
============================<br>
snd_pcm_lib_preallocate_pages1()<br>
...<br>
if (size&gt; 0 && preallocate_dma && substream->number &lt;maximum_substreams)<br>
		preallocate_pcm_pages(substream, size);<br>
...<br>
Maybe I'm missing something, but it seems the possible error return value from preallocate_pcm_pages is ignored - is this intentional?<br>
===========================<br>
TIA for any enligtenment about the above.<br>
<br>
-- Eliot<br>

</BODY></HTML>


<P><font face="Arial, Helvetica, sans-serif" size="2" style="font-size:13.5px">_______________________________________________________________<BR><font face="Arial, Helvetica, sans-serif" size="2" style="font-size:13.5px">ICQ - You get the message, anywhere!<br>Get it @ <a href="http://www.icq.com" target=new>http://www.icq.com</a></font><br><br>&nbsp;</font></font>
------=_NextPart_000_5055_01C4855D.9E2A46C0--



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
