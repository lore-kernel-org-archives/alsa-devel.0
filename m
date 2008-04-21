From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: My issues with the ALSA API
Date: Mon, 21 Apr 2008 12:56:15 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0804211252240.7882@tm8103.perex-int.cz>
References: <20080409221512.GA4466@tango.0pointer.de>
	<Pine.LNX.4.61.0804100951180.13990@tm8103.perex-int.cz>
	<20080410152038.GD5852@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 9A9F82435D
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Apr 2008 12:56:15 +0200 (CEST)
In-Reply-To: <20080410152038.GD5852@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lennart Poettering <mznyfn@0pointer.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 10 Apr 2008, Lennart Poettering wrote:

> On Thu, 10.04.08 10:16, Jaroslav Kysela (perex@perex.cz) wrote:
> 
> > Mixer
> > =====
> > 
> > Please explain this question (why you need the dB <-> value conversion, 
> > we assumed that application works in dB or integer range not both):
> > 
> > 'It is possible to query the dB range of a smixer element. And it is 
> > possible to query and set the current dB level. However, it is not 
> > possible to have a dB value converted to an integer level or vice versa, 
> > without touching the actual setting. i.e. a question like "What is the 
> > integer level 0 dB corresponds to?" can not be answered by ALSA. Which 
> > happens to be a serious limitation.'
> 
> I can think of many reasons, they all have to do with the fact that
> the dB scale is not integral, i.e. in contrast for the normal integer
> scale you won't always get what you are asking for, because the
> hardware only supports a value below or above what you asked for: a) a
> volume control tool might want to show a slider that is linear to the
> dB scale, but also shows which dB values are actually selectable from
> it via small black lines on the side (or suchlike) b) PA doesn't make
> use of positive dB values -- it limits itself to attenuation via the
> mixer. However, right now there is no way to find out which actually
> supported dB value is the nearest one to 0dB. c) Several different dB
> values may refer to the same actual hw setting. It would be good if a
> specific dB value actually maps to the same integer hw setting as some
> other value, to surpress redundant "volume change" events.

OK. I see your points. I've added these functions to alsa-lib's API:

snd_mixer_selem_ask_playback_vol_dB
snd_mixer_selem_ask_capture_vol_dB
snd_mixer_selem_ask_playback_dB_vol
snd_mixer_selem_ask_capture_dB_vol

					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
