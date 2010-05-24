From: Stuart Longland <redhatter@gentoo.org>
Subject: ASoC: Hooking a TI CODEC to a i.MX27 MCU
Date: Mon, 24 May 2010 17:49:46 +1000
Message-ID: <20100524074946.GC16346@www.longlandclan.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from helicon.mas.viperplatform.net.au
	(helicon.mas.viperplatform.net.au [202.147.75.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 170292452E
	for <alsa-devel@alsa-project.org>;
	Mon, 24 May 2010 09:49:53 +0200 (CEST)
Received: from eryx.mas.viperplatform.net.au ([172.16.5.11])
	by helicon.mas.viperplatform.net.au with esmtp (Exim 4.43)
	id 1OGSQ1-0003Bc-7o
	for alsa-devel@alsa-project.org; Mon, 24 May 2010 17:49:49 +1000
Received: from mail by eryx.mas.viperplatform.net.au with spam-scanned (Exim
	4.43) id 1OGSQ0-0005af-SK
	for alsa-devel@alsa-project.org; Mon, 24 May 2010 17:49:49 +1000
Received: from [172.16.100.13] (helo=helicon.mas.viperplatform.net.au)
	by eryx.mas.viperplatform.net.au with esmtp (Exim 4.43)
	id 1OGSQ0-0005ac-RJ
	for alsa-devel@alsa-project.org; Mon, 24 May 2010 17:49:48 +1000
Received: from [203.94.56.252] (helo=longlandclan.yi.org)
	by helicon.mas.viperplatform.net.au with esmtp (Exim 4.43)
	id 1OGSPz-0003B0-Vv
	for alsa-devel@alsa-project.org; Mon, 24 May 2010 17:49:48 +1000
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi all,

I'm trying to write a new machine driver and CODEC driver for a device
we're building, and as yet, haven't figured out the magic that gets ALSA
to enumerate all the devices on the board.  I hope to be able to release
any code here back to the community, but I probably need to clear it
with a few people first (and it'd be nice to contribute _working_ code).

Scenario:
	MCU is a Freescale i.MX27 processor on a Ka-Ro TX27 module
	CODEC is a Texas Instruments TLV320AIC3204, control via I=B2C,
	data via I=B2S.  Chip ID for this CODEC is locked at 0x18.
	Kernel is 2.6.34, userland is Gentoo/ARM via root-over-NFS.

	My goal: Just to get audio being transmitted along the I=B2S bus.
	(Don't care about mixers, etc.)

So far my only means of debugging everything is to sprinkle the code
liberally with printk's everywhere... crude, but it gives me some idea
what's going on.

The CODEC driver is at this moment, an empty shell based on the
TLV320AIC3x driver already in the tree.  I've tried basing a machine
driver on the rx51 driver -- substituting the TLV320AIC3x driver for my
own shell driver, and swapping the original cpu_dai configuration for
the i.MX driver.  I suspect this machine driver is giving me grief.

My machine code setup is as follows:
/* Digital audio interface glue - connects codec <--> CPU */
static struct snd_soc_dai_link jem3_dai[] =3D {
        {
                .name =3D "TLV320AIC3204",
                .stream_name =3D "AIC3204",
                .cpu_dai =3D &imx_ssi_pcm_dai[0],
                .codec_dai =3D &aic3204_dai,
                .init =3D jem3_aic3204_init,
                .ops =3D &jem3_ops,
        },
};

/* Audio private data */
static struct aic3204_setup_data jem3_aic3204_setup =3D {
        .gpio_func[0] =3D AIC3204_GPIO1_FUNC_DISABLED,
        .gpio_func[1] =3D AIC3204_GPIO2_FUNC_DIGITAL_MIC_INPUT,
};

/* Audio card */
static struct snd_soc_card jem3_sound_card =3D {
        .name =3D "JEM3",
        .dai_link =3D jem3_dai,
        .num_links =3D ARRAY_SIZE(jem3_dai),
        .platform =3D &imx_soc_platform,
};

/* Audio subsystem */
static struct snd_soc_device jem3_snd_devdata =3D {
        .card =3D &jem3_sound_card,
        .codec_dev =3D &soc_codec_dev_aic3204,
        .codec_data =3D &jem3_aic3204_setup,
};

static struct platform_device *jem3_snd_device;

static int __init jem3_soc_init(void)
{
        int err;
        printk( KERN_INFO "%s: hello...\n", __FUNCTION__ );

        jem3_snd_device =3D platform_device_alloc("soc-audio", -1);
        printk( KERN_INFO "%s: jem3_snd_device =3D %p\n", =

                        __FUNCTION__, jem3_snd_device );
        if (!jem3_snd_device) {
                err =3D -ENOMEM;
                goto err1;
        }

        printk( KERN_INFO "%s: calling platform_set_drvdata( %p, %p
)\n",
                __FUNCTION__, jem3_snd_device, &jem3_snd_devdata );
        platform_set_drvdata(jem3_snd_device, &jem3_snd_devdata);
        jem3_snd_devdata.dev =3D &jem3_snd_device->dev;

        printk( KERN_INFO "%s: calling platform_device_add(%p)\n",
                __FUNCTION__, jem3_snd_device );
        err =3D platform_device_add(jem3_snd_device);
        printk( KERN_INFO "%s: platform_device_add(%p) =3D %d\n",
                __FUNCTION__, jem3_snd_device, err );
        if (err)
                goto err2;

        printk( KERN_INFO "%s =3D 0 (success)\n", __FUNCTION__ );
        return 0;
err2:
        platform_device_put(jem3_snd_device);
err1:
        printk( KERN_INFO "%s =3D %d\n", __FUNCTION__, err );
        return err;
}

Now this compiles... but when I go to load it; one of two things
happens... either practically nothing (at this stage; no modules are
loaded prior to calling modprobe):

192 / # modprobe snd-soc-jem3
aic3204_i2c_init: adding driver at bf068f9c
aic3204_i2c_init: i2c_add_driver(bf068f9c) =3D 0
jem3_soc_init: hello...
jem3_soc_init: jem3_snd_device =3D c3c600a0
jem3_soc_init: calling platform_set_drvdata( c3c600a0, bf07a780 )
jem3_soc_init: calling platform_device_add(c3c600a0)
jem3_soc_init: platform_device_add(c3c600a0) =3D 0
jem3_soc_init =3D 0 (success)
192 / # mount /proc
192 / # cat /proc/asound/cards =

--- no soundcards ---

... Or it goes kaboom... particularly if I rmmod the snd-soc-jem3
module, but leave snd-soc-tlv320aic3204 in place...

192 / # rmmod snd-soc-jem3
jem3_soc_exit: unregistering...
jem3_soc_exit: goodbye
192 / # modprobe snd-soc-jem3
jem3_soc_init: hello...
jem3_soc_init: jem3_snd_device =3D c3c600a0
jem3_soc_init: calling platform_set_drvdata( c3c600a0, bf080780 )
jem3_soc_init: calling platform_device_add(c3c600a0)
Unable to handle kernel NULL pointer dereference at virtual address
00000008
pgd =3D c3e44000
[00000008] *pgd=3Da3e62031, *pte=3D00000000, *ppte=3D00000000
Internal error: Oops: 17 [#1] PREEMPT
last sysfs file: =

Modules linked in: snd_soc_jem3(+) snd_soc_imx snd_soc_tlv320aic3204
snd_soc_core snd_pcm snd_timer snd soundcore snd_page_alloc ac97_bus
[last =

unloaded: snd_soc_jem3]
CPU: 0    Not tainted  (2.6.34-jacques-jem3 #16)
PC is at snd_soc_instantiate_cards+0x2c/0x7b4 [snd_soc_core]
LR is at 0x0
pc : [<bf0513d8>]    lr : [<00000000>]    psr: 20000013
sp : c3e33db0  ip : bf05906c  fp : bf059074
r10: 00000001  r9 : bf058fd0  r8 : 00000000
r7 : bf07a790  r6 : c3c600a8  r5 : bf072960  r4 : bf059074
r3 : 00000000  r2 : 00000000  r1 : bf072960  r0 : bf059074
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 0005317f  Table: a3e44000  DAC: 00000015
Process modprobe (pid: 278, stack limit =3D 0xc3e32270)
Stack: (0xc3e33db0 to 0xc3e34000)
3da0:                                     c3e33dec 00000001 c3c600a8 000000=
00
3dc0: bf0687c8 00000000 c034f1c8 00000000 c3e32000 c0167c18 c02eee78 c3e33e=
34
3de0: c3e33e6c c3c0e7a8 00000000 c0275b24 c3c15040 c003a008 c3c15040 000000=
d0
3e00: c02e2fbc c3e32000 c3eae9c8 c3e85428 c3e33e34 00000008 c034f1dc c3eafa=
c0
3e20: c3eafac0 c3e85428 c3eae9c8 c00f2674 00000000 0000072d c3e33e60 c3eae9=
c8
3e40: c3e85428 c00f2724 c0355190 00000000 c3eae9c8 bf080790 bf080798 c3c600=
a8
3e60: 00000000 c3c600b0 00000000 c033ec88 00000000 bf052ed0 c0355190 c3c600=
a8
3e80: c3e33eb0 bf059020 c0355190 c01ac47c bf059020 c01ab394 c3c600a8 000000=
00
3ea0: c3e33eb0 c3c600a8 c01ab548 c01aa628 c3c044e8 c3e76ad4 c02de99c c3c600=
a8
3ec0: c3c600a8 c3c600dc 00000000 c01ab5f4 c3c600a8 c3c600a8 00000000 c01aa5=
a8
3ee0: 00000000 c01a8c20 bf080870 c3c600b0 c3c600b0 00000000 00000000 c0168c=
18
3f00: c3c600a8 c3c600a8 c3c600a0 00000000 bf083000 c0021b88 00000000 c03457=
8c
3f20: 000192dc c01acaa0 c3c600a8 bf0809ac fffffff4 bf080780 bf083000 bf0830=
90
3f40: 000020f1 bf080864 c3e32000 c0021374 00000000 00000000 00000000 000020=
f1
3f60: bf080864 00021388 000020f1 bf080864 00021388 00000000 c0021b88 c3e320=
00
3f80: 00000000 c006e48c 00000001 00000000 00019738 0000cf60 000190b0 000193=
30
3fa0: 00000080 c00219e0 0000cf60 000190b0 00021388 000020f1 00019370 000193=
70
3fc0: 0000cf60 000190b0 00019330 00000080 00000000 bec39994 00000000 000192=
dc
3fe0: 000192d0 bec39524 0000bc98 4010ab44 60000010 00021388 00ffff00 00ffff=
00
[<bf0513d8>] (snd_soc_instantiate_cards+0x2c/0x7b4 [snd_soc_core]) from
[<bf052ed0>] (soc_probe+0x74/0xb0 [snd_soc_core])
[<bf052ed0>] (soc_probe+0x74/0xb0 [snd_soc_core]) from [<c01ac47c>]
(platform_drv_probe+0x1c/0x24)
[<c01ac47c>] (platform_drv_probe+0x1c/0x24) from [<c01ab394>]
(driver_probe_device+0x88/0x180)
[<c01ab394>] (driver_probe_device+0x88/0x180) from [<c01aa628>]
(bus_for_each_drv+0x60/0x8c)
[<c01aa628>] (bus_for_each_drv+0x60/0x8c) from [<c01ab5f4>]
(device_attach+0x5c/0x74)
[<c01ab5f4>] (device_attach+0x5c/0x74) from [<c01aa5a8>]
(bus_probe_device+0x30/0x50)
[<c01aa5a8>] (bus_probe_device+0x30/0x50) from [<c01a8c20>]
(device_add+0x1f4/0x4c0)
[<c01a8c20>] (device_add+0x1f4/0x4c0) from [<c01acaa0>]
(platform_device_add+0xf0/0x194)
[<c01acaa0>] (platform_device_add+0xf0/0x194) from [<bf083090>]
(jem3_soc_init+0x90/0x110 [snd_soc_jem3])
[<bf083090>] (jem3_soc_init+0x90/0x110 [snd_soc_jem3]) from [<c0021374>]
(do_one_initcall+0x2c/0x1a8)
[<c0021374>] (do_one_initcall+0x2c/0x1a8) from [<c006e48c>]
(sys_init_module+0xc4/0x1f8)
[<c006e48c>] (sys_init_module+0xc4/0x1f8) from [<c00219e0>]
(ret_fast_syscall+0x0/0x2c)
Code: e1530002 0a000021 e597203c e5973010 (e5922008) =

---[ end trace 2b2b9768e2c2da90 ]---

The address mentioned there makes me think there's an uninitialised
pointer to a struct somewhere... but I've never been able to figure out
which one.

If I reboot, and try to make it oops like before by loading the CODEC
driver then machine driver, everything is serine as one would expect:

192 / # modprobe snd-soc-tlv320aic3204
aic3204_i2c_init: adding driver at bf068f9c
aic3204_i2c_init: i2c_add_driver(bf068f9c) =3D 0
192 / # modprobe snd-soc-jem3
jem3_soc_init: hello...
jem3_soc_init: jem3_snd_device =3D c3dbb2a0
jem3_soc_init: calling platform_set_drvdata( c3dbb2a0, bf07a780 )
jem3_soc_init: calling platform_device_add(c3dbb2a0)
jem3_soc_init: platform_device_add(c3dbb2a0) =3D 0
jem3_soc_init =3D 0 (success)

...but very quiet...
192 / # mount /proc
192 / # cat /proc/asound/cards
--- no soundcards ---

Queries:
	- I notice in old drivers, the I=B2C chip address of the CODEC
	  could be passed in via the same means that is used here for
	  GPIO configuration.  How is this done now?  Or how do I tell
	  the kernel to only look at address 0x18?
	- Despite duplicating what I can see being done in other
	  drivers, I still don't see a sound device created.  What am I
	  missing to make an audio device appear?
	- How does one determine what line foo_bar+0x12/0x34 refers to?

As you can tell, I'm a newcomer to kernel hacking, so my appologies if
these have been answered elsewhere... I've spent many days looking and
haven't stumbled upon the answers as yet, hence why I ask here.

Thanks in advance.
Regards,
-- =

Stuart Longland (aka Redhatter, VK4MSL)      .'''.
Gentoo Linux/MIPS Cobalt and Docs Developer  '.'` :
. . . . . . . . . . . . . . . . . . . . . .   .'.'
http://dev.gentoo.org/~redhatter             :.'

I haven't lost my mind...
  ...it's backed up on a tape somewhere.
