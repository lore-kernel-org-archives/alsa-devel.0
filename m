From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] ASoC: dapm: Consolidate input and output
	path handling
Date: Tue, 19 Feb 2019 15:13:49 +0300
Message-ID: <20190219121349.GA27492@kadam>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 by alsa0.perex.cz (Postfix) with ESMTP id DD58B265532
 for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2019 13:14:05 +0100 (CET)
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
To: lars@metafoo.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Lars-Peter Clausen,

The patch a3423b02cf74: "ASoC: dapm: Consolidate input and output
path handling" from Aug 11, 2015, leads to the following static
checker warning:

	sound/soc/soc-dapm.c:2831 snd_soc_dapm_add_path()
	error: potential zalloc NULL dereference: 'path->sink'

sound/soc/soc-dapm.c
    2791 
    2792 	path = kzalloc(sizeof(struct snd_soc_dapm_path), GFP_KERNEL);
    2793 	if (!path)
    2794 		return -ENOMEM;
    2795 
    2796 	path->node[SND_SOC_DAPM_DIR_IN] = wsource;
    2797 	path->node[SND_SOC_DAPM_DIR_OUT] = wsink;

We used to say "path->sink = wsink;" here, but now it's NULL from the
kzalloc().


    2798 	widgets[SND_SOC_DAPM_DIR_IN] = wsource;
    2799 	widgets[SND_SOC_DAPM_DIR_OUT] = wsink;
    2800 
    2801 	path->connected = connected;
    2802 	INIT_LIST_HEAD(&path->list);
    2803 	INIT_LIST_HEAD(&path->list_kcontrol);
    2804 
    2805 	if (wsource->is_supply || wsink->is_supply)
    2806 		path->is_supply = 1;
    2807 
    2808 	/* connect static paths */
    2809 	if (control == NULL) {
    2810 		path->connect = 1;
    2811 	} else {
    2812 		switch (wsource->id) {
    2813 		case snd_soc_dapm_demux:
    2814 			ret = dapm_connect_mux(dapm, path, control, wsource);
    2815 			if (ret)
    2816 				goto err;
    2817 			break;
    2818 		default:
    2819 			break;
    2820 		}
    2821 
    2822 		switch (wsink->id) {
    2823 		case snd_soc_dapm_mux:
    2824 			ret = dapm_connect_mux(dapm, path, control, wsink);
    2825 			if (ret != 0)
    2826 				goto err;
    2827 			break;
    2828 		case snd_soc_dapm_switch:
    2829 		case snd_soc_dapm_mixer:
    2830 		case snd_soc_dapm_mixer_named_ctl:
--> 2831 			ret = dapm_connect_mixer(dapm, path, control);
                                                               ^^^^
Dereferenced inside the function.

It's hard to believe that this has been broken for three years, but I
can't see another explanation.  (0)_(0)!!!

    2832 			if (ret != 0)
    2833 				goto err;
    2834 			break;
    2835 		default:
    2836 			break;
    2837 		}
    2838 	}
    2839 
    2840 	list_add(&path->list, &dapm->card->paths);
    2841 	snd_soc_dapm_for_each_direction(dir)

regards,
dan carpenter
