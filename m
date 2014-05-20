From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [alsa-devel] [RFC] set up an sync channel between
 audio and display driver (i.e. ALSA and DRM)
Date: Tue, 20 May 2014 17:22:07 +0200
Message-ID: <CAKMK7uGgZ6HoVM1EWDPk5bZGbik3cO_=eVVtRHMrFNQN0Np9UQ@mail.gmail.com>
References: <F46914AEC2663F4A9BB62374E5EEF8F82B447059@SHSMSX101.ccr.corp.intel.com>
 <1400596147.32158.36.camel@intelbox>
 <CAKMK7uFdPiBoTO-oKCF-t3JbHVwB9F_wFTNnUwgH5JL2fpSH7Q@mail.gmail.com>
 <20140520145729.GB23140@ulmo> <537B6FC7.9030307@intel.com>
 <20140520151531.GA19286@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20140520151531.GA19286@ulmo>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: "Yang, Libin" <libin.yang@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Nikkanen,
 Kimmo" <kimmo.nikkanen@intel.com>, "Takashi Iwai (tiwai@suse.de)" <tiwai@suse.de>, "Babu,
 Ramesh" <ramesh.babu@intel.com>, "Koul, Vinod" <vinod.koul@intel.com>, "Girdwood, Liam R" <liam.r.girdwood@intel.com>, Daniel Vetter <daniel.vetter@intel.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
List-Id: alsa-devel@alsa-project.org

On Tue, May 20, 2014 at 5:15 PM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> The component/master helpers don't allow you to do that. Essentially
> what it does is provide a way to glue together multiple devices (the
> components) to produce a meta-device (the master). What you get is a
> pair of .bind()/.unbind() functions that are called on each of the
> components when the master binds or unbinds the meta-device. I don't
> see how that could be made to work for suspend/resume.

We'll we could add a pm_ops pointer to the master and auto-register a
pile of suspend/resume hooks to all the component devices. Then we'd
suspend the master as soon as the first component gets suspended and
resume it only when the last component is resumed. Should be doable
with a bunch of refcounts.

On top of that we should be able to use runtime pm to do fine-grained
pm control for each component. So in my naive world here (never used
the component stuff myself after all) this should all work out ;-)
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
