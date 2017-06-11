From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/2] ALSA: pcm: probe tracepoint events only
	when parameter is changed
Date: Sun, 11 Jun 2017 23:56:11 +0900
Message-ID: <20170611145613.24929-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id BE8A6266C99
 for <alsa-devel@alsa-project.org>; Sun, 11 Jun 2017 16:56:18 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

This patchset includes a part of my former RFC:
[alsa-devel] [PATCH RFC 00/21] ALSA: pcm: add tracepoints for PCM params operation
http://mailman.alsa-project.org/pipermail/alsa-devel/2017-May/120548.html

The purpose of this patchset is to limit added events of tracepoint
for PCM parameters only when corresponding parameter is actually
changed. Developers get the events without events for unchanged
parameters.

Additionally, this simplifies error handling of PCM parameters processing.
This is intrusive somehow for userspace applications but just for error
path.

Takashi Sakamoto (2):
  ALSA: pcm: return error immediately for parameters handling
  ALSA: pcm: probe events when parameters are changed actually

 sound/core/pcm_native.c | 122 ++++++++++++++++++++++++++----------------------
 1 file changed, 67 insertions(+), 55 deletions(-)

-- 
2.11.0
