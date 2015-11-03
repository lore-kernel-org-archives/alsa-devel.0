From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: ASoC: Intel: Skylake: Add support for virtual dsp
	widgets
Date: Tue, 3 Nov 2015 14:42:35 +0300
Message-ID: <20151103114235.GA17955@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id 20A1B260601
 for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2015 12:42:46 +0100 (CET)
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

This is a semi-automatic email about new static checker warnings.

The patch 9a3b9dc636b0: "ASoC: Intel: Skylake: Add support for 
virtual dsp widgets" from Oct 27, 2015, leads to the following Smatch 
complaint:

sound/soc/intel/skylake/skl-topology.c:453 skl_tplg_bind_sinks()
	 error: we previously assumed 'sink' could be null (see line 452)

sound/soc/intel/skylake/skl-topology.c
   451	
   452		if (!sink)
                     ^^^^
New check.  Reversed?

   453			return skl_tplg_bind_sinks(sink, skl, src_mconfig);
                                                   ^^^^
This is dereferenced inside the function.

   454	
   455		return 0;

regards,
dan carpenter
