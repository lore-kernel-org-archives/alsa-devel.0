From: "Mathieu Rondonneau" <mathieu.rondonneau@polymtl.ca>
Subject: snd_...._copy
Date: Sun, 8 Feb 2004 18:27:41 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <008b01c3eea3$87ed1f50$c4f9cb18@win2K>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
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

Hi,
I've made a mistake about the html format, i'm sorry for that.
This is the last message in text format

I'm writing an ALSA driver using no pci or isa preallocation memory (i'm
using snd_pcm_lib_preallocate_pages_for_all).
I've some questions according to the alsa mecanism to transfert datas.
I'm using ALSA 0.9.6

when i send a wav file to the /dev/audio0 file:
dd if=ring.wav of=/dev/audio0

In my ops function, i've added:
snd_....._playback_copy(snd_pcm_substream_t *substream, int channel,
snd_pcm_uframes_t pos, void* src, snd_pcm_uframes_t count)
1) Why the src pointer doesn't point to the data source (the ring.wav data)
when this function is called by ALSA.

2) why the count parameter is always 200? is it possible to change this
offset in order to copy more data?

3) it seams more complicated to manage memory than using pci or isa
preallocation.
Could i use one of these structure ethen if i don't have ISA or PCI bus/dma
on my board?

Thanks in advance.
Mathieu Rondonneau





-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
