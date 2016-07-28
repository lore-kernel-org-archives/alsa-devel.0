From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH v4] topology: Return -EINVAL at once on
 failure to find a reference
Date: Thu, 28 Jul 2016 15:22:12 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F84BA8D05E@shsmsx102.ccr.corp.intel.com>
References: <1469609333-13961-1-git-send-email-mengdong.lin@linux.intel.com>
 <F46914AEC2663F4A9BB62374E5EEF8F84BA8C30F@shsmsx102.ccr.corp.intel.com>
 <f1b39296-2fcb-7b58-4ff5-b9bb904cb9e9@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id B54442679A6
 for <alsa-devel@alsa-project.org>; Thu, 28 Jul 2016 17:22:17 +0200 (CEST)
In-Reply-To: <f1b39296-2fcb-7b58-4ff5-b9bb904cb9e9@sakamocchi.jp>
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
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "mengdong.lin@linux.intel.com" <mengdong.lin@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Sakamoto [mailto:o-takashi@sakamocchi.jp]
> Sent: Thursday, July 28, 2016 10:05 PM
 
> On Jul 28 2016 10:17, Lin, Mengdong wrote:
> > Please overlook this patch.
> > Since v3 has been applied, so this v4 is no longer needed.
> 
> Although, I prefer this direction than the merged patch.

Hi Sakamoto-san,

Probably we can do this code refactor later, after the merge window.
> 
> Anyway, it's within merge window for kernel 4.8 and alsa-lib 1.2.0 (or 1.1.2).
> It's preferable for us to test current master, seek and fix mistakes. Not to
> post patchsets for the other purposes to disturb maintainers' work.
> 
> 
> Well, this is a call graph related to tplg_copy_data().
> 
>   snd_tplg_build_file()
>   ->snd_tplg_build()
>     ->tplg_build_integ()
>       (src/topology/data.c)
>       ->tplg_build_manifest_data()
> *       ->tplg_copy_data()
>       (src/topology/ctl.c)
>       ->tplg_build_controls()
>         ->tplg_build_mixer_controls()
> *         ->tplg_copy_data()
>         ->tplg_build_enum_controls()
> *         ->tplg_copy_data()
>         ->tplg_build_bytes_controls()
> *         ->tplg_copy_data()
>       (src/topology/dapm.c)
>       ->tplg_build_widget()
> *       ->tplg_copy_data()
> 
> The callers of tplg_copy_data() has similar branchs. The branch consists of:
> 1. look up an element and assigned it to 'ref' variable 2. copy something in
> the structure
> 
> The difference is element type. In this case, I prefer calling each
> type-specilized method (lookup and copy) in caller side. In this shape, we can
> easily know the purpose of each branch, and error handling becomes easier.
> 
> Please read this commit. (not compiled and tested yet) It's just to show the
> concept.
> https://github.com/takaswie/alsa-lib/commit/ab5d63329e29118307a5630
> 24718293d3a6abd01

The previous code is almost same as that in your patch.
Although private data is now only used by controls and widget, but it will be used in PCM, BE DAIs and links in later patches. This why I merge data look up and copy in one function to save the code.
I'll check later if to split it again to keep the unified style.

> Furthermore, these methods are different depending on element type. So it
> might be possible to assign the type-specialized 'lookup' and 'copy'
> methods to pointers of structure which represents a certain element with
> type. In this case, the codes are likely to become more simpler, in my opinion.
> (If it were C++ code, developers would eager to add new base/derived
> classes.)

I hesitate to add more method pointers atm. 
Now all generic methods are defined by base elements, such as new/free/look up/private data copy.
The derived topology element types are quite different and so we define different non-data reference copy methods, although not as method pointers. 

Thanks
Mengdong
