From: Jeeja KP <jeeja.kp@intel.com>
Subject: Re: [bug report] ASoC: hdac_hdmi: Begin to add support
 for DP Multi-stream audio
Date: Tue, 14 Feb 2017 19:02:05 +0530
Message-ID: <20170214133205.GA25313@kpjeeja-desk>
References: <20170211051123.GA16467@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 71205265142
 for <alsa-devel@alsa-project.org>; Tue, 14 Feb 2017 14:20:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20170211051123.GA16467@mwanda>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Feb 11, 2017 at 08:11:23AM +0300, Dan Carpenter wrote:
> Hello Jeeja KP,
> 
> The patch 754695f9960b: "ASoC: hdac_hdmi: Begin to add support for DP
> Multi-stream audio" from Feb 6, 2017, leads to the following static
> checker warning:
> 
> 	sound/soc/codecs/hdac_hdmi.c:742 hdac_hdmi_set_pin_port_mux()
> 	error: we previously assumed 'pcm->port' could be null (see line 741)
> 
> sound/soc/codecs/hdac_hdmi.c
>    719  static int hdac_hdmi_set_pin_port_mux(struct snd_kcontrol *kcontrol,
>    720                  struct snd_ctl_elem_value *ucontrol)
>    721  {
>    722          int ret;
>    723          struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
>    724          struct snd_soc_dapm_widget *w = snd_soc_dapm_kcontrol_widget(kcontrol);
>    725          struct snd_soc_dapm_context *dapm = w->dapm;
>    726          struct hdac_hdmi_port *port = w->priv;
>    727          struct hdac_ext_device *edev = to_hda_ext_device(dapm->dev);
>    728          struct hdac_hdmi_priv *hdmi = edev->private_data;
>    729          struct hdac_hdmi_pcm *pcm = NULL;
>    730          const char *cvt_name =  e->texts[ucontrol->value.enumerated.item[0]];
>    731  
>    732          ret = snd_soc_dapm_put_enum_double(kcontrol, ucontrol);
>    733          if (ret < 0)
>    734                  return ret;
>    735  
>    736          if (port == NULL)
>    737                  return -EINVAL;
>    738  
>    739          mutex_lock(&hdmi->pin_mutex);
>    740          list_for_each_entry(pcm, &hdmi->pcm_list, head) {
>    741                  if (!pcm->port && pcm->port == port &&
>                              ^^^^^^^^^
> test
> 
>    742                          pcm->port->id == port->id)
>                                 ^^^^^^^^^^^^^
> dereference
> 
>    743                          pcm->port = NULL;
>                                 ^^^^^^^^^^^^^^^^
> Perhaps the NULL test is reversed?
> 
>    744  
>    745                  /*
>    746                   * Jack status is not reported during device probe as the
>    747                   * PCMs are not registered by then. So report it here.
>    748                   */
> 
>

Thanks for Reporting.

This issue is fixed with DP MST patchs that are posted later and which is in
review list.

Regards,
Jeeja
