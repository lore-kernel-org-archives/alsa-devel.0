From: "Wang, Xingchao" <xingchao.wang@intel.com>
Subject: Re: [alsa-devel] [PATCH 0/4 V7] Power-well API
 implementation for Haswell
Date: Thu, 25 Jul 2013 06:50:58 +0000
Message-ID: <46B810F6945F7C4788E11DCE57EC489011851B50@SHSMSX104.ccr.corp.intel.com>
References: <46B810F6945F7C4788E11DCE57EC48901184D8BF@SHSMSX104.ccr.corp.intel.com>
	<s5h38rdmyh0.wl%tiwai@suse.de>
	<46B810F6945F7C4788E11DCE57EC48901184DB13@SHSMSX104.ccr.corp.intel.com>
	<s5hwqoplhv4.wl%tiwai@suse.de>
	<46B810F6945F7C4788E11DCE57EC48901184DB3D@SHSMSX104.ccr.corp.intel.com>
	<CA+gsUGTCimKS35XaX7V+aWXtmGBeHS2ftChU5ndzsray5Aipuw@mail.gmail.com>
	<s5hwqopthff.wl%tiwai@suse.de>	<51E6A4B7.7060605@canonical.com>
	<s5hsizdtgg8.wl%tiwai@suse.de>
	<46B810F6945F7C4788E11DCE57EC48901184E3B6@SHSMSX104.ccr.corp.intel.com>
	<20130718064415.GH4550@phenom.ffwll.local>
	<46B810F6945F7C4788E11DCE57EC48901184E58D@SHSMSX104.ccr.corp.intel.com>
	<s5h61w8tdnb.wl%tiwai@suse.de>
	<46B810F6945F7C4788E11DCE57EC489011851134@SHSMSX104.ccr.corp.intel.com>
	<s5h38r4p6fc.wl%tiwai@suse.de>
	<46B810F6945F7C4788E11DCE57EC4890118511BE@SHSMSX104.ccr.corp.intel.com>
	<51EFC143.2090603@canonical.com>	<51EFD337.1060301@intel.com>
	<46B810F6945F7C4788E11DCE57EC4890118513A5@SHSMSX104.ccr.corp.intel.com>
	<s5hd2q8nkfi.wl%tiwai@suse.de>
	<46B810F6945F7C4788E11DCE57EC489011851470@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <46B810F6945F7C4788E11DCE57EC489011851470@SHSMSX104.ccr.corp.intel.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: 'Takashi Iwai' <tiwai@suse.de>
Cc: "'alsa-devel@alsa-project.org'" <alsa-devel@alsa-project.org>, "Girdwood,
	Liam R" <liam.r.girdwood@intel.com>, "'daniel.vetter@ffwll.ch'" <daniel.vetter@ffwll.ch>, "'intel-gfx@lists.freedesktop.org'" <intel-gfx@lists.freedesktop.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, 'David Henningsson' <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

In order to let audio power-save work even with charger connected, two parameters need be modified in userspace pm-utils scripts.
I tested the changes under Ubuntu 13.10 on Harris Beach, no matter charger connected or not, runtime power-saving works and power-well will 
Be released as expected.

Here's my test under Ubuntu 13.04, the changes are:
1) 
/usr/lib/pm-utils/power.d/intel-audio-powersave
case $1 in
    true) audio_powersave 1 ;;
+    false) audio_powersave 10 ;;
-    false) audio_powersave 0 ;;
    help) help;;
    *) exit $NA
esac

Audio will enter power-save mode after 10s inactive period.
2) /usr/lib/pm-utils/power.d/pci_devices

     0x040300) # audio
        echo "Setting Audio device $id to $1"
+       echo "auto" > $dev/power/control
-        echo $1 > $dev/power/control

This keep audio subsystem always on.

This way the user may not let audio subsystem always active, may bring some delay from codec/controllers, or harm some chips.
Do you think we should add an exception for Haswell only or just make it as a common solution for audio subsystem?

Thanks
--xingchao
> -----Original Message-----
> From: Wang, Xingchao
> Sent: Wednesday, July 24, 2013 10:00 PM
> To: Takashi Iwai
> Cc: Wysocki, Rafael J; David Henningsson; Paulo Zanoni; Daniel Vetter;
> daniel.vetter@ffwll.ch; alsa-devel@alsa-project.org;
> intel-gfx@lists.freedesktop.org; Girdwood, Liam R; Jin, Gordon
> Subject: RE: [alsa-devel] [Intel-gfx] [PATCH 0/4 V7] Power-well API
> implementation for Haswell
> 
> 
> 
> > -----Original Message-----
> > From: Takashi Iwai [mailto:tiwai@suse.de]
> > Sent: Wednesday, July 24, 2013 9:43 PM
> > To: Wang, Xingchao
> > Cc: Wysocki, Rafael J; David Henningsson; Paulo Zanoni; Daniel Vetter;
> > daniel.vetter@ffwll.ch; alsa-devel@alsa-project.org;
> > intel-gfx@lists.freedesktop.org; Girdwood, Liam R; Jin, Gordon
> > Subject: Re: [alsa-devel] [Intel-gfx] [PATCH 0/4 V7] Power-well API
> > implementation for Haswell
> >
> > At Wed, 24 Jul 2013 13:30:16 +0000,
> > Wang, Xingchao wrote:
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Wysocki, Rafael J
> > > > Sent: Wednesday, July 24, 2013 9:15 PM
> > > > To: David Henningsson
> > > > Cc: Wang, Xingchao; Takashi Iwai; Paulo Zanoni; Daniel Vetter;
> > > > daniel.vetter@ffwll.ch; alsa-devel@alsa-project.org;
> > > > intel-gfx@lists.freedesktop.org; Girdwood, Liam R; Jin, Gordon
> > > > Subject: Re: [alsa-devel] [Intel-gfx] [PATCH 0/4 V7] Power-well
> > > > API implementation for Haswell
> > > >
> > > > On 7/24/2013 1:57 PM, David Henningsson wrote:
> > > > > On 07/24/2013 01:33 PM, Wang, Xingchao wrote:
> > > > >> Yes, I agree. I'm debugging this issue on Ubuntu, not sure it
> > > > >> happens on other distribution too.
> > > > >> If it's related to Ubuntu, maybe need check Ubuntu power policy.
> > > > >> Does anyone know the Ubuntu power-policy on laptop?
> > > > >> i.e. when charger connected, will Ubuntu make decision to
> > > > >> disable power-save feature for audio subsystem?
> > > > >
> > > > > I'm not a power management expert, but I got a pointer from my
> > > > > team mate to pm-utils:
> > > > >
> > > > > http://cgit.freedesktop.org/pm-utils/tree/pm/power.d/intel-audio
> > > > > -p
> > > > > ower
> > > > > save
> > > > >
> > > > >
> > > > > If I understand correctly, The scripts in power.d are executed
> > > > > when battery / AC-power is changed.
> > > > >
> > > >
> > > > To me, this sounds like a user space issue.  It requested power on
> > > > and the kernel delivered.
> > >
> > > Do you know which user-space application will touch below two flags?
> > > - /sys/devices/pci0000\:00/0000\:00\:03.0/power/control
> > > - /sys/module/snd_hda_intel/parameters/power_save
> >
> > The latter is touched most likely by pm-utils, one of the hooks, as David
> pointed.
> 
> Oh yes I found the hook:
> ./pm/power.d/intel-audio-powersave
> 
> --xingchao
> > The former is unknown, but better to check pm-utils hooks and udev rules.
> >
> >
> > Takashi
