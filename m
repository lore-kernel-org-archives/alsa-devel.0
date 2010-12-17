From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: question on static dapm routes
Date: Fri, 17 Dec 2010 13:56:36 +0530
Message-ID: <98769532B4BB14429434178695419EAE053B898E04@bgsmsx501.gar.corp.intel.com>
References: <w3pr5dhgij9.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 760AD10388D
	for <alsa-devel@alsa-project.org>; Fri, 17 Dec 2010 09:28:01 +0100 (CET)
In-Reply-To: <w3pr5dhgij9.wl%kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "Koul, Vinod" <vinod.koul@intel.com>, Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

In the codec file which we are trying to write, we do not have any dynamic 
Switching paths. So for the structure snd_soc_dapm_route, its always
		{sink, NULL, source}.
The DAPM widgets are getting enabled at the codec probe
(as we saw that they are getting declared as static) . So this consumes 
power and we want them do be turned on only when DAI is started?

So, does that mean that for every stream, we make use of the startup and 
shutdown functions to do our power management of the widgets. Or is there a 
way ASOC automatically takes care of powering of the static paths as well?

Thanks,
Harsha
