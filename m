From: Tanu Kaskinen <tanuk@iki.fi>
Subject: Re: [RFC] Channel mapping API (take 2)
Date: Wed, 05 Sep 2012 09:00:12 +0300
Message-ID: <1346824812.3629.29.camel@laptop>
References: <s5hhard23jb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 55FA92652DB
 for <alsa-devel@alsa-project.org>; Wed,  5 Sep 2012 08:00:15 +0200 (CEST)
In-Reply-To: <s5hhard23jb.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2012-09-04 at 17:47 +0200, Takashi Iwai wrote:
> The rest aren't so much changed.  Only slight bug fixes.

I have a couple of comments about "the rest". I haven't been following
the development of the channel map API very closely, so I'm relying on
the pcm.h file only.


/** channel map list type */
enum snd_pcm_chmap_type {
	SND_CHMAP_NONE = 0,	/** unspecified channel position */
	SND_CHMAP_FIXED,	/** fixed channel position */
	SND_CHMAP_VAR,		/** freely swappable channel position */
	SND_CHMAP_PAIRED,	/** pair-wise swappable channel position */
};

It's not clear to me what the VAR and PAIRED types actually mean. It
would be nice to explain in more detail the concepts in the header.


The snd_pcm_chmap_position enum doesn't contain an entry for mono. I
think it would be a useful channel to have. Up/downmixing decisions may
be different with mono than, for example, a single channel declared as
front left.

-- 
Tanu
