From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: ASoC: dapm: Simplify list creation in
 dapm_dai_get_connected_widgets()
Date: Tue, 4 Aug 2015 20:38:50 +0300
Message-ID: <20150804173850.GA28511@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id BE08D260532
 for <alsa-devel@alsa-project.org>; Tue,  4 Aug 2015 19:39:04 +0200 (CEST)
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

The patch 1ce43acff0c0: "ASoC: dapm: Simplify list creation in
dapm_dai_get_connected_widgets()" from Jul 26, 2015, leads to the
following static checker warning:

	sound/soc/soc-dapm.c:1199 snd_soc_dapm_dai_get_connected_widgets()
	warn: inconsistent returns 'mutex:&card->dapm_mutex'.
	  Locked on:   line 1194
	  Unlocked on: line 1199

sound/soc/soc-dapm.c
  1164  int snd_soc_dapm_dai_get_connected_widgets(struct snd_soc_dai *dai, int stream,
  1165          struct snd_soc_dapm_widget_list **list)
  1166  {
  1167          struct snd_soc_card *card = dai->component->card;
  1168          struct snd_soc_dapm_widget *w;
  1169          LIST_HEAD(widgets);
  1170          int paths;
  1171          int ret;
  1172  
  1173          mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
  1174  
  1175          /*
  1176           * For is_connected_{output,input}_ep fully discover the graph we need
  1177           * to reset the cached number of inputs and outputs.
  1178           */
  1179          list_for_each_entry(w, &card->widgets, list) {
  1180                  w->inputs = -1;
  1181                  w->outputs = -1;
  1182          }
  1183  
  1184          if (stream == SNDRV_PCM_STREAM_PLAYBACK)
  1185                  paths = is_connected_output_ep(dai->playback_widget, &widgets);
  1186          else
  1187                  paths = is_connected_input_ep(dai->capture_widget, &widgets);
  1188  
  1189          /* Drop starting point */
  1190          list_del(widgets.next);
  1191  
  1192          ret = dapm_widget_list_create(list, &widgets);
  1193          if (ret)
  1194                  return ret;
                        ^^^^^^^^^^^
Holding card->dapm_mutex.

  1195  
  1196          trace_snd_soc_dapm_connected(paths, stream);
  1197          mutex_unlock(&card->dapm_mutex);
  1198  
  1199          return paths;
  1200  }

regards,
dan carpenter
