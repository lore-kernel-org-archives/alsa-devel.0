From: Lee Revell <rlrevell@joe-job.com>
Subject: Stack usage
Date: Mon, 21 Mar 2005 22:34:01 -0500
Message-ID: <1111462442.3058.4.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Andrew Morton made an interesting post on LKML recently and mentioned
that with 4K stacks, 512 bytes is excessive in his opinion.

I ran make checkstack on my 2.6.12-rc1 tree and found some possible ALSA
offenders:

0x0000b186 snd_emu10k1_add_controls:                    588
0x0000b3e2 snd_emu10k1_add_controls:                    588
0x0536 snd_seq_midisynth_register_port:                 564
0x0933 snd_seq_midisynth_register_port:                 564
0x00001af3 snd_iprintf:                                 540
0x00005bd3 snd_verbose_printk:                          540
0x0743 snd_virmidi_dev_attach_seq:                      464
0x00001c33 snd_mixer_oss_build_input:                   464
0x0186 snd_seq_system_client_init:                      436
0x0319 snd_seq_system_client_init:                      436
0x00003bf6 snd_ctl_card_info:                           396
0x00003d30 snd_ctl_card_info:                           396
0x00003ef6 snd_pcm_oss_proc_write:                      376
0x000042fc snd_pcm_oss_proc_write:                      376
0x0000af26 snd_emu10k1_verify_controls:                 368
0x0000b085 snd_emu10k1_verify_controls:                 368
0x0000b586 snd_emu10k1_list_controls:                   316
0x0000b616 snd_emu10k1_list_controls:                   316
0x00001c63 snd_pcm_info_user:                           308
0x000002e4 snd_pcm_proc_info_read:                      300
0x00000431 snd_pcm_proc_info_read:                      300
0x00004113 snd_ctl_elem_info_user:                      296
0x00000e13 snd_rawmidi_info_user:                       288
0x00004c43 snd_ctl_elem_add_user:                       288
0x00001ab6 snd_mixer_oss_build_test:                    284
0x00001b5a snd_mixer_oss_build_test:                    284
0x00000f26 snd_rawmidi_info_select_user:                284
0x00000fb3 snd_rawmidi_info_select_user:                284
0x000026b6 snd_timer_user_ginfo:                        268
0x00002882 snd_timer_user_ginfo:                        268

It looks like snd_emu10k1_add_controls is not too hard to fix, but maybe
I am missing something.

Any interest in addressing this?

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
