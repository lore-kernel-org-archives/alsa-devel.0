From: barat@medien.uni-weimar.de
Subject: mmaped play in multichannel mode (fwd)
Date: Wed, 30 Jul 2003 22:37:14 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.53.0307302236410.14824@spring>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

hi,
i have written some code for mmaped-play. it works so far for up to 2 
channels, but in multichannel-mode i get some mismatch about available 
buffersize or exactly a snd_pcm_mmap_commit error.
the essential part is the following:

  snd_pcm_mmap_begin(alsa_handler, &area, &offset, &frames_transmit);

  /* this is specific to interleaved streams (or non-interleaved
   * streams with only one channel) */
  outbuffer = ((char *) area->addr + (area->first + area->step * offset) / 
8);

  //write data
  memcpy(outbuffer, data, (frames_transmit * bytes_per_sample));
 
  commitres = snd_pcm_mmap_commit(alsa_handler, offset, frames_transmit);

i guess that outbuffer has a wrong size. does somebody have any idea about 
this outbuffer calculation?


thanx and regards

joy

________________________________________
do interactive tv on www.remote-tv.de


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
