From: Chris J Arges <chris.j.arges@canonical.com>
Subject: Re: [PATCH 4/4 v4] ALSA: usb-audio: Scarlett mixer
 interface for 6i6, 18i6, 18i8 and 18i20
Date: Tue, 4 Nov 2014 13:45:23 -0600
Message-ID: <20141104194522.GA9229@canonical.com>
References: <s5hd29ac9qn.wl-tiwai@suse.de>
 <1415055496-11151-1-git-send-email-chris.j.arges@canonical.com>
 <1415055496-11151-5-git-send-email-chris.j.arges@canonical.com>
 <s5hppd39sm8.wl-tiwai@suse.de> <5458D19D.7050206@gmx.de>
 <5458D49E.6060305@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 437E5260623
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 20:45:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <5458D49E.6060305@gmx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tobias Hoffmann <th55@gmx.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, robin@gareus.org, clemens@ladisch.de, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 04, 2014 at 02:29:02PM +0100, Tobias Hoffmann wrote:
> On 04/11/14 14:16, Tobias Hoffmann wrote:
> >But maybe (as Clemens suggested) the strings *for .opt_master and
> >.opt_matrix* should just be created dynamically in
> >scarlett_ctl_enum_info, instead of using snd_ctl_enum_info.
> >I want to point out that scarlett_device_info already contains the
> >necessary information to do this:
> >
> >    .matrix_out = 6,
> >...
> >    .pcm_start = 0,  // pcm(1) .. pcm(analog_start-pcm_start)=pcm(12)
> >    .analog_start = 12, // analog(1) .. analog(4)
> >    .spdif_start = 16, // spdif(1) .. spdif(2)
> >    .adat_start = 18,  // adat(1) .. adat(0)  [i.e. no adat]
> >    .mix_start = 18, // mix('A') .. mix('F')=mix('A' + matrix_out)
> >
> >
> >
> >and Off(-1). Only elem->private_data has to be of type
> >scarlett_mixer_elem_enum_info for the usual enums (impedance, pad,
> >...), but of type scarlett_device_info for the master and mixer
> >enums...
> >
> 
> Hmm, as the same options are required for a lot of master and mixer
> enums, the strings should probably be generated only once (and a
> dynamic scarlett_mixer_elem_enum_info would require no modifications
> of scarlett_ctl_enum_info).
> 
>   Tobias

Yes this would be the plan dynamially generate them once and reuse them. I'll work on implementing this.
--chris 
