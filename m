From: Jaroslaw Sobierski <fycio@gucio.com>
Subject: Re: Re: dmix plugin
Date: Mon, 17 Feb 2003 03:18:26 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1045480706.3e50c5023b9bc@webmail3.namezero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: perex@suse.cz
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>> In our case, such "solution" would have to affect the whole buffer, meaning 
>> we would need 3 (or better yet 4) bytes per sample, which would eventually get
>> reduced back to 2 bytes on the way out to the sound card. This seems neither
>> elegant nor memory efficient but would work, and also solves the "a)" problem
>> because we don't need to saturate so an atomic add can be performed on each
>> sample. 
>
>Yes, this solution is good. I've though about it, too. Unfortunately, it 
>adds additional transfers including saturation from the "sum" ring buffer 
>to the DMA buffer of hardware.

Hmmm... Not exactly. This is not a problem. First of all: it is way
better to saturate once (i.e. just before the transfer) since this is
a costly operation involving a conditional jump (unless you optimize for
mmx) than do it for every channel individually. If you're mixing 4
channels you do it once, not 4 times. Just because you need to store the 
result in a different buffer, rather than putting it in it's original 
place seems hardly a big difference (except for cache hits maybe).

Also, if you insist on sparing memory (the buffer is not *that*
big is it?) you can lay it out as two separate (ring) buffers, one 
holding upper words, the other holding lower words. Now instead of 
shifting the samples right n-bits before adding to the buffer, you 
shift them left 16-n. In effect you will get a buffer (the upper part) 
which can be directly sent to the audio hw, and which was summed and 
divided without losing precision. The drawback is you lose the atomic 
add. If you don't shift, you can still saturate into the "upper" buffer 
and DMA from there.


--------------
Fycio (J.Sobierski)
 fycio@gucio.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
