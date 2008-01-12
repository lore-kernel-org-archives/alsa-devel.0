From: Daniel Jacobowitz <drow@false.org>
Subject: Re: [RFC] [Patch 2/2] Add virtual master to HD-audio
Date: Sat, 12 Jan 2008 15:21:22 -0500
Message-ID: <20080112202122.GA29942@caradoc.them.org>
References: <s5hprx12x6x.wl%tiwai@suse.de> <s5hk5n92wtg.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nan.false.org (NaN.false.org [208.75.86.248])
	by alsa0.perex.cz (Postfix) with ESMTP id 98BAF24720
	for <alsa-devel@alsa-project.org>; Sat, 12 Jan 2008 21:21:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hk5n92wtg.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 20, 2007 at 04:46:35PM +0100, Takashi Iwai wrote:
>  static struct snd_kcontrol_new alc880_lg_mixer[] = {
>  	/* FIXME: it's not really "master" but front channels */
> -	HDA_CODEC_VOLUME("Master Playback Volume", 0x0f, 0x0, HDA_OUTPUT),
> -	HDA_BIND_MUTE("Master Playback Switch", 0x0f, 2, HDA_INPUT),
> +	HDA_CODEC_VOLUME("Front Playback Volume", 0x0f, 0x0, HDA_OUTPUT),
> +	HDA_BIND_MUTE("Front Playback Switch", 0x0f, 2, HDA_INPUT),

You've just fixed that FIXME :-)

-- 
Daniel Jacobowitz
CodeSourcery
