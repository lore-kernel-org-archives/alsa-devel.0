From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [alsa-devel] [PATCH 04/17] firewire-lib: Split some codes into
	functions to reuse in future
Date: Mon, 25 Nov 2013 16:27:18 +0100
Message-ID: <52936C56.5010502@ladisch.de>
References: <1385186884-8259-1-git-send-email-o-takashi@sakamocchi.jp>
	<1385186884-8259-5-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1385186884-8259-5-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> Some codes can be reused in handling transmitted stream. This commit adds new
> functions. This commit also renames some functions to keep naming consistency.

> +++ b/sound/firewire/amdtp.c

> +#define TRANSMIT_PACKET_HEADER_SIZE	4
> ...
> +static inline int queue_out_packet(struct amdtp_stream *s,
> +				   unsigned int payload_length, bool skip)
> +{
> +	return queue_packet(s, RECEIVE_PACKET_HEADER_SIZE,
> +			    payload_length, skip);

And this is what I complained about for patch 3.

> +static void check_pcm_pointer(struct amdtp_stream *s,

Thw word "check" does not imply that the pointers get changed.  Please
use something like "update_pcm_pointers".

> +static int queue_packet(struct amdtp_stream *s,
> +{
> +	p.skip = (!skip) ? 0: 1;

	p.skip = skip;

> @@ -612,8 +618,8 @@ int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed)
>  	s->context = fw_iso_context_create(fw_parent_device(s->unit)->card,
>  					   FW_ISO_CONTEXT_TRANSMIT,
>  					   channel, speed, 0,
> -					   out_packet_callback, s);
> +					   out_stream_callback, s);
> -	if (IS_ERR(s->context)) {
> +	if (!amdtp_stream_running(s)) {

The stream is not yet running at this point, so using this function here
would be confusing.


Regards,
Clemens

------------------------------------------------------------------------------
Shape the Mobile Experience: Free Subscription
Software experts and developers: Be at the forefront of tech innovation.
Intel(R) Software Adrenaline delivers strategic insight and game-changing 
conversations that shape the rapidly evolving mobile landscape. Sign up now. 
http://pubads.g.doubleclick.net/gampad/clk?id=63431311&iu=/4140/ostg.clktrk
