From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: ASoC: Intel: Skylake: Add SKL DSP initialization
Date: Wed, 21 Oct 2015 23:53:48 +0300
Message-ID: <20151021205348.GB9839@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by alsa0.perex.cz (Postfix) with ESMTP id 8DBA02667B1
 for <alsa-devel@alsa-project.org>; Wed, 21 Oct 2015 22:54:01 +0200 (CEST)
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
To: subhransu.s.prusty@intel.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Subhransu S. Prusty,

The patch a750ba5f5a56: "ASoC: Intel: Skylake: Add SKL DSP
initialization" from Jul 10, 2015, leads to the following static
checker warning:

	sound/soc/intel/skylake/skl-sst.c:270 skl_sst_dsp_init()
	info: ignoring unreachable code.

sound/soc/intel/skylake/skl-sst.c
   252          sst->dsp_ops = dsp_ops;
   253          sst->fw_ops = skl_fw_ops;
   254  
   255          ret = skl_ipc_init(dev, skl);
   256          if (ret)
   257                  return ret;
   258  
   259          ret = sst->fw_ops.load_fw(sst);
   260          if (ret < 0) {
   261                  dev_err(dev, "Load base fw failed : %d", ret);
   262                  return ret;

Presumably this should be a "goto free_ipc;" here?

   263          }
   264  
   265          if (dsp)
   266                  *dsp = skl;
   267  
   268          return 0;
   269  
   270          skl_ipc_free(&skl->ipc);
                ^^^^^^^^^^^^^^^^^^^^^^^
Unreachable.

   271          return ret;
   272  }
   273  EXPORT_SYMBOL_GPL(skl_sst_dsp_init);


regards,
dan carpenter
