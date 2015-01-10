From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: ALSA: hda - Enable mic mute hotkey and LEDs for an
	HP machine
Date: Sat, 10 Jan 2015 12:31:49 +0300
Message-ID: <20150110093149.GA11804@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A73F260694
 for <alsa-devel@alsa-project.org>; Sat, 10 Jan 2015 10:32:07 +0100 (CET)
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
To: david.henningsson@canonical.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello David Henningsson,

The patch 33f4acd3b214: "ALSA: hda - Enable mic mute hotkey and LEDs
for an HP machine" from Jan 7, 2015, leads to the following static
checker warning:

	sound/pci/hda/patch_realtek.c:3551 alc280_fixup_hp_gpio2_mic_hotkey()
	error: don't call input_free_device() after input_unregister_device()

sound/pci/hda/patch_realtek.c
  3545          switch (action) {
  3546          case HDA_FIXUP_ACT_PROBE:
  3547                  spec->init_amp = ALC_INIT_DEFAULT;
  3548                  break;
  3549          case HDA_FIXUP_ACT_FREE:
  3550                  input_unregister_device(spec->kb_dev);
  3551                  input_free_device(spec->kb_dev);

I think this is a double free.

  3552                  spec->kb_dev = NULL;
  3553          }
  3554  #endif
  3555  }

regards,
dan carpenter
