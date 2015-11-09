From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [RFC PATCH 0/2] ALSA: hda - DP MST audio for Jack
 support
Date: Mon, 9 Nov 2015 15:00:01 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D197782DD@SHSMSX103.ccr.corp.intel.com>
References: <1446540176-110181-1-git-send-email-libin.yang@linux.intel.com>
 <s5hsi4nni3u.wl-tiwai@suse.de>	<5639A452.20106@linux.intel.com>
 <s5hmvunk3ib.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 82FE926043C
 for <alsa-devel@alsa-project.org>; Mon,  9 Nov 2015 16:00:12 +0100 (CET)
In-Reply-To: <s5hmvunk3ib.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, Libin Yang <libin.yang@linux.intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "mengdong.lin@linux.intel.com" <mengdong.lin@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Monday, November 09, 2015 3:59 PM
> To: Libin Yang
> Cc: alsa-devel@alsa-project.org; mengdong.lin@linux.intel.com; Yang,
> Libin
> Subject: Re: [alsa-devel] [RFC PATCH 0/2] ALSA: hda - DP MST audio for
> Jack support
> 
> On Wed, 04 Nov 2015 07:23:14 +0100,
> Libin Yang wrote:
> >
> >
> > On 11/04/2015 12:49 AM, Takashi Iwai wrote:
> > > On Tue, 03 Nov 2015 09:42:54 +0100,
> > > libin.yang@linux.intel.com wrote:
> > >>
> > >> From: Libin Yang <libin.yang@linux.intel.com>
> > >>
> > >> This is the patch set for Jack support for DP MST audio
> > >>
> > >> Libin Yang (2):
> > >>    ALSA: hda - jack support DP MST audio
> > >>    ALSA: hda - hdmi audio add dynamically jack binding to pin
> > >
> > > I'm somehow confused by this patch series.
> > > Is the unsolicited event handling itself changed for MST?  I mean, you
> > > cannot know which MST dev# is given beforehand, while you seem
> trying
> > > to assign such a number to the jack object.
> >
> > Oh, sorry I forgot to mention that we only operate on device entry 0
> > so far in the code. It's misleading.
> >
> > These patches don't operate on MST audio. The full MST audio driver
> > support will be implemented in the later patches. The patches help to
> > prepare supporting MST audio.
> >
> > The purpose of the patches is try to dynamically attach the Jack.
> 
> Well, only judging from the quick glance, I don't buy this strategy,
> sorry.  Currently for HDMI/DP, the jack is for PCM, not for pin.
> Namely, user-space watches the jack notification to judge whether the
> corresponding PCM is available or not.  You're trying to change this
> scheme completely.

The patch is to make sure the jack is bound to PCM statically.
This patch is needed because in old code,  it will create jack with:
for (pin_idx = 0; pin_idx < spec->num_pins; pin_idx++) {
	...
	err = generic_hdmi_build_jack(codec, pin_idx);
	...
}
Which means the jack is created based on pin number and pin_idx.
As a pin is bound statically to the PCM, the jack is statically bound to PCM. 

Now we are using the dynamic pcm bound. If we use the old code to
create the jack, the jack will be bound to pin. So we need the patch, 
which will use the new code:
for (pcm_idx = 0; pcm_idx < spec-> pcms_used; pcm_idx++) {
	...
	err = generic_hdmi_build_jack(codec, pcm_idx);
	...
}
which makes sure that the jack is bound to PCM (jack[0] is bound 
to pcm[0], jack[1] is bound to pcm[1] and so on).

If there is no monitor, no pin is bound to the PCM. 
So no pin is bound to the Jack. When there is a monitor connected, 
the pin is bound to a proper PCM. So we should bind the PCM's jack
to the pin. 

For example, jack0 is bound to the PCM 3 (the first jack is bound 
to the first PCM statically). When a monitor is connected to pin 5, 
PCM 3 will be assigned to the pin. We need bind jack 0 to pin 5. 
When monitor is disconnected, we must unbind the jack 0 from pin 5. 
These operation are done in function 
snd_hda_jack_bind/ snd_hda_jack_unbind.

Best Regards,
Libin

> 
> So, please convince us why this change is needed and which merit /
> demerit it'll bring.  Let's start from that point.(c)
> 
> 
> thanks,
> 
> Takashi
