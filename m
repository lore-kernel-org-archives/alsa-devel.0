From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [PATCH V2] ASoC: fix hdmi codec driver contest in
 S3
Date: Tue, 26 Mar 2019 05:42:15 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D19527FB1A0@SHSMSX103.ccr.corp.intel.com>
References: <1553235896-8185-1-git-send-email-libin.yang@intel.com>
 <s5hpnqjp9es.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D19527F9BB6@SHSMSX103.ccr.corp.intel.com>
 <s5hh8bvb5ba.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D19527F9D9F@SHSMSX103.ccr.corp.intel.com>
 <s5hbm22psfz.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D19527FAAA5@SHSMSX103.ccr.corp.intel.com>
 <s5h4l7r9shp.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D19527FAE2A@SHSMSX103.ccr.corp.intel.com>
 <s5hbm1z81em.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3660EF801D8
 for <alsa-devel@alsa-project.org>; Tue, 26 Mar 2019 06:42:20 +0100 (CET)
In-Reply-To: <s5hbm1z81em.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

>> >> >> >> >>
>> >> >> >> >> When resume, the sequence is:
>> >> >> >> >>
>> >> >> >> >> hdac_hdmi_runtime_resume()
>> >> >> >> >>   => snd_hdac_display_power()
>> >> >> >> >> hdac_hdmi_xxx_widget_event()
>> >> >> >> >>
>> >> >> >> >> The hdac_hdmi_xxx_widget_event() are based on the power
>> >> >> >> >> being
>> >on.
>> >> >> >> >> Otherwise, the operation on the codec register will fail.
>> >> >> >> >>
>> >> >> >> >> However, in snd_hdac_display_power(), it may sleep because
>> >> >> >> >> of the
>> >> >> >> >> mutex_lock() in display driver. In this case,
>> >> >> >> >> hdac_hdmi_xxx_widget_event() will be called before the
>> >> >> >> >> power is
>> >on.
>> >> >> >> >>
>> >> >> >> >> Let's not operate the registers and wait for the power in
>> >> >> >> >> hdac_hdmi_xxx_widget_event()
>> >> >> >> >>
>> >> >> >> >> Signed-off-by: Libin Yang <libin.yang@intel.com>
>> >> >> >> >
>> >> >> >> >IMO the workaround looks a bit too fragile.  The substantial
>> >> >> >> >problem is the race between codec and DAPM.  Can this be
>> >> >> >> >controlled better, e.g. by defining the proper PM dependency?
>> >> >> >> >I thought we may rearrange the PM topology dynamically.
>> >> >> >>
>> >> >> >> It seems codec and DAPM is OK so far. Codec resume will be
>> >> >> >> called firstly and then DAPM. But in HDMI codec runtime
>> >> >> >> resume, it will call snd_hdac_display_power(). This function
>> >> >> >> will try to get a
>> >mutex_lock.
>> >> >> >> If it fails to get the lock, it will sleep. This will cause
>> >> >> >> dapm event handler to be called before audio power domain in
>> >> >> >> display is on in the HDMI
>> >> >> >driver.
>> >> >> >
>> >> >> >It implies that the calls are racy.  If they have to be called
>> >> >> >in some order, they have to be serialized in a more better way
>> >> >> >than inserting
>> >> >a random delay...
>> >> >>
>> >> >> Yes. The code does seem to be misleading. What do you think of
>> >> >> using something like "wait_for_complete()"? This will be more
>readable.
>> >> >
>> >> >Well, maybe we should create a proper device link for assuring the
>> >> >PM dependency instead?  Then PM core will take care of everything
>> >> >like that ugly stuff.
>> >>
>> >> Thanks for the suggestion. I did some investigation based on your
>> >> suggestion today. Below is the result on my sof platform:
>> >> There are 3 devices we concerned in this case:
>> >> machine_device: this is the device of the machine, its parent is
>> >> pci_device
>> >> hdmi_device: this is the device of the hdmi codec, its parent is
>> >> pci_device
>> >> pci_device: this is the device of the pci
>> >>
>> >> When resume, pci_device will be resumed firstly, and then
>> >> machine_device and hdmi_device.
>> >> When machine_device is resumed, it will schedule a work to call the
>> >> xxx_event(). So the xxx_event() will be run later.
>> >> When hdmi_device is resumed, it will try to turn on display power.
>> >> However, it may sleep if it can't get the mutex_lock.
>> >>
>> >> If hdmi_device sleeps, xxx_event() will be called firstly. However,
>> >> this is wrong, because xxx_event() depends on the display power.
>> >>
>> >> So if we want to make sure machine_device resume is called always
>> >> after hdmi_device resume, we must set hdmi_device being the parent
>> >machine_device.
>> >> This seems a little weird because codecs are different for different
>platforms.
>> >> And what's more, one platform may have several codecs. It's hard to
>> >> say which codec should be the parent.
>> >
>> >Ah, it's an async work.  Then the device link won't work as expected.
>> >(FWIW, you can define the PM dependency and call order via
>> > device_link_add() calls even if they are no device parent/child
>> >relationship.  I thought it would work in this case, but it's
>> >effective only for the direct invocation from the PM callbacks.)
>> >
>> >> There is another solution I can figure out. We can do power on
>> >> display power in each xxx_event() manually. However, this may not
>> >> be a very good
>> >solution.
>> >> There are several xxx_event() functions. So each time power on, the
>> >> display power will be turned on several time.
>> >>
>> >> As we can make sure that display power is turned on already or will
>> >> be turned on very soon in the future. What about we just wait for
>> >> completion of the display power on?
>> >
>> >I don't think that's the overhead, rather it's the right solution.
>> >You just need to assure the runtime PM via wrapping
>> >pm_runtime_get_sync() and the counterpart in each place where you
>> >need the display power in an async code path.
>>
>> OK. I will try to get display power in each xxx_event(). I tried to
>> call
>> pm_runtime_get_sync() in xxx_event() to turn on the display power
>> before. As it's already in the resume process, the runtime PM will not
>> be called again. So it doesn't help.
>
>Isn't it called from an async work?  If yes, it should wait until the runtime
>resume finishes, hence it must be already in the sanely powered up state.
>OTOH, if it's called from the same context as the runtime resume itself, we
>shoot our foot.  Then it must be done differently.

It's async work.

>
>> It seems I have to call
>> snd_hdac_display_power() manually.
>
>Something goes really wrong, then.
>
>Again, if it's the direct PM callback path, managing the PM device order via
>device_link_add() should be the way to go.  If it's an async work context, an
>explicit sync with pm_runtime_get_sync() is needed.

As it's async, we can't use PM device order to manage this sequence.
I tried to use pm_runtime_get_sync() and had a test, but it seems it doesn't
help. xxx_event() setting register will still be called before display power
is turned on.

>
>
>> Another potential issue is
>> if I called snd_hdac_display_power(on) in xxx_event(), I also need
>> call snd_hdac_display_power(off) at the end of xxx_event()?
>> If so, the display power may really be turned off as currently
>> snd_hdac_display_power() doesn't use counter, but itis using "
>> set_bit(idx, &bus->display_power_status)" and " clear_bit(idx,
>> &bus->display_power_status)" to track the power.
>>
>> Let's assume such scenario:
>> Runtime pm turns on display power
>> Xxx_event() turns on the display power
>> Xxx_event() turns off the display power Now display power may be
>> really turned off. But actually we don't want to turn off display
>> power off here. This will be wrong.
>
>If the display power is solely managed by the codec driver, DAPM event
>callback needs to call pm_runtime_get*() / put*() wrt the codec driver, too.
>The usage is ref-counted, so it won't go to the power off until all users are
>gone.
>
>Of course, the above assumes that xxx_event() gets called in an async context.
>
>Please check it again.

Below is my draft patch, which doesn't work with pm_runtime_get_sync(). Is
there anything wrong in my code?

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 5eeb0fe..429a831 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -763,6 +763,8 @@ static int hdac_hdmi_pin_output_widget_event(struct snd_soc_dapm_widget *w,

        switch (event) {
        case SND_SOC_DAPM_PRE_PMU:
+               pm_runtime_get_sync(&hdev->dev);
+               dev_err(&hdev->dev, "in %s %d ylb\n", __func__, __LINE__);
                hdac_hdmi_set_power_state(hdev, port->pin->nid, AC_PWRST_D0);

                /* Enable out path for this pin widget */
@@ -781,6 +783,7 @@ static int hdac_hdmi_pin_output_widget_event(struct snd_soc_dapm_widget *w,
                                AC_VERB_SET_PIN_WIDGET_CONTROL, 0);

                hdac_hdmi_set_power_state(hdev, port->pin->nid, AC_PWRST_D3);
+               pm_runtime_put_sync(&hdev->dev);
                break;

        }
@@ -805,6 +808,8 @@ static int hdac_hdmi_cvt_output_widget_event(struct snd_soc_dapm_widget *w,

        switch (event) {
        case SND_SOC_DAPM_PRE_PMU:
+               pm_runtime_get_sync(&hdev->dev);
+               dev_err(&hdev->dev, "in %s %d ylb\n", __func__, __LINE__);
                hdac_hdmi_set_power_state(hdev, cvt->nid, AC_PWRST_D0);

                /* Enable transmission */
@@ -828,6 +833,7 @@ static int hdac_hdmi_cvt_output_widget_event(struct snd_soc_dapm_widget *w,
                                AC_VERB_SET_STREAM_FORMAT, 0);

                hdac_hdmi_set_power_state(hdev, cvt->nid, AC_PWRST_D3);
+               pm_runtime_put_sync(&hdev->dev);
                break;

        }
@@ -847,7 +853,8 @@ static int hdac_hdmi_pin_mux_widget_event(struct snd_soc_dapm_widget *w,

        if (!kc)
                kc  = w->kcontrols[0];
-
+       pm_runtime_get_sync(&hdev->dev);
+       dev_err(&hdev->dev, "in %s %d ylb\n", __func__, __LINE__);
        mux_idx = dapm_kcontrol_get_value(kc);

        /* set the device if pin is mst_capable */
@@ -858,6 +865,7 @@ static int hdac_hdmi_pin_mux_widget_event(struct snd_soc_dapm_widget *w,
                snd_hdac_codec_write(hdev, port->pin->nid, 0,
                        AC_VERB_SET_CONNECT_SEL, (mux_idx - 1));
        }
+       pm_runtime_put_sync(&hdev->dev);

        return 0;
 }
@@ -1879,7 +1887,7 @@ static int hdmi_codec_resume(struct device *dev)
        struct hdac_device *hdev = dev_to_hdac_dev(dev);
        struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(hdev);
        int ret;
-
+       dev_err(&hdev->dev, "in %s %d ylb\n", __func__, __LINE__);
        ret = pm_runtime_force_resume(dev);
        if (ret < 0)
                return ret;
@@ -2111,6 +2119,7 @@ static int hdac_hdmi_runtime_resume(struct device *dev)
        if (!bus)
                return 0;

+       dev_err(&hdev->dev, "in %s %d ylb 1\n", __func__, __LINE__);
        hlink = snd_hdac_ext_bus_get_link(bus, dev_name(dev));
        if (!hlink) {
                dev_err(dev, "hdac link not found\n");
@@ -2123,7 +2132,7 @@ static int hdac_hdmi_runtime_resume(struct device *dev)

        hdac_hdmi_skl_enable_all_pins(hdev);
        hdac_hdmi_skl_enable_dp12(hdev);
-
+       dev_err(&hdev->dev, "in %s %d ylb 2\n", __func__, __LINE__);
        /* Power up afg */
        snd_hdac_codec_read(hdev, hdev->afg, 0, AC_VERB_SET_POWER_STATE,
                                                        AC_PWRST_D0);
--
2.7.4

And the dmesg is:
[   36.087224] HDMI HDA Codec ehdaudio0D2: in hdmi_codec_resume 1890 ylb
[   36.087230] HDMI HDA Codec ehdaudio0D2: in hdac_hdmi_runtime_resume 2122 ylb 1
[   36.087335] HDMI HDA Codec ehdaudio0D2: in hdac_hdmi_cvt_output_widget_event 812 ylb
[   40.097586] HDMI HDA Codec ehdaudio0D2: in hdac_hdmi_runtime_resume 2135 ylb 2
[   40.097766] HDMI HDA Codec ehdaudio0D2: in hdac_hdmi_pin_output_widget_event 767 ylb
[   45.108632] HDMI HDA Codec ehdaudio0D2: in hdac_hdmi_pin_mux_widget_event 857 ylb

>From the dmesg, hdac_hdmi_cvt_output_widget_event() 
is called between "ylb 1" and "ylb 2" in runtime_resume().
This means xxx_event() registers setting runs before display
power is turned on.

Regards,
Libin

>
>
>thanks,
>
>Takashi
>
>>
>> Regards,
>> Libin
>>
>> >
>> >
>> >thanks,
>> >
>> >Takashi
>> >
>> >>
>> >> Regards,
>> >> Libin
>> >>
>> >> >
>> >> >
>> >> >Takashi
>> >> >
>> >> >>
>> >> >> Regards,
>> >> >> Libin
>> >> >>
>> >> >> >
>> >> >> >
>> >> >> >thanks,
>> >> >> >
>> >> >> >Takashi
>> >> >> >
>> >> >> >>
>> >> >> >> Regards,
>> >> >> >> Libin
>> >> >> >>
>> >> >> >> >
>> >> >> >> >
>> >> >> >> >thanks,
>> >> >> >> >
>> >> >> >> >Takashi
>> >> >> >> >
>> >> >> >> >> ---
>> >> >> >> >>  sound/soc/codecs/hdac_hdmi.c | 36
>> >> >> >> >> ++++++++++++++++++++++++++++++++++++
>> >> >> >> >>  1 file changed, 36 insertions(+)
>> >> >> >> >>
>> >> >> >> >> diff --git a/sound/soc/codecs/hdac_hdmi.c
>> >> >> >> >> b/sound/soc/codecs/hdac_hdmi.c index 5eeb0fe..3c5c122
>> >> >> >> >> 100644
>> >> >> >> >> --- a/sound/soc/codecs/hdac_hdmi.c
>> >> >> >> >> +++ b/sound/soc/codecs/hdac_hdmi.c
>> >> >> >> >> @@ -144,6 +144,7 @@ struct hdac_hdmi_priv {
>> >> >> >> >>  	int num_pin;
>> >> >> >> >>  	int num_cvt;
>> >> >> >> >>  	int num_ports;
>> >> >> >> >> +	int display_power;	/* 0: power off; 1 power on */
>> >> >> >> >>  	struct mutex pin_mutex;
>> >> >> >> >>  	struct hdac_chmap chmap;
>> >> >> >> >>  	struct hdac_hdmi_drv_data *drv_data; @@ -742,12 +743,27
>> >> >@@
>> >> >> >> >static
>> >> >> >> >> void hdac_hdmi_set_amp(struct hdac_device *hdev,
>> >> >> >> >>
>> >> >	AC_VERB_SET_AMP_GAIN_MUTE,
>> >> >> >> >val);  }
>> >> >> >> >>
>> >> >> >> >> +static int wait_for_display_power(struct hdac_hdmi_priv *hdmi)
>{
>> >> >> >> >> +	int i = 0;
>> >> >> >> >> +
>> >> >> >> >> +	/* sleep for totally 80ms ~ 200ms should be enough */
>> >> >> >> >> +	while (i < 40) {
>> >> >> >> >> +		if (!hdmi->display_power)
>> >> >> >> >> +			usleep_range(2000, 5000);
>> >> >> >> >> +		else
>> >> >> >> >> +			return 0;
>> >> >> >> >> +		i++;
>> >> >> >> >> +	}
>> >> >> >> >> +	return -EAGAIN;
>> >> >> >> >> +}
>> >> >> >> >>
>> >> >> >> >>  static int hdac_hdmi_pin_output_widget_event(struct
>> >> >> >> >snd_soc_dapm_widget *w,
>> >> >> >> >>  					struct snd_kcontrol *kc, int
>> >> >event)  {
>> >> >> >> >>  	struct hdac_hdmi_port *port = w->priv;
>> >> >> >> >>  	struct hdac_device *hdev =
>> >> >> >> >> dev_to_hdac_dev(w->dapm->dev);
>> >> >> >> >> +	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(hdev);
>> >> >> >> >>  	struct hdac_hdmi_pcm *pcm;
>> >> >> >> >>
>> >> >> >> >>  	dev_dbg(&hdev->dev, "%s: widget: %s event: %x\n", @@ -
>> >> >757,6
>> >> >> >> >+773,11
>> >> >> >> >> @@ static int hdac_hdmi_pin_output_widget_event(struct
>> >> >> >> >snd_soc_dapm_widget *w,
>> >> >> >> >>  	if (!pcm)
>> >> >> >> >>  		return -EIO;
>> >> >> >> >>
>> >> >> >> >> +	if (wait_for_display_power(hdmi)) {
>> >> >> >> >> +		dev_err(&hdev->dev, "%s: hdmi power is not ready\n",
>> >> >> >> >__func__);
>> >> >> >> >> +		return -EAGAIN;
>> >> >> >> >> +	}
>> >> >> >> >> +
>> >> >> >> >>  	/* set the device if pin is mst_capable */
>> >> >> >> >>  	if (hdac_hdmi_port_select_set(hdev, port) < 0)
>> >> >> >> >>  		return -EIO;
>> >> >> >> >> @@ -803,6 +824,11 @@ static int
>> >> >> >> >hdac_hdmi_cvt_output_widget_event(struct
>snd_soc_dapm_widget
>> >> >> >> >*w,
>> >> >> >> >>  	if (!pcm)
>> >> >> >> >>  		return -EIO;
>> >> >> >> >>
>> >> >> >> >> +	if (wait_for_display_power(hdmi)) {
>> >> >> >> >> +		dev_err(&hdev->dev, "%s: hdmi power is not ready\n",
>> >> >> >> >__func__);
>> >> >> >> >> +		return -EAGAIN;
>> >> >> >> >> +	}
>> >> >> >> >> +
>> >> >> >> >>  	switch (event) {
>> >> >> >> >>  	case SND_SOC_DAPM_PRE_PMU:
>> >> >> >> >>  		hdac_hdmi_set_power_state(hdev, cvt->nid,
>> >> >AC_PWRST_D0);
>> >> >> >> >@@ -840,6
>> >> >> >> >> +866,7 @@ static int hdac_hdmi_pin_mux_widget_event(struct
>> >> >> >> >> snd_soc_dapm_widget *w,  {
>> >> >> >> >>  	struct hdac_hdmi_port *port = w->priv;
>> >> >> >> >>  	struct hdac_device *hdev =
>> >> >> >> >> dev_to_hdac_dev(w->dapm->dev);
>> >> >> >> >> +	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(hdev);
>> >> >> >> >>  	int mux_idx;
>> >> >> >> >>
>> >> >> >> >>  	dev_dbg(&hdev->dev, "%s: widget: %s event: %x\n", @@ -
>> >> >850,6
>> >> >> >> >+877,11
>> >> >> >> >> @@ static int hdac_hdmi_pin_mux_widget_event(struct
>> >> >> >> >> snd_soc_dapm_widget *w,
>> >> >> >> >>
>> >> >> >> >>  	mux_idx = dapm_kcontrol_get_value(kc);
>> >> >> >> >>
>> >> >> >> >> +	if (wait_for_display_power(hdmi)) {
>> >> >> >> >> +		dev_err(&hdev->dev, "%s: hdmi power is not ready\n",
>> >> >> >> >__func__);
>> >> >> >> >> +		return -EAGAIN;
>> >> >> >> >> +	}
>> >> >> >> >> +
>> >> >> >> >>  	/* set the device if pin is mst_capable */
>> >> >> >> >>  	if (hdac_hdmi_port_select_set(hdev, port) < 0)
>> >> >> >> >>  		return -EIO;
>> >> >> >> >> @@ -2068,6 +2100,7 @@ static int
>> >> >> >> >> hdac_hdmi_runtime_suspend(struct device *dev)  {
>> >> >> >> >>  	struct hdac_device *hdev = dev_to_hdac_dev(dev);
>> >> >> >> >>  	struct hdac_bus *bus = hdev->bus;
>> >> >> >> >> +	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(hdev);
>> >> >> >> >>  	struct hdac_ext_link *hlink = NULL;
>> >> >> >> >>
>> >> >> >> >>  	dev_dbg(dev, "Enter: %s\n", __func__); @@ -2095,6
>> >> >> >> >> +2128,7
>> >> >@@
>> >> >> >> >static
>> >> >> >> >> int hdac_hdmi_runtime_suspend(struct device *dev)
>> >> >> >> >>  	snd_hdac_ext_bus_link_put(bus, hlink);
>> >> >> >> >>
>> >> >> >> >>  	snd_hdac_display_power(bus, hdev->addr, false);
>> >> >> >> >> +	hdmi->display_power = 0;
>> >> >> >> >>
>> >> >> >> >>  	return 0;
>> >> >> >> >>  }
>> >> >> >> >> @@ -2102,6 +2136,7 @@ static int
>> >> >> >> >> hdac_hdmi_runtime_suspend(struct device *dev)  static int
>> >> >> >> >> hdac_hdmi_runtime_resume(struct device
>> >> >> >> >> *dev) {
>> >> >> >> >>  	struct hdac_device *hdev = dev_to_hdac_dev(dev);
>> >> >> >> >> +	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(hdev);
>> >> >> >> >>  	struct hdac_bus *bus = hdev->bus;
>> >> >> >> >>  	struct hdac_ext_link *hlink = NULL;
>> >> >> >> >>
>> >> >> >> >> @@ -2128,6 +2163,7 @@ static int
>> >> >hdac_hdmi_runtime_resume(struct
>> >> >> >> >device *dev)
>> >> >> >> >>  	snd_hdac_codec_read(hdev, hdev->afg, 0,
>> >> >> >> >	AC_VERB_SET_POWER_STATE,
>> >> >> >> >>
>> >> >	AC_PWRST_D0);
>> >> >> >> >>
>> >> >> >> >> +	hdmi->display_power = 1;
>> >> >> >> >>  	return 0;
>> >> >> >> >>  }
>> >> >> >> >>  #else
>> >> >> >> >> --
>> >> >> >> >> 2.7.4
>> >> >> >> >>
>> >> >> >> >> _______________________________________________
>> >> >> >> >> Alsa-devel mailing list
>> >> >> >> >> Alsa-devel@alsa-project.org
>> >> >> >> >> https://mailman.alsa-project.org/mailman/listinfo/alsa-dev
>> >> >> >> >> el
>> >> >> >> >>
>> >> >> >>
>> >> >>
>> >>
>>
