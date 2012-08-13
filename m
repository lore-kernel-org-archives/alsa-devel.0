From: "Wang, Xingchao" <xingchao.wang@intel.com>
Subject: Re: [PATCH 3/3] ALSA: hda - Disable DigEn bit before
 stream-id change
Date: Mon, 13 Aug 2012 08:11:38 +0000
Message-ID: <46B810F6945F7C4788E11DCE57EC48900FF442B5@SHSMSX102.ccr.corp.intel.com>
References: <1344838271-3528-1-git-send-email-xingchao.wang@intel.com>
 <1344838271-3528-3-git-send-email-xingchao.wang@intel.com>
 <s5htxw7w8lh.wl%tiwai@suse.de>
 <46B810F6945F7C4788E11DCE57EC48900FF44217@SHSMSX102.ccr.corp.intel.com>
 <s5hobmfw7p6.wl%tiwai@suse.de> <s5hk3x3w72r.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id AECEC265D18
 for <alsa-devel@alsa-project.org>; Mon, 13 Aug 2012 09:42:08 +0200 (CEST)
In-Reply-To: <s5hk3x3w72r.wl%tiwai@suse.de>
Content-Language: en-US
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Monday, August 13, 2012 4:05 PM
> To: Wang, Xingchao
> Cc: alsa-devel@alsa-project.org
> Subject: Re: [PATCH 3/3] ALSA: hda - Disable DigEn bit before stream-id change
> 
> At Mon, 13 Aug 2012 09:51:33 +0200,
> Takashi Iwai wrote:
> >
> > At Mon, 13 Aug 2012 07:37:12 +0000,
> > Wang, Xingchao wrote:
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Takashi Iwai [mailto:tiwai@suse.de]
> > > > Sent: Monday, August 13, 2012 3:32 PM
> > > > To: Wang, Xingchao
> > > > Cc: alsa-devel@alsa-project.org
> > > > Subject: Re: [PATCH 3/3] ALSA: hda - Disable DigEn bit before
> > > > stream-id change
> > > >
> > > > At Mon, 13 Aug 2012 14:11:11 +0800, Wang Xingchao wrote:
> > > > >
> > > > > Follow the protection way in nvhdmi_8ch_7x_pcm_prepare().
> > > >
> > > > Could you clarify why this is needed?
> > >
> > > > I don't mean an objection, but just need to know if there is any
> > > > other devices that need this fix.  If there really is, better to
> > > > put a bit more details in changelog or comment.
> > >
> > > No, it's not really a fix for the issue.
> > > I just found the change when to investigate HDMI HBR issue and it does
> NOT help fix the issue.
> > > However I thought it's a fix to some other bug(seen from comments),
> > > so I think it's also needed as a common solution. Please correct me if I am
> wrong.
> >
> > I guess this was copied from setup_dig_out_stream() in hda_codec.c.
> > This was a workaround for SPDIF output on some old non-HDMI codecs.
> > But most of recent codecs shouldn't need it.  You see that it's
> > protected by codec->spdif_status_reset check.
> 
> BTW, you might have forgotten to set codec->spdif_status_reset = 1 during
> your test?  Otherwise the code there isn't activated.
> 

Oh, thanks for clarification, will test that again. :)

> Though, this doesn't explain why it worked for nvidia and not for Intel.  The
> IEC958 status temporary toggle code isn't active even for Nvidia, too.
> 

Thanks
--xingchao
