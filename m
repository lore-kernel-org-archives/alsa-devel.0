From: Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH v2] drm/i915: set proper N/CTS in modeset
Date: Wed, 7 Oct 2015 15:33:27 +0200
Message-ID: <CAKMK7uFwddj64zYugkHGniMD01-ZqaAp0FuorJk-YNg_G=_g_Q@mail.gmail.com>
References: <1443144972-81982-1-git-send-email-libin.yang@intel.com>
 <877fnfnd03.fsf@intel.com> <s5h612yex61.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f170.google.com (mail-ob0-f170.google.com
 [209.85.214.170])
 by alsa0.perex.cz (Postfix) with ESMTP id B62B4265E0B
 for <alsa-devel@alsa-project.org>; Wed,  7 Oct 2015 15:33:28 +0200 (CEST)
Received: by obcgx8 with SMTP id gx8so13037808obc.3
 for <alsa-devel@alsa-project.org>; Wed, 07 Oct 2015 06:33:27 -0700 (PDT)
In-Reply-To: <s5h612yex61.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Dave Airlie <airlied@gmail.com>
Cc: "Yang, Libin" <libin.yang@intel.com>, "Syrjala,
 Ville" <ville.syrjala@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, Jani Nikula <jani.nikula@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 25, 2015 at 10:11 AM, Takashi Iwai <tiwai@suse.de> wrote:
> On Fri, 25 Sep 2015 10:01:48 +0200,
> Jani Nikula wrote:
>>
>> On Fri, 25 Sep 2015, libin.yang@intel.com wrote:
>> > From: Libin Yang <libin.yang@intel.com>
>> >
>> > When modeset occurs and the TMDS frequency is set to some
>> > speical values, the N/CTS need to be set manually if audio
>> > is playing.
>> >
>> > Signed-off-by: Libin Yang <libin.yang@intel.com>
>>
>> Reviewed-by: Jani Nikula <jani.nikula@intel.com>
>
> Now all 4 patches are applied to topic/drm-sync-audio-rate.
>   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git topic/drm-sync-audio-rate
>
> It was merged back to sound for-next branch, too.
>
> Feel free to merge this branch into drm tree.

I've merged your branch with now 5 patches into drm-intel-next-queued.
There's a bit of conflicts with ongoing i915 work, so for pull request
ordering it's probably better when sound goes in before drm (or
otherwise Linus will end up with a mess).

Adding Dave about that one as fyi.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
