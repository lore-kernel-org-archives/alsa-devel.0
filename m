From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 0/5 v2] ALSA: firewire-lib: purge restriction of
	synchronization for non-blocking mode
Date: Tue, 26 May 2015 00:12:06 +0900
Message-ID: <55633BC6.20405@sakamocchi.jp>
References: <1432303254-4192-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1432303254-4192-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On May 22 2015 23:00, Takashi Sakamoto wrote:
> This patchset renews my previous one.
> 
> [alsa-devel] [PATCH 0/4] firewire-lib: purge restriction of synchronization for non-blocking mode
> http://mailman.alsa-project.org/pipermail/alsa-devel/2015-May/092086.html
> 
> Changes:
>  * Use stack to keep calculation result per callback of isochronous receive context.
>  * Fix my stupid mistake to compare byte count to quadlet count. (oh...)
>  * Rename flag to proper name.
>  * Add 4th patch newly for better reading.
> 
> 
> Takashi Sakamoto (5):
>   ALSA: firewire-lib: add buffer-over-run protection at receiving more
>     data blocks than expected
>   ALSA: firewire-lib: simplify function to calculate the number of data
>     blocks
>   ALSA: firewire-lib: pass the number of data blocks in incoming packets
>     to outgoing packets
>   ALSA: firewire-lib: set streaming error outside of packetization
>   ALSA: firewire-lib: remove restriction for non-blocking mode
> 
>  sound/firewire/amdtp.c            | 151 ++++++++++++++++++++++++--------------
>  sound/firewire/amdtp.h            |   4 +
>  sound/firewire/oxfw/oxfw-stream.c |  10 ++-
>  3 files changed, 106 insertions(+), 59 deletions(-)

I realized that 3rd and 4th patches cause unexpected execution under
compiler optimization. As a result, when setting error state to incoming
stream, this module can cause invalid paging request.

I guess that 'struct amdtp_stream.packet_index' is set with minus value
and it's used to refer to packet buffer (struct
amdtp_stream.buffer.packets). Then a pointer of the buffer refers to
invalid page.

I tested -O1 and -O2 options for gcc. In both cases,
"handle_in_packet()" is merged into "in_stream_callback()", as I
expected. While, the error condition may not be handled as my
expectation. Especially under -O2, even if 'handle_in_packet()' returns
minus value, the loop in 'in_stream_callback()' doesn't finished till
all of packets are handled. In this case, when detecting packet
discontinuity, several error messages occur against my intension (one
iteration).

Briefly, I move 's->packet_index = -1' from 'in_stream_callback()' to
'handle_in_packet()' and the stack seems to work as I expected. But I'm
not so good at compiler optimization, so need a bit time to fix this issue..

Sorry to post patchset including bugs...


Regards

Takashi Sakamoto

------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
