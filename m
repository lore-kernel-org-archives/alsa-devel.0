From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd_pcm_plugin_read: buffer format
Date: Fri, 30 Apr 2004 17:13:57 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0404301712550.17110-100000@studcom.urz.uni-halle.de>
References: <117iDCqod2960S16.1083255269@uwdvg016.cms.usa.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <117iDCqod2960S16.1083255269@uwdvg016.cms.usa.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Nikhil Deo <nikhil_deo@usa.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Nikhil Deo wrote:
> When I read some captured data into a buffer by calling snd_pcm_plugin_read,
> how can I separate the left and right channels from that data?

In the most common case (interleaved stereo data), you have
alternating sample values for left and right.


HTH
Clemens




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
