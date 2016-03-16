From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: New snd-hda warning spew
Date: Wed, 16 Mar 2016 16:04:20 +0200
Message-ID: <20160316140420.GB4329@intel.com>
References: <20160315160207.GY4329@intel.com>
 <s5hio0nejv3.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 9DFC1265B54
 for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2016 15:04:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hio0nejv3.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Libin Yang <libin.yang@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 15, 2016 at 06:22:56PM +0100, Takashi Iwai wrote:
> On Tue, 15 Mar 2016 17:02:07 +0100,
> Ville Syrj=E4l=E4 wrote:
> > =

> > We have a few new WARN spews from snd-hda causing some grief in i915 CI.
> > =

> > This one happens on ILK and BYT. Looks like it happens 100% of the time=
 on driver load:
> > [   18.809850] ------------[ cut here ]------------
> > [   18.809866] WARNING: CPU: 0 PID: 39 at sound/hda/hdac_i915.c:129 pin=
2port+0x25/0x30 [snd_hda_core]()
> =

> This is bad.  Basically we had a naive assumption of the fixed mapping
> between the port number and the HD-audio widget, but it doesn't apply
> properly to pre-HSW models.
> =

> The patch attached below disables the audio binding for pre-HSW
> models.  I'm going to queue to for-linus branch.

That seems to eliminate the warn on my ILK.
Tested-by: Ville Syrj=E4l=E4 <ville.syrjala@linux.intel.com>

But now I got a lockdep spew when I enabled the HDMI video output [1]

And sure enough mplayer got stuck in the kernel when I tried to use
the HDMI audio device [2]

[1]
[ 1939.476458] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[ 1939.476460] [ INFO: possible recursive locking detected ]
[ 1939.476463] 4.5.0-vga+ #13 Not tainted
[ 1939.476464] ---------------------------------------------
[ 1939.476466] kworker/2:2/1016 is trying to acquire lock:
[ 1939.476469]  (&spec->pcm_lock){+.+...}, at: [<ffffffffa020b868>] hdmi_pr=
esent_sense+0x38/0x300 [snd_hda_codec_hdmi]
[ 1939.476480] =

               but task is already holding lock:
[ 1939.476482]  (&spec->pcm_lock){+.+...}, at: [<ffffffffa020b868>] hdmi_pr=
esent_sense+0x38/0x300 [snd_hda_codec_hdmi]
[ 1939.476489] =

               other info that might help us debug this:
[ 1939.476491]  Possible unsafe locking scenario:

[ 1939.476493]        CPU0
[ 1939.476495]        ----
[ 1939.476496]   lock(&spec->pcm_lock);
[ 1939.476499]   lock(&spec->pcm_lock);
[ 1939.476502] =

                *** DEADLOCK ***

[ 1939.476504]  May be due to missing lock nesting notation

[ 1939.476507] 3 locks held by kworker/2:2/1016:
[ 1939.476509]  #0:  ("events"){.+.+.+}, at: [<ffffffff81093cc4>] process_o=
ne_work+0x154/0x6b0
[ 1939.476519]  #1:  ((&bus->unsol_work)){+.+...}, at: [<ffffffff81093cc4>]=
 process_one_work+0x154/0x6b0
[ 1939.476525]  #2:  (&spec->pcm_lock){+.+...}, at: [<ffffffffa020b868>] hd=
mi_present_sense+0x38/0x300 [snd_hda_codec_hdmi]
[ 1939.476532] =

               stack backtrace:
[ 1939.476537] CPU: 2 PID: 1016 Comm: kworker/2:2 Not tainted 4.5.0-vga+ #13
[ 1939.476539] Hardware name: Dell Inc. Latitude E5410/03VXMC, BIOS A15 07/=
11/2013
[ 1939.476547] Workqueue: events process_unsol_events [snd_hda_core]
[ 1939.476550]  0000000000000000 ffff8800d63a3960 ffffffff812f2265 ffffffff=
82370e80
[ 1939.476554]  ffffffff82370e80 ffff8800d63a3a28 ffffffff810c1dc5 00000000=
d63a3990
[ 1939.476559]  ffff88000001a6f8 ffff8800d6087400 00009b11dc5f82fc ffff8800=
0001adf8
[ 1939.476564] Call Trace:
[ 1939.476569]  [<ffffffff812f2265>] dump_stack+0x67/0x92
[ 1939.476573]  [<ffffffff810c1dc5>] __lock_acquire+0x1c25/0x1c80
[ 1939.476578]  [<ffffffff8154435e>] ? mutex_unlock+0xe/0x10
[ 1939.476586]  [<ffffffffa01a2fa6>] ? codec_exec_verb+0xa6/0xf0 [snd_hda_c=
odec]
[ 1939.476590]  [<ffffffff810c26f6>] lock_acquire+0xb6/0x210
[ 1939.476594]  [<ffffffffa020b868>] ? hdmi_present_sense+0x38/0x300 [snd_h=
da_codec_hdmi]
[ 1939.476598]  [<ffffffffa020b868>] ? hdmi_present_sense+0x38/0x300 [snd_h=
da_codec_hdmi]
[ 1939.476601]  [<ffffffff81542bf4>] mutex_lock_nested+0x54/0x3b0
[ 1939.476605]  [<ffffffffa020b868>] ? hdmi_present_sense+0x38/0x300 [snd_h=
da_codec_hdmi]
[ 1939.476608]  [<ffffffff810bfe3f>] ? trace_hardirqs_on_caller+0x12f/0x1c0
[ 1939.476611]  [<ffffffff810bd409>] ? __lock_is_held+0x49/0x70
[ 1939.476618]  [<ffffffffa01a5640>] ? hda_call_codec_resume+0x110/0x110 [s=
nd_hda_codec]
[ 1939.476622]  [<ffffffffa020b868>] hdmi_present_sense+0x38/0x300 [snd_hda=
_codec_hdmi]
[ 1939.476627]  [<ffffffff810dc4e6>] ? rcu_read_lock_sched_held+0x86/0x90
[ 1939.476631]  [<ffffffff813cef46>] ? regcache_sync+0x356/0x400
[ 1939.476638]  [<ffffffffa01a5640>] ? hda_call_codec_resume+0x110/0x110 [s=
nd_hda_codec]
[ 1939.476642]  [<ffffffffa020bd6d>] generic_hdmi_resume+0x4d/0x60 [snd_hda=
_codec_hdmi]
[ 1939.476649]  [<ffffffffa01a55ea>] hda_call_codec_resume+0xba/0x110 [snd_=
hda_codec]
[ 1939.476656]  [<ffffffffa01a5675>] hda_codec_runtime_resume+0x35/0x50 [sn=
d_hda_codec]
[ 1939.476660]  [<ffffffff813bc992>] __rpm_callback+0x32/0x70
[ 1939.476667]  [<ffffffffa01a5640>] ? hda_call_codec_resume+0x110/0x110 [s=
nd_hda_codec]
[ 1939.476670]  [<ffffffff813bc9f4>] rpm_callback+0x24/0x80
[ 1939.476677]  [<ffffffffa01a5640>] ? hda_call_codec_resume+0x110/0x110 [s=
nd_hda_codec]
[ 1939.476681]  [<ffffffff813be125>] rpm_resume+0x455/0x820
[ 1939.476684]  [<ffffffff813be530>] __pm_runtime_resume+0x40/0x60
[ 1939.476690]  [<ffffffffa017de62>] snd_hdac_power_up_pm+0x52/0x60 [snd_hd=
a_core]
[ 1939.476694]  [<ffffffffa020b9c3>] hdmi_present_sense+0x193/0x300 [snd_hd=
a_codec_hdmi]
[ 1939.476699]  [<ffffffffa020bba0>] check_presence_and_report+0x70/0x90 [s=
nd_hda_codec_hdmi]
[ 1939.476703]  [<ffffffffa020bcba>] hdmi_unsol_event+0x9a/0xb0 [snd_hda_co=
dec_hdmi]
[ 1939.476705]  [<ffffffff810bd409>] ? __lock_is_held+0x49/0x70
[ 1939.476711]  [<ffffffffa01a2077>] hda_codec_unsol_event+0x17/0x20 [snd_h=
da_codec]
[ 1939.476716]  [<ffffffffa017d178>] process_unsol_events+0x68/0x80 [snd_hd=
a_core]
[ 1939.476719]  [<ffffffff81093d48>] process_one_work+0x1d8/0x6b0
[ 1939.476722]  [<ffffffff81093cc4>] ? process_one_work+0x154/0x6b0
[ 1939.476725]  [<ffffffff81094a4e>] worker_thread+0x4e/0x480
[ 1939.476728]  [<ffffffff81094a00>] ? cancel_delayed_work_sync+0x20/0x20
[ 1939.476732]  [<ffffffff8109a664>] kthread+0xe4/0x100
[ 1939.476736]  [<ffffffff8109a580>] ? kthread_create_on_node+0x200/0x200
[ 1939.476740]  [<ffffffff81546cbf>] ret_from_fork+0x3f/0x70
[ 1939.476743]  [<ffffffff8109a580>] ? kthread_create_on_node+0x200/0x200

[2]
[<ffffffff813bde90>] rpm_resume+0x1c0/0x820
[<ffffffff813be530>] __pm_runtime_resume+0x40/0x60
[<ffffffffa017db83>] snd_hdac_power_up+0x13/0x20 [snd_hda_core]
[<ffffffffa01abf18>] azx_pcm_open+0x1f8/0x470 [snd_hda_codec]
[<ffffffffa00fe17d>] snd_pcm_open_substream+0x4d/0xa0 [snd_pcm]
[<ffffffffa00fe27f>] snd_pcm_open+0xaf/0x220 [snd_pcm]
[<ffffffffa00fe4a4>] snd_pcm_playback_open+0x44/0x70 [snd_pcm]
[<ffffffffa009e453>] snd_open+0xb3/0x180 [snd]
[<ffffffff811b90ff>] chrdev_open+0x9f/0x1c0
[<ffffffff811b1e4f>] do_dentry_open+0x1cf/0x2f0
[<ffffffff811b31db>] vfs_open+0x5b/0x60
[<ffffffff811c39a3>] path_openat+0x1d3/0x1530
[<ffffffff811c5dae>] do_filp_open+0x7e/0xe0
[<ffffffff811b3516>] do_sys_open+0x116/0x1f0
[<ffffffff811b360e>] SyS_open+0x1e/0x20
[<ffffffff81546957>] entry_SYSCALL_64_fastpath+0x12/0x6f
[<ffffffffffffffff>] 0xffffffffffffffff

> =

> > This other one was seen at least on on SKL:
> > [  124.808525] ------------[ cut here ]------------
> > [  124.808545] WARNING: CPU: 3 PID: 173 at sound/hda/hdac_i915.c:91 snd=
_hdac_display_power+0xf1/0x110 [snd_hda_core]()
> =

> This is a different one, and it implies that the unbalanced power
> refcount.  Might be related with the recent fix for the recursive
> regmap deadlock.  I'll try later with a SKL machine here, too.
> =

> Didn't you see this before the recent tree, right?  Some good/bad
> commits would be really helpful...
> =

> =

> thanks,
> =

> Takashi
> =

> -- 8< --
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: hda - Limit i915 HDMI binding only for HSW and lat=
er
> MIME-Version: 1.0
> =

> It turned out that the pre-HSW Intel chips are incompatible with the
> naive assumption we had -- the fixed mapping between the port and the
> HD-audio widget.  This may result in the bad access, as captured by
> the recent patch to add a WARN_ON() for the port mapping check.
> =

> As a quick workaround, disable the i915 audio component binding for
> all pre-Haswell models.
> =

> Reported-by: Ville Syrj=E4l=E4 <ville.syrjala@linux.intel.com>
> Cc: <stable@vger.kernel.org> # v4.5
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/pci/hda/patch_hdmi.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> =

> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
> index 3fc259154c0b..cde9746cda8e 100644
> --- a/sound/pci/hda/patch_hdmi.c
> +++ b/sound/pci/hda/patch_hdmi.c
> @@ -2243,9 +2243,10 @@ static int patch_generic_hdmi(struct hda_codec *co=
dec)
>  	codec->spec =3D spec;
>  	hdmi_array_init(spec, 4);
>  =

> -	/* Try to bind with i915 for any Intel codecs (if not done yet) */
> +	/* Try to bind with i915 for Intel HSW+ codecs (if not done yet) */
>  	if (!codec_has_acomp(codec) &&
> -	    (codec->core.vendor_id >> 16) =3D=3D 0x8086)
> +	    (codec->core.vendor_id >> 16) =3D=3D 0x8086 &&
> +	    is_haswell_plus(codec))
>  		if (!snd_hdac_i915_init(&codec->bus->core))
>  			spec->i915_bound =3D true;
>  =

> -- =

> 2.7.3
> =


-- =

Ville Syrj=E4l=E4
Intel OTC
