From: Nenghua Cao <nhcao@marvell.com>
Subject: Re: [PATCH] ASOC:DAPM: extend dapm kcontrol to support
 runtime route update
Date: Fri, 13 Dec 2013 19:25:16 +0800
Message-ID: <52AAEE9C.2070606@marvell.com>
References: <1386835619-18070-1-git-send-email-nhcao@marvell.com>
 <s5hlhzqqadw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F596261603
 for <alsa-devel@alsa-project.org>; Fri, 13 Dec 2013 12:19:42 +0100 (CET)
In-Reply-To: <s5hlhzqqadw.wl%tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Henry Zhao <xzhao10@marvell.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Yacine Belkadi <yacine.belkadi.1@gmail.com>, Chao Xie <cxie4@marvell.com>
List-Id: alsa-devel@alsa-project.org

On 12/13/2013 12:52 AM, Takashi Iwai wrote:
> At Thu, 12 Dec 2013 16:06:59 +0800,
> Nenghua Cao wrote:
>> > 
>> > From: nhcao <nhcao@marvell.com>
>> > 
>> >     DPCM can dynamically alter the FE to BE PCM links at runtime based
>> > on mixer setting updates. DAPM has provided common get/put function for
>> > mixer/mux. But these function doesn't call soc_dpcm_runtime_update()
>> > func to update pcm links. This patch defines a DPCM DPCM kcontrol. For
>> > this control, the common get/put function will update FE to BE links
>> > dynamically. This patch has no impact to the current code.
>> > 
>> > Change-Id: I45e291f467e4fa17e21aa8923c2b712d52067aca
> Don't include such an internal tag in the public patch.
> 
>> > Signed-off-by: nhcao <nhcao@marvell.com>
> You have to provide your real name in from and signed-off-by tags.
> 
Thanks for your reminder. Fixed them.
>> > ---
>> >  include/sound/control.h  |    4 ++++
>> >  include/sound/soc-dapm.h |   32 ++++++++++++++++++++++++++++++++
>> >  sound/core/control.c     |    1 +
>> >  sound/soc/soc-dapm.c     |   28 ++++++++++++++++++++++++----
>> >  4 files changed, 61 insertions(+), 4 deletions(-)
>> > 
>> > diff --git a/include/sound/control.h b/include/sound/control.h
>> > index 5358892..3788284 100644
>> > --- a/include/sound/control.h
>> > +++ b/include/sound/control.h
>> > @@ -44,6 +44,8 @@ struct snd_kcontrol_new {
>> >  	unsigned int index;		/* index of item */
>> >  	unsigned int access;		/* access rights */
>> >  	unsigned int count;		/* count of same elements */
>> > +	/* this kcontrol impact fe<->be relationship at runtime */
>> > +	unsigned char dpcm_checked;
>> >  	snd_kcontrol_info_t *info;
>> >  	snd_kcontrol_get_t *get;
>> >  	snd_kcontrol_put_t *put;
>> > @@ -63,6 +65,8 @@ struct snd_kcontrol {
>> >  	struct list_head list;		/* list of controls */
>> >  	struct snd_ctl_elem_id id;
>> >  	unsigned int count;		/* count of same elements */
>> > +	/* this kcontrol impact fe<->be relationship at runtime */
>> > +	unsigned char dpcm_checked;
>> >  	snd_kcontrol_info_t *info;
>> >  	snd_kcontrol_get_t *get;
>> >  	snd_kcontrol_put_t *put;
> You don't need to extend the ALSA core API for such a purpose.  It's
> ASoC-specific, so rather extend struct soc_mixer_control instead, if
> such a new flag is really needed.
> 
It is a good suggestion. We should avoid touching ALSA core. I also want
to introduce little change. I made another patch per your suggestion.
Please review it again. Thanks!
> 
> Takashi
