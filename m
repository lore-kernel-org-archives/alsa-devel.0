From: asto <astrotris@googlemail.com>
Subject: ASUS V1Sn can have digout
Date: Fri, 10 Oct 2008 17:20:34 +1030
Message-ID: <825cea7c0810092350yb644a55sec5b26f8dd913561@mail.gmail.com>
Reply-To: astrotris@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.187])
	by alsa0.perex.cz (Postfix) with ESMTP id 51F0E10380B
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Oct 2008 08:50:55 +0200 (CEST)
Received: by ti-out-0910.google.com with SMTP id j3so184430tid.8
	for <alsa-devel@alsa-project.org>; Thu, 09 Oct 2008 23:50:35 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Regarding this change:
http://git.alsa-project.org/?p=alsa-kernel.git;a=commit;h=2522d7359301efadfb5744ebd3c623c3af4a7b30
(Added support for Asus V1Sn)

This card can have digital output, and indeed does in my situation.

The patch above added to patch_realtek.c:
SND_PCI_QUIRK(0x1043, 0x1633, "Asus V1Sn", ALC861VD_LENOVO)

However, ALC861VD_LENOVO definition has no digout

Is it possible to have digital out for this device configured in
auto-probe rather than map to lenovo ?

For now, I add a definition for it based on the lenovo and
3stack-660-digout: to patch_realtek.c

       [ALC660VD_V1S] = {
               .mixers = { alc861vd_3st_mixer },
               .init_verbs = { alc861vd_volume_init_verbs,
                                alc861vd_3stack_init_verbs,
                                alc861vd_eapd_verbs,
                                alc861vd_lenovo_unsol_verbs },
               .num_dacs = ARRAY_SIZE(alc660vd_dac_nids),
               .dac_nids = alc660vd_dac_nids,
               .dig_out_nid = ALC861VD_DIGOUT_NID,
               .num_channel_mode = ARRAY_SIZE(alc861vd_3stack_2ch_modes),
               .channel_mode = alc861vd_3stack_2ch_modes,
               .input_mux = &alc861vd_capture_source,
               .unsol_event = alc861vd_lenovo_unsol_event,
               .init_hook = alc861vd_lenovo_automute,
       },
