From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] ASoC: SOF: topology: use set_get_data in
	process load
Date: Mon, 19 Aug 2019 14:45:35 +0300
Message-ID: <20190819114535.GA24323@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B7E05F800B6
 for <alsa-devel@alsa-project.org>; Mon, 19 Aug 2019 13:45:50 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: jaska.uimonen@intel.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Jaska Uimonen,

The patch cac974a51ebb: "ASoC: SOF: topology: use set_get_data in
process load" from Aug 9, 2019, leads to the following static checker
warning:

	sound/soc/sof/topology.c:1857 sof_process_load()
	warn: 'ipc_data_size' unsigned <= 0

sound/soc/sof/topology.c
  1825  static int sof_process_load(struct snd_soc_component *scomp, int index,
  1826                              struct snd_sof_widget *swidget,
  1827                              struct snd_soc_tplg_dapm_widget *tw,
  1828                              struct sof_ipc_comp_reply *r,
  1829                              int type)
  1830  {
  1831          struct snd_sof_dev *sdev = snd_soc_component_get_drvdata(scomp);
  1832          struct snd_soc_dapm_widget *widget = swidget->widget;
  1833          struct snd_soc_tplg_private *private = &tw->priv;
  1834          struct sof_ipc_comp_process *process = NULL;
  1835          struct sof_widget_data *wdata = NULL;
  1836          size_t ipc_data_size = 0;
                ^^^^^^^^^^^^^^^^^^^^
Unsigned.

  1837          size_t ipc_size;
  1838          int offset = 0;
  1839          int ret = 0;
  1840          int i;
  1841  
  1842          if (type == SOF_COMP_NONE) {
  1843                  dev_err(sdev->dev, "error: invalid process comp type %d\n",
  1844                          type);
  1845                  return -EINVAL;
  1846          }
  1847  
  1848          /* allocate struct for widget control data sizes and types */
  1849          if (widget->num_kcontrols) {
  1850                  wdata = kcalloc(widget->num_kcontrols,
  1851                                  sizeof(*wdata),
  1852                                  GFP_KERNEL);
  1853  
  1854                  if (!wdata)
  1855                          return -ENOMEM;
  1856  
  1857                  /* get possible component controls and get size of all pdata */
  1858                  ipc_data_size = sof_get_control_data(sdev, widget, wdata);
  1859  
  1860                  if (ipc_data_size <= 0) {


The sof_get_control_data() returns negative error codes, but it's also
declared as unsigned.  But the main reason I'm reporting this instead of
fixing it myself (besides laziness) is that I was wondering if it was
really handling zero returns correctly.  Should we really return success
in that situation?

  1861                          ret = ipc_data_size;
  1862                          goto out;
  1863                  }
  1864          }
  1865  

regards,
dan carpenter
