From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: ASoC: Intel: mrfld: add DSP core controls
Date: Mon, 3 Nov 2014 11:15:23 +0530
Message-ID: <20141103054523.GM28745@intel.com>
References: <20141029151457.GA29163@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id B42D0260470
 for <alsa-devel@alsa-project.org>; Mon,  3 Nov 2014 07:27:21 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20141029151457.GA29163@mwanda>
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

On Wed, Oct 29, 2014 at 06:14:57PM +0300, Dan Carpenter wrote:
> Hello Vinod Koul,
> 
> The patch 24c8d14192cc: "ASoC: Intel: mrfld: add DSP core controls"
> from Oct 15, 2014, leads to the following static checker warning:
> 
> 	sound/soc/intel/sst-atom-controls.c:1354 sst_map_modules_to_pipe()
> 	warn: variable dereferenced before check 'platform' (see line 1353)
> 
> sound/soc/intel/sst-atom-controls.c
>   1348  static int sst_map_modules_to_pipe(struct snd_soc_platform *platform)
>   1349  {
>   1350          struct snd_soc_dapm_widget *w;
>   1351          int ret = 0;
>   1352  
>   1353          list_for_each_entry(w, &platform->component.card->widgets, list) {
>                                         ^^^^^^^^
> New dereference.
> 
>   1354                  if (platform && is_sst_dapm_widget(w) && (w->priv)) {
>                             ^^^^^^^^
> New check.
Thanks Dan,

This check is not required as the only user of this function does feref
'platfomr' before calling so we cna remove this. I will send a patch.

Thanks for reporting

-- 
~Vinod

> 
>   1355                          struct sst_ids *ids = w->priv;
>   1356  
>   1357                          dev_dbg(platform->dev, "widget type=%d name=%s\n",
>   1358                                          w->id, w->name);
>   1359                          INIT_LIST_HEAD(&ids->algo_list);
>   1360                          INIT_LIST_HEAD(&ids->gain_list);
>   1361                          ret = sst_fill_widget_module_info(w, platform);
>   1362  
>   1363                          if (ret < 0)
>   1364                                  return ret;
>   1365  
>   1366                          /* fill linked widgets */
>   1367                          if (ids->parent_wname !=  NULL)
>   1368                                  sst_fill_linked_widgets(platform, ids);
>   1369                  }
>   1370          }
>   1371          return 0;
>   1372  }
> 
> regards,
> dan carpenter

-- 
