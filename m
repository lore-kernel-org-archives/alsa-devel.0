From: "tet" <teteros@teknik.io>
Subject: [alsa-plugins-1.17] Regression in JACK plugin
Date: Tue, 23 Oct 2018 13:19:07 +0000
Message-ID: <be1e30c7b7f493d0235a135964a9a9d3@teknik.io>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.teknik.io (mail.teknik.io [5.79.72.163])
 by alsa0.perex.cz (Postfix) with ESMTP id 392612675C3
 for <alsa-devel@alsa-project.org>; Tue, 23 Oct 2018 15:19:07 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi, after updating to alsa-plugins-1.17 ALSA throws:
"ALSA lib pcm_plug.c:1273:(_snd_pcm_plug_open) Unknown field playback_ports

My ~/.asourdrc is working in 1.16 and it does not look like the syntax changed for the plugin when looking at the readme.

pcm.jack {
  type plug slave.pcm {
    type jack
    capture_ports {
      0 system:capture_1
      1 system:capture_1
    }
    playback_ports {
      0 system:playback_1
      1 system:playback_2
    }
  }
  hint.description "JACK Audio Kit"
}
pcm.!default {
  @func getenv
    vars [ PCM ]
    default jack
}

Any ideas?
