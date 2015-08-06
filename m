From: Mina Almasry <almasrymina@google.com>
Subject: External plugin question
Date: Thu, 6 Aug 2015 16:57:12 -0700
Message-ID: <CAHS8izPAD8F+UTvXhAtggdYyZW68k_KVhe-Jsmra4WSPaG_eVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f170.google.com (mail-io0-f170.google.com
 [209.85.223.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A1C9260647
 for <alsa-devel@alsa-project.org>; Fri,  7 Aug 2015 01:57:13 +0200 (CEST)
Received: by iodd187 with SMTP id d187so97084861iod.2
 for <alsa-devel@alsa-project.org>; Thu, 06 Aug 2015 16:57:12 -0700 (PDT)
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

transfer(snd_pcm_ioplug_t
<http://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m___i_o_plug.html#ga1038655a4ca74f3aef060282d6df739b>
*io,
const snd_pcm_channel_area_t
<http://www.alsa-project.org/alsa-doc/alsa-lib/structsnd__pcm__channel__area__t.html>
 *areas, snd_pcm_uframes_t
<http://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m.html#gab01fcfe9b97382a8d3f2027c664b8b8a>
 offset, snd_pcm_uframes_t
<http://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m.html#gab01fcfe9b97382a8d3f2027c664b8b8a>
 size)

how do I extract buffer and size from these arguments? Any tips on how I
write my plugin.

(I'm aware of the multi plugin but I don't wont to use that. I want to
write my own and introduce custom logic later.)

Mina
