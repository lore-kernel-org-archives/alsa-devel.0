From: Andy Robinson <andy@seventhstring.com>
Subject: Memory allocation and the "prealloc" procfile
Date: Mon, 04 Apr 2005 10:03:37 +0100
Message-ID: <1112605417.6910.26.camel@andys_dellm60.ss82amr.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

I'm using Mandrake 10.1 on a DELL Precision M60.
Soundcard is Intel 82801DB-ICH4
ALSA version 1.0.6

By default, /proc/asound/card0/pcm0p/sub0/prealloc contains the number
64 and SNDCTL_DSP_GETOSPACE reports a total of 16k bytes output space
available. If I
echo 128 >/proc/asound/card0/pcm0p/sub0/prealloc
then SNDCTL_DSP_GETOSPACE reports a total of 32k bytes.

My question is, what is the rest of the "prealloc" memory being used
for? And how can I change the amounts used for whatever other purposes,
so as to get a bigger SNDCTL_DSP_GETOSPACE buffer? It's not such a
problem for me but one of my users reports that with a 128k "prealloc",
he still gets only 4k from SNDCTL_DSP_GETOSPACE. Is it perhaps an ALSA
version issue?

I've asked before about this but still not found the answer. I'd be
grateful for any help.

I did look at the source but found it a bit difficult, as an ALSA
newbie, to see where the decision is being made.

Andy Robinson, Seventh String Software, www.seventhstring.com



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
