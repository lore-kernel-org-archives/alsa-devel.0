From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] topology: Include <linux/types.h> in API
	header file
Date: Fri, 6 Nov 2015 19:01:18 +0530
Message-ID: <20151106133118.GA18120@localhost>
References: <1446813576-29295-1-git-send-email-mengdong.lin@linux.intel.com>
 <s5hoaf7z3k2.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 9AF1D260429
 for <alsa-devel@alsa-project.org>; Fri,  6 Nov 2015 14:27:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hoaf7z3k2.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, mengdong.lin@linux.intel.com, mengdong.lin@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 06, 2015 at 01:59:41PM +0100, Takashi Iwai wrote:
> On Fri, 06 Nov 2015 13:39:36 +0100,
> mengdong.lin@linux.intel.com wrote:
> > =

> > From: Mengdong Lin <mengdong.lin@linux.intel.com>
> > =

> > Include <linux/types.h> in the API header file topology.h
> > =

> > The struct snd_tplg_stream_caps_template has a member "formats"
> > of type __le64. So <linux/types.h> is needed.
> =

> We shouldn't use __le64 for user-space API.  I couldn't find it in
> include/topology.h.  Where is it used?
> =

> Of course, it's fine to use it for kernel ABI.  But then linux/types.h
> is already included in local.h, so it shouldn't be a problem.

Our tool threw this error

./local-alsa/include/alsa/topology.h:668:2: error: =E2__le64=E2 does not na=
me a
type
  __le64 formats; /*!< supported formats SNDRV_PCM_FMTBIT_* */


It is coming from new ABI update

/*
 * Stream Capabilities
 */
struct snd_soc_tplg_stream_caps {
        __le32 size;            /* in bytes of this structure */
        char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
        __le64 formats; /* supported formats SNDRV_PCM_FMTBIT_* */
^^^^^^^^^^^^^^^^^^^^^

        __le32 rates;           /* supported rates SNDRV_PCM_RATE_* */
        __le32 rate_min;        /* min rate */
        __le32 rate_max;        /* max rate */
        __le32 channels_min;    /* min channels */
        __le32 channels_max;    /* max channels */
        __le32 periods_min;     /* min number of periods */
        __le32 periods_max;     /* max number of periods */
        __le32 period_size_min; /* min period size bytes */
        __le32 period_size_max; /* max period size bytes */
        __le32 buffer_size_min; /* min buffer size bytes */
        __le32 buffer_size_max; /* max buffer size bytes */
} __attribute__((packed));

The problem is the users of alsa-lib and not the alsa-lib compile itself..

Thanks
-- =

~Vinod
