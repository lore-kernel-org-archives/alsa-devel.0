From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH v4] topology: Return -EINVAL at once on
 failure to find a reference
Date: Thu, 28 Jul 2016 23:05:05 +0900
Message-ID: <f1b39296-2fcb-7b58-4ff5-b9bb904cb9e9@sakamocchi.jp>
References: <1469609333-13961-1-git-send-email-mengdong.lin@linux.intel.com>
 <F46914AEC2663F4A9BB62374E5EEF8F84BA8C30F@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 1507626768A
 for <alsa-devel@alsa-project.org>; Thu, 28 Jul 2016 16:05:10 +0200 (CEST)
In-Reply-To: <F46914AEC2663F4A9BB62374E5EEF8F84BA8C30F@shsmsx102.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Lin, Mengdong" <mengdong.lin@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "mengdong.lin@linux.intel.com" <mengdong.lin@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On Jul 28 2016 10:17, Lin, Mengdong wrote:
> Please overlook this patch.
> Since v3 has been applied, so this v4 is no longer needed.

Although, I prefer this direction than the merged patch.

Anyway, it's within merge window for kernel 4.8 and alsa-lib 1.2.0 (or
1.1.2). It's preferable for us to test current master, seek and fix
mistakes. Not to post patchsets for the other purposes to disturb
maintainers' work.


Well, this is a call graph related to tplg_copy_data().

  snd_tplg_build_file()
  ->snd_tplg_build()
    ->tplg_build_integ()
      (src/topology/data.c)
      ->tplg_build_manifest_data()
*       ->tplg_copy_data()
      (src/topology/ctl.c)
      ->tplg_build_controls()
        ->tplg_build_mixer_controls()
*         ->tplg_copy_data()
        ->tplg_build_enum_controls()
*         ->tplg_copy_data()
        ->tplg_build_bytes_controls()
*         ->tplg_copy_data()
      (src/topology/dapm.c)
      ->tplg_build_widget()
*       ->tplg_copy_data()

The callers of tplg_copy_data() has similar branchs. The branch consists of:
1. look up an element and assigned it to 'ref' variable
2. copy something in the structure

The difference is element type. In this case, I prefer calling each
type-specilized method (lookup and copy) in caller side. In this shape,
we can easily know the purpose of each branch, and error handling
becomes easier.

Please read this commit. (not compiled and tested yet) It's just to show
the concept.
https://github.com/takaswie/alsa-lib/commit/ab5d63329e29118307a563024718293d3a6abd01

Furthermore, these methods are different depending on element type. So
it might be possible to assign the type-specialized 'lookup' and 'copy'
methods to pointers of structure which represents a certain element with
type. In this case, the codes are likely to become more simpler, in my
opinion. (If it were C++ code, developers would eager to add new
base/derived classes.)


Regards

Takashi Sakamoto
