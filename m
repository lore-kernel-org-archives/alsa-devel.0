From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: ASoC: davinci-mcasp: Set rule constraints if
 implicit BCLK divider is used
Date: Fri, 27 Mar 2015 09:20:08 +0300
Message-ID: <20150327062008.GA11983@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by alsa0.perex.cz (Postfix) with ESMTP id CA3B12606A7
 for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2015 07:20:23 +0100 (CET)
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
To: jsarha@ti.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Jyri Sarha,

The patch a75a053f1eef: "ASoC: davinci-mcasp: Set rule constraints if
implicit BCLK divider is used" from Mar 20, 2015, leads to the
following Smatch warning:

	sound/soc/davinci/davinci-mcasp.c:1152 davinci_mcasp_startup()
	error: buffer overflow 'mcasp->ruledata' 2 <= 2

sound/soc/davinci/davinci-mcasp.c
  1138  
  1139          /*
  1140           * Limit the maximum allowed channels for the first stream:
  1141           * number of serializers for the direction * tdm slots per serializer
  1142           */
  1143          if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
  1144                  dir = TX_MODE;
  1145          else
  1146                  dir = RX_MODE;

dir is either 1 or 2.

  1147  
  1148          for (i = 0; i < mcasp->num_serializer; i++) {
  1149                  if (mcasp->serial_dir[i] == dir)
  1150                          max_channels++;
  1151          }
  1152          mcasp->ruledata[dir].serializers = max_channels;
                       ^^^^^^^^^^^^^
->ruledata[] has only two elements so ->ruledata[2] is beyond the end of
the array.

  1153          max_channels *= mcasp->tdm_slots;

regards,
dan carpenter
