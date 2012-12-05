From: Shiraz Hashim <shiraz.hashim@st.com>
Subject: [query] codec suspend not called when bias level is
	SND_SOC_BIAS_ON
Date: Wed, 5 Dec 2012 12:38:56 +0530
Message-ID: <20121205070856.GA1017@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog101.obsmtp.com (eu1sys200aog101.obsmtp.com
 [207.126.144.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 44CCC260323
 for <alsa-devel@alsa-project.org>; Wed,  5 Dec 2012 08:18:08 +0100 (CET)
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
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: viresh.kumar@linaro.org, Linux-ALSA <alsa-devel@alsa-project.org>, spear-devel@list.st.com
List-Id: alsa-devel@alsa-project.org

Hi Mark,

I was going through the suspend procedure for soc-core and I could see
that codec suspend is called only when its bias level is SND_SOC_BIAS_OFF.


     if (!codec->suspended && codec->driver->suspend) {
             switch (codec->dapm.bias_level) {
             case SND_SOC_BIAS_STANDBY:
                     /*
                      * If the CODEC is capable of idle
                      * bias off then being in STANDBY
                      * means it's doing something,
                      * otherwise fall through.
                      */
                     if (codec->dapm.idle_bias_off) {
                             dev_dbg(codec->dev,
                                     "idle_bias_off CODEC on over suspend\n");
                             break;
                     }
             case SND_SOC_BIAS_OFF:
                     codec->driver->suspend(codec);
                     codec->suspended = 1;
                     codec->cache_sync = 1;
                     break;
             default:
                     dev_dbg(codec->dev, "CODEC is on over suspend\n");
                     break;
             }
     }

My question is, during on-going audio play when system is put into
suspend, codec->driver->suspend would not be called as its bias level
is still SND_SOC_BIAS_ON, thus not giving a chance to codec to save
its state.

Is my understanding correct ? How to deal with this ?

--
regards
Shiraz
