From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] ASoC: hdac_hdmi: Begin to add support for
 DP Multi-stream audio
Date: Sat, 11 Feb 2017 08:11:23 +0300
Message-ID: <20170211051123.GA16467@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id E0EF72667EE
 for <alsa-devel@alsa-project.org>; Sat, 11 Feb 2017 06:11:37 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: jeeja.kp@intel.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Jeeja KP,

The patch 754695f9960b: "ASoC: hdac_hdmi: Begin to add support for DP
Multi-stream audio" from Feb 6, 2017, leads to the following static
checker warning:

	sound/soc/codecs/hdac_hdmi.c:742 hdac_hdmi_set_pin_port_mux()
	error: we previously assumed 'pcm->port' could be null (see line 741)

sound/soc/codecs/hdac_hdmi.c
   719  static int hdac_hdmi_set_pin_port_mux(struct snd_kcontrol *kcontrol,
   720                  struct snd_ctl_elem_value *ucontrol)
   721  {
   722          int ret;
   723          struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
   724          struct snd_soc_dapm_widget *w = snd_soc_dapm_kcontrol_widget(kcontrol);
   725          struct snd_soc_dapm_context *dapm = w->dapm;
   726          struct hdac_hdmi_port *port = w->priv;
   727          struct hdac_ext_device *edev = to_hda_ext_device(dapm->dev);
   728          struct hdac_hdmi_priv *hdmi = edev->private_data;
   729          struct hdac_hdmi_pcm *pcm = NULL;
   730          const char *cvt_name =  e->texts[ucontrol->value.enumerated.item[0]];
   731  
   732          ret = snd_soc_dapm_put_enum_double(kcontrol, ucontrol);
   733          if (ret < 0)
   734                  return ret;
   735  
   736          if (port == NULL)
   737                  return -EINVAL;
   738  
   739          mutex_lock(&hdmi->pin_mutex);
   740          list_for_each_entry(pcm, &hdmi->pcm_list, head) {
   741                  if (!pcm->port && pcm->port == port &&
                             ^^^^^^^^^
test

   742                          pcm->port->id == port->id)
                                ^^^^^^^^^^^^^
dereference

   743                          pcm->port = NULL;
                                ^^^^^^^^^^^^^^^^
Perhaps the NULL test is reversed?

   744  
   745                  /*
   746                   * Jack status is not reported during device probe as the
   747                   * PCMs are not registered by then. So report it here.
   748                   */


regards,
dan carpenter
