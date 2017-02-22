From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] ASoC: hdac_hdmi: Add support for multiple
	ports to a PCM
Date: Wed, 22 Feb 2017 22:07:58 +0300
Message-ID: <20170222185651.GA14103@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by alsa0.perex.cz (Postfix) with ESMTP id B5706266E3A
 for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2017 20:08:26 +0100 (CET)
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

The patch e0e5d3e5a53b: "ASoC: hdac_hdmi: Add support for multiple
ports to a PCM" from Feb 7, 2017, leads to the following static
checker warning:

	sound/soc/codecs/hdac_hdmi.c:2011 hdac_hdmi_dev_remove()
	error: potential NULL dereference 'port'.

sound/soc/codecs/hdac_hdmi.c
  1995  static int hdac_hdmi_dev_remove(struct hdac_ext_device *edev)
  1996  {
  1997          struct hdac_hdmi_priv *hdmi = edev->private_data;
  1998          struct hdac_hdmi_pin *pin, *pin_next;
  1999          struct hdac_hdmi_cvt *cvt, *cvt_next;
  2000          struct hdac_hdmi_pcm *pcm, *pcm_next;
  2001          struct hdac_hdmi_port *port;
  2002          int i;
  2003  
  2004          snd_soc_unregister_codec(&edev->hdac.dev);
  2005  
  2006          list_for_each_entry_safe(pcm, pcm_next, &hdmi->pcm_list, head) {
  2007                  pcm->cvt = NULL;
  2008                  if (list_empty(&pcm->port_list))
  2009                          continue;
  2010  
  2011                  list_for_each_entry(port, &pcm->port_list, head)
  2012                          port = NULL;

It's not clear to me what this loop is supposed to do.  To me it looks
like it will Oops every single time without fail.

  2013  
  2014                  list_del(&pcm->head);
  2015                  kfree(pcm);
  2016          }
  2017  
  2018          list_for_each_entry_safe(cvt, cvt_next, &hdmi->cvt_list, head) {
  2019                  list_del(&cvt->head);
  2020                  kfree(cvt->name);
  2021                  kfree(cvt);
  2022          }
  2023  
  2024          list_for_each_entry_safe(pin, pin_next, &hdmi->pin_list, head) {
  2025                  for (i = 0; i < pin->num_ports; i++)
  2026                          pin->ports[i].pin = NULL;
  2027                  kfree(pin->ports);
  2028                  list_del(&pin->head);
  2029                  kfree(pin);
  2030          }
  2031  
  2032          return 0;
  2033  }

regards,
dan carpenter
