From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Softvol controls
Date: Fri, 30 Nov 2007 00:28:59 +0100
Message-ID: <20071129232859.GA18138@tango.0pointer.de>
References: <20071120005151.GA25276@tango.0pointer.de>
	<s5htznfhmhy.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 8D84D2417E
	for <alsa-devel@alsa-project.org>; Fri, 30 Nov 2007 00:29:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5htznfhmhy.wl%tiwai@suse.de>
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

On Wed, 21.11.07 12:22, Takashi Iwai (tiwai@suse.de) wrote:

> >    Now, is there a way I can detect for a mixer element if it is
> >    "real" or if it is implemented only for the "plughw" PCM? As it
> >    seems the "hw:0" mixer device does contain "virtual" tracks, isn't that a
> >    bit strange? Shouldn't the virtual mixer tracks be available only
> >    in a mixer device "plughw:0"? That at least would be symmetric to
> >    the PCM case, wouldn't it?
> 
> Check snd_ctl_elem_info_is_user().  All softvol controls are
> implemented as user elements.

Hmm, how am I supposed to get the snd_ctl_elem_info_t from a
snd_mixer_elem_t or snd_mixer_selem_id_t?

I figure there is no useful documentation or even example how this is
supposed to work? Hmm, is there any real documentation available which
describes the relation of ctl, hctl, mixer and smixer at all? For the
uninitated the whols structure looks overly complex and redundant.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
