From: noman pouigt <variksla@gmail.com>
Subject: compress: dpcm_path_get called in wrong place
Date: Thu, 6 Mar 2014 23:52:56 -0800
Message-ID: <CAES_P+9RrhOGip61Lyb-fq2JgrHZGhifLtoY=LY6_jwbEoJnAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f172.google.com (mail-ob0-f172.google.com
 [209.85.214.172])
 by alsa0.perex.cz (Postfix) with ESMTP id AE0612659A3
 for <alsa-devel@alsa-project.org>; Fri,  7 Mar 2014 08:52:58 +0100 (CET)
Received: by mail-ob0-f172.google.com with SMTP id wm4so3759849obc.3
 for <alsa-devel@alsa-project.org>; Thu, 06 Mar 2014 23:52:56 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@linux.intel.com>, liam.r.girdwood@linux.intel.com, Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Shouldn't  dpcm_path_get be called earlier ? I think it should be
called earlier as happens in soc-pcm file.

static int soc_compr_open_fe(struct snd_compr_stream *cstream)
{

if (dpcm_path_get(fe, stream, &list) <= 0) {
dev_dbg(fe->dev, "ASoC: %s no valid %s route\n",
fe->dai_link->name, stream ? "capture" : "playback");

In current code we open platform driver and then machine startup function
gets called. After this we check for valid path which i think should happen
earlier i.e. in the beginning of soc_compr_open_fe function.

If you agree, then i will send a patch.
