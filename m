From: Winfried Ritsch <ritsch@iem.at>
Subject: Re: Scatter-Gather buffer allocation before running on HDSP-MADI ?
Date: Tue, 7 Oct 2003 18:25:50 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <16258.59662.729091.684464@seneca.iemnet>
References: <16254.61960.840856.972245@seneca.iemnet>
	<Pine.LNX.4.53.0310052055350.13267@pnote.perex-int.cz>
	<s5had8eo4p1.wl@alsa2.suse.de>
	<1065460748.3f81a40c61063@iem.at>
	<s5hvfr2mflt.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hvfr2mflt.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


Thanx that cleared a lot.

So I managed now to put it in hw_params and it works in some way.
needed an additional 

There is one point I found:

 - when I preallocate with for playback and capture 
   2*4194304 = 8388608 Bytes:

snd_pcm_lib_preallocate_sg_pages_for_all(hdspm->pci, pcm,8388608,8388608))

and then in hw_params for one substream do a:

 snd_pcm_lib_malloc_pages(substream, 4194304);
   
I got a sgbuf with size=8388608 not 4194304. So it takes all the
memory at first.

Then I tried to preallcate 4194304 and it nearly works (see below).

... since in it prealloctes the mem for 2 substreams (seen in pcm_memory.c).

at least I have to allocate one page more = 4194304+4096, to get no
Segmentation fault, but that could be the hardware too, since hdsp
also needs one page more ?

What should be the right way ? 

 a) Allocating the sum of both ?

 b) Acllocate with the value of one substream ?

 c) should I call snd_pcm_lib_preallocate_sg_pages_for_all twice ?
    (also free pages twice)

mfg winfried


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
