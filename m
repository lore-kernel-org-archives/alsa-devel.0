From: Vishal Thanki <vishalthanki@gmail.com>
Subject: [PATCH 0/1] Handling of serializers
Date: Tue, 27 Feb 2018 15:51:03 +0100
Message-ID: <20180227145104.5868-1-vishalthanki@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com [74.125.82.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B293266D7D
 for <alsa-devel@alsa-project.org>; Tue, 27 Feb 2018 15:51:22 +0100 (CET)
Received: by mail-wm0-f42.google.com with SMTP id t74so24749248wme.3
 for <alsa-devel@alsa-project.org>; Tue, 27 Feb 2018 06:51:22 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, peter.ujfalusi@ti.com, christophe.jaillet@wanadoo.fr, elfring@users.sourceforge.net, arvind.yadav.cs@gmail.com
Cc: Vishal Thanki <vishalthanki@gmail.com>
List-Id: alsa-devel@alsa-project.org

On a custom AM33xx based platform, we use 4 channels for audio output (2
* Left/Right) by making use of two TX serializers. The audio input path
only uses 2 channels, hence one RX serializer. If the recording is
started before the playback, the playback cannot make use of all 4
channels because of the imposed max number of channels by recording. And
if playback is started before recording, the hw_params set during
recording stream would disable an active TX serializer which causes
audio distortion. I have tried to fix this unwanted behavior in
following patch. Please comment if this should be done differently.

Vishal Thanki (1):
  ASoC: davinci-mcasp: Only disable inactive serializer

 sound/soc/davinci/davinci-mcasp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.14.3
