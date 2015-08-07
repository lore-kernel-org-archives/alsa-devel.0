From: Mina Almasry <almasrymina@google.com>
Subject: External plugin question
Date: Thu, 6 Aug 2015 17:02:47 -0700
Message-ID: <CAHS8izNcdWdki1yPOAipvnn9eC1_NkiiyPwO8h9iv7r7toCv9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f182.google.com (mail-io0-f182.google.com
 [209.85.223.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 6BABF260647
 for <alsa-devel@alsa-project.org>; Fri,  7 Aug 2015 02:02:48 +0200 (CEST)
Received: by iodd187 with SMTP id d187so97182963iod.2
 for <alsa-devel@alsa-project.org>; Thu, 06 Aug 2015 17:02:47 -0700 (PDT)
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

I'm new to alsa dev and I'm trying to write a very simple external pcm
plugin. I want my pcm plugin to output sound to multiple slave pcms when
sound is being writei'd to it. So:

snd_pcm_myplugin_writei(pcm, buffer, size) {
  foreach slave pcm {
    snd_pcm_writei(slave_pcm, buffer, size);
  }
}

I'm having trouble implementing this plugin because the external plugin sdk
does not allow me to define the writei function for my plugin, but lets me
define the transfer function which has a very different signature than
writei:

transfer(snd_pcm_ioplug_t *io, const snd_pcm_channel_area_t *areas,
snd_pcm_uframes_t offset, snd_pcm_uframes_t size)

how do I extract buffer and size from these arguments? Any tips on how I
write my plugin.

Mina
