From: Ian W MORRISON <ianwmorrison@gmail.com>
Subject: Re: [PATCH v2] ALSA: x86: Select CONFIG_HDMI_LPE_AUDIO
	as default
Date: Tue, 21 Mar 2017 09:02:25 +1100
Message-ID: <CAFXWsS_AEbkbcNz7d=u7PxH7QgY-RdomkkYmN7wnQ37M7g==4Q@mail.gmail.com>
References: <CAFXWsS9-pEX0pF5=94_VK8xSF6sXC9991zbrnWByYB+++ve59Q@mail.gmail.com>
 <s5h1stsl6oq.wl-tiwai@suse.de>
 <CAFXWsS8-e3c_yB+vmCnwpi8PMXOLexQMmxeQD=j39tXhCqZ4+Q@mail.gmail.com>
 <s5h60j4xrut.wl-tiwai@suse.de>
 <CAFXWsS80cxYnzXSNUnAfWCiW40sjBcTtLKyiQqeSLRtawC8K-Q@mail.gmail.com>
 <s5hshm8w9fa.wl-tiwai@suse.de>
 <CAFXWsS8v9tc+de=OwY+d3mwD2WW3gDB_WR63TpwfJOiXjEMTmw@mail.gmail.com>
 <s5hshm7kf03.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F69D266F51
 for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2017 23:02:26 +0100 (CET)
Received: by mail-wm0-f66.google.com with SMTP id x124so17245474wmf.3
 for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2017 15:02:26 -0700 (PDT)
In-Reply-To: <s5hshm7kf03.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On 21 March 2017 at 04:57, Takashi Iwai <tiwai@suse.de> wrote:

> On Mon, 20 Mar 2017 16:12:01 +0100,
> Ian W MORRISON wrote:
> >
> > On 20 March 2017 at 21:04, Takashi Iwai <tiwai@suse.de> wrote:
> >
> > > On Mon, 20 Mar 2017 10:41:07 +0100,
> > > Ian W MORRISON wrote:
> > > >
> > > > On 20 March 2017 at 19:41, Takashi Iwai <tiwai@suse.de> wrote:
> > > >
> > > > > On Mon, 20 Mar 2017 09:17:30 +0100,
> > > > > Ian W MORRISON wrote:
> > > > > >
> > > > > > Oops ... forgot to copy alsa-devel and Pierre-Louis.
> > > > > >
> > > > > > On 20 March 2017 at 18:59, Takashi Iwai <tiwai@suse.de> wrote:
> > > > > >
> > > > > > > On Mon, 20 Mar 2017 08:42:32 +0100,
> > > > > > > Ian W MORRISON wrote:
> > > > > > > >
> > > > > > > > The upstream kernel builds for distributions such as Ubuntu
> > > which now
> > > > > > > > includes binary packages for v4.11 mainline kernel release
> > > > > candidates are
> > > > > > > > promoted as a way of testing upstream kernels to to confirm
> that
> > > > > upstream
> > > > > > > > has fixed a specific issue (see https://wiki.ubuntu.com/
> > > > > > > > Kernel/MainlineBuilds).
> > > > > > > >
> > > > > > > > Unfortunately the long awaited patch for providing HDMI audio
> > > > > support for
> > > > > > > > Bay Trail and Cherry Trail devices does not include this
> support
> > > > > through
> > > > > > > a
> > > > > > > > module built by default.
> > > > > > > >
> > > > > > > > Through including by default of the two associated CONFIG
> > > settings
> > > > > > > (SND_X86
> > > > > > > > and HDMI_LPE_AUDIO), upstream kernel builds would
> automatically
> > > > > provide
> > > > > > > the
> > > > > > > > much desired HDMI audio support by default.
> > > > > > > >
> > > > > > > > This patch uses a Kconfig 'default' statement to include the
> > > driver
> > > > > as
> > > > > > > > default.
> > > > > > > >
> > > > > > > > Changes in version 2: CONFIG_SND_X86 now a bool and changed
> > > default
> > > > > m to
> > > > > > > > default y
> > > > > > > >
> > > > > > > > Signed-off-by: Ian W Morrison <linuxium@linuxium.com.au>
> > > > > > > > ---
> > > > > > > >  sound/x86/Kconfig | 4 +++-
> > > > > > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > > > > >
> > > > > > > > diff --git a/sound/x86/Kconfig b/sound/x86/Kconfig
> > > > > > > > index 84c8f8fc..cac2270 100644
> > > > > > > > --- a/sound/x86/Kconfig
> > > > > > > > +++ b/sound/x86/Kconfig
> > > > > > > > @@ -1,6 +1,7 @@
> > > > > > > >  menuconfig SND_X86
> > > > > > > > -       tristate "X86 sound devices"
> > > > > > > > +       bool "X86 sound devices"
> > > > > > > >         depends on X86
> > > > > > > > +       default y
> > > > > > >
> > > > > > > This one is OK, but ...
> > > > > > >
> > > > > > > >         ---help---
> > > > > > > >           X86 sound devices that don't fall under SoC or PCI
> > > > > categories
> > > > > > > >
> > > > > > > > @@ -9,6 +10,7 @@ if SND_X86
> > > > > > > >  config HDMI_LPE_AUDIO
> > > > > > > >         tristate "HDMI audio without HDaudio on Intel Atom
> > > platforms"
> > > > > > > >         depends on DRM_I915
> > > > > > > > +       default y
> > > > > > >
> > > > > > > ... this is wrong.  Each driver config itself should be left
> > > > > > > unspecified.
> > > > > > >
> > > > > > > It's distributor's job to choose the right config here.
> > > > > > >
> > > > > > > Actually this goes back to one of my earlier points: A
> distributor
> > > > > doesn't
> > > > > > have to set 'HDMI' as HDMI audio is automatically provided.
> > > > >
> > > > > Provided by who...?
> > > > >
> > > >
> > > >
> > > > I suppose it is provided as a result of the architecture one runs the
> > > > primary Makefile on. With 'uname -m' returning 'x86_64' running 'make
> > > > defconfig' results in 'CONFIG_HDMI=y' being set so
> > > 'drivers/video/Makefile'
> > > > automatically makes 'drivers/video/hdmi.c' and as
> > > > 'arch/x86/configs/x86_64_defconfig' includes 'CONFIG_DRM=y' and
> > > > 'CONFIG_DRM_I915=y' and 'drivers/gpu/drm/i915/Makefile' makes
> > > > 'intel_audio.c'.
> > >
> > > The defconfig stuff supports only the limited device sets that are
> > > supposed to be very common.  Is HDMI_LPE_AUDIO classified really as
> > > such a thing?  I don't know...
> > >
> > >
> > In this instance I'd suggest that HDMI_LPE_AUDIO is common as without it
> > you do not get HDMI audio on all x86_64 devices. However see my comment
> > below.
> >
> >
> > >
> > > > > > This is just an
> > > > > > extension because by setting 'HDMI_LPE_AUDIO' the missing audio
> > > support
> > > > > for
> > > > > > BYT and CHT SoCs is then provided. Therefore, in this albeit
> unusual
> > > > > > instance, I reason is it appropriate to set HDMI_LPE_AUDIO so
> that
> > > audio
> > > > > is
> > > > > > automatically provided regardless of distribution. If a
> distributor
> > > > > didn't
> > > > > > want to allow audio for BYT and CHT SoC based devices running
> their
> > > > > distro
> > > > > > then they could always remove it from their distro specific
> config.
> > > > >
> > > > > It's a wrong approach.  What we're discussing about is just a
> > > > > configuration for a new individual driver, and the same rule
> should be
> > > > > applied to it like others.
> > > > >
> > > > > Check other drivers.  See whether default=y (or =m) is set to
> > > > > CONFIG_E1000E, as a random example.  With your argument, it
> should  be
> > > > > set to y or m as default, since the Ethernet functionality is
> already
> > > > > provided by the network core.
> > > > >
> > > > > In general, we don't set the default values to the driver configs
> > > > > unless there is a VERY specific reason to do so.
> > > > >
> > > > >
> > > > I'm trying to get HDMI audio by default for BYT & CHT SoC but
> currently
> > > > this requires 'CONFIG_HDMI_LPE_AUDIO' set with a value of 'm'. I
> don't
> > > want
> > > > to argue a 'special case' or promote a 'wrong approach' but just get
> HDMI
> > > > audio working so is there another way to achieve this?
> > >
> > > What's wrong with manually setting CONFIG_HDMI_LPE_AUDIO=m or =y?
> > > IOW, do all features on your CHT/BYT machines work without adjusting
> > > manually after defconfig?  If you have to do it in anyway, what makes
> > > it special for HDMI_LPD_AUDIO?
> > >
> > >
> > I've just tested various scenarios using a variety of devices with
> > v4.11-rc3. Having CONFIG_HDMI_LPE_AUDIO set by default is sufficient to
> get
> > audio on BYT/CHT devices over HDMI.
> >
> > For example installing Ubuntu 16.04.2 on a BYT/CHT device, then upgrading
> > the kernel to v4.11-rc3 using the deb-binary from
> http://kernel.ubuntu.com/~
> > kernel-ppa/mainline/v4.11-rc3/ (an example of a current distro which is
> > compiling without setting CONFIG_HDMI_LPE_AUDIO) and there is no audio
> over
> > HDMI. Alternatively downloading v4.11-rc3 source, making defconfig,
> > manually setting CONFIG_HDMI_LPE_AUDIO, compiling and installing the
> > kernel on the BYT/CHT device will give you audio over HDMI.
> >
> > If the BYT/CHT device has other sound cards (e.g accessed via a headphone
> > jack) then audio without setting CONFIG_HDMI_LPE_AUDIO may be possible
> > depending on the codec used and whether it is provided by default in the
> > kernel. So for example a Tronsmart Ara (CHT) device has audio over
> > headphones using the pre-compiled deb-binary above but no audio over
> HDMI.
> > Whereas with a (1st gen) Intel Compute Stick (BYT) device no audio is
> > possible using the pre-compiled deb-binary as the device only has an HDMI
> > port. To get sound you must therefore currently use a self-compiled
> kernel
> > with CONFIG_HDMI_LPE_AUDIO set.
> >
> > Whilst Canonical may set CONFIG_HDMI_LPE_AUDIO to provide audio on
> BYT/CHT
> > devices by when is unknown and there is no guarantee they actually will.
> >
> > This will be similar for all other distros with the worst case scenario
> > that no distributor adds CONFIG_HDMI_LPE_AUDIO to their configs resulting
> > in (arguably) little point including HDMI LPE audio support in the
> kernel.
> >
> > I've laboured the point about 'BYT/CHT devices audio over HDMI' but to
> > answer your question completely there are other BYT/CHT devices
> (typically
> > tablets) that need a whole other bunch of patches to fix this and that.
> > They may need specialist kernel configs with specific settings but that
> is
> > a separate issue to the basic functional need of having audio over HDMI.
> >
> > Does the above explanation justify my current approach or is there an
> > alternative that can be considered?
>
> Sorry, no, you've explained how much you love the HDMI audio, but it
> doesn't answer my question clearly.
>

Whatever love there was is diminishing rapidly!

Let me set the context: the range of BYT/CHT devices sold as HDMI sticks or
HDMI boxes which are designed to connect to an HDMI output device (TV or
monitor) and typically have Windows installed as the OS and are used
primarily as media PCs, HTPCs or as 'mini' PCs. They become essentially
useless for their designated purpose when installed with a mainstream Linux
based OS such as Ubuntu at the moment because there is no audio over HDMI.


>
> My question is simple: are *all* features the upstream kernel supports
> for your device now (e.g. input, network or whatever) enabled by the
> pure arch/x86/configs/x86_64_defconfig *without* manually setting the
> configs to y or m?  I bet you likely have to set some configs there
> manually to m or y.
>
>
No. CONFIG_HDMI_LPE_AUDIO is the only config that needs to be manually set
to get *all* features from the upstream kernel.


> Then, if the manual selection for such missing configs is acceptable,
> what makes the HDMI audio so special and it must be set to y/m as
> default, while other devices aren't set like that...?  That's the
> question.
>
>
>
The requested patch sets CONFIG_HDMI_LPE_AUDIO so mainstream Linux distro
kernels would automatically provide the new kernel feature of HDMI LPE
audio support.


> thanks,
>
> Takashi
>
