From: Jonathan Woithe <jwoithe@just42.net>
Subject: Re: [FFADO-devel] [RFC][PATCH 34/37] ALSA:
 firewire-motu: add proc node to show the status of internal clock
Date: Mon, 13 Jul 2015 20:58:23 +0930
Message-ID: <20150713112823.GE32641@marvin.atrad.com.au>
References: <1436623968-10780-1-git-send-email-o-takashi@sakamocchi.jp>
 <1436623968-10780-35-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
 by alsa0.perex.cz (Postfix) with ESMTP id A41B32605A9
 for <alsa-devel@alsa-project.org>; Mon, 13 Jul 2015 13:28:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1436623968-10780-35-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Sat, Jul 11, 2015 at 11:12:45PM +0900, Takashi Sakamoto wrote:
> This commit adds a proc node for debugging purpose.
> :
> +static void proc_read_clock(struct snd_info_entry *entry,
> +			    struct snd_info_buffer *buffer)
> +{
> +
> +	struct snd_motu *motu = entry->private_data;
> +	unsigned int rate;
> +	enum snd_motu_clock src;
> +
> +	if (snd_motu_stream_get_rate(motu, &rate) < 0)
> +		return;
> +	if (snd_motu_stream_get_clock(motu, &src) < 0)
> +		return;
> +
> +	snd_iprintf(buffer, "Rate:\t%d\n", rate);
> +	snd_iprintf(buffer, "Source:\t%s\n", clock_names[src]);
> +}

Is it necessary to define a proc node for this information?  It is trivial
to obtain the status of MOTU devices directly from the device regardless of
the state of the streaming system.  In fact, while the above code seems to
be linked to a running stream, the concept of the device clock persists even
when no streams are running.  Or is the intent here to verify the internal
state of any running ALSA stream structures rather than the physical device
itself?

Regards
  jonathan
