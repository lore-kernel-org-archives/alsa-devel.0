From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: memory leaks?
Date: Tue, 29 Mar 2005 15:24:03 -0500
Message-ID: <1112127843.5141.12.camel@mindpipe>
References: <1111896886.2408.1.camel@mindpipe>
	 <s5hpsxiiqls.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hpsxiiqls.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 2005-03-29 at 14:27 +0200, Takashi Iwai wrote:
> Yes.  Could you trace the corresponding addresses?
> (just checking /proc/kallsyms before unloading would help, too).

How exactly would I trace those addresses?

Anyway, it looks to me that the leak is in snd_seq_midi.  Here is the
most recent output.  The first one I'm not sure about, the second seems
to be in snd_seq_midisynth_register_port.

ALSA /home/rlrevell/cvs/alsa/alsa-driver/alsa-kernel/core/memory.c:71: Not freed snd_alloc_kmalloc = 432
ALSA /home/rlrevell/cvs/alsa/alsa-driver/alsa-kernel/core/memory.c:80: kmalloc(164) from e098b806 not freed
ALSA /home/rlrevell/cvs/alsa/alsa-driver/alsa-kernel/core/memory.c:80: kmalloc(268) from e098b6fe not freed

Here are the closest addresses from kallsyms:

00000000 a seq_midi.c   [snd_seq_midi]
e0a37ea0 ? __mod_author43       [snd_seq_midi]
e0a37f00 ? __mod_description44  [snd_seq_midi]
e0a37f44 ? __mod_license45      [snd_seq_midi]
e098d7ec d output_buffer_size   [snd_seq_midi]
e098d7f0 d __param_str_output_buffer_size       [snd_seq_midi]
e098be0c r __param_output_buffer_size   [snd_seq_midi]
e0a37f60 ? __mod_output_buffer_sizetype47       [snd_seq_midi]
e0a37f80 ? __mod_output_buffer_size48   [snd_seq_midi]
e098d804 d input_buffer_size    [snd_seq_midi]
e098d808 d __param_str_input_buffer_size        [snd_seq_midi]
e098be20 r __param_input_buffer_size    [snd_seq_midi]
e0a37fc0 ? __mod_input_buffer_sizetype50        [snd_seq_midi]
e0a37fe0 ? __mod_input_buffer_size51    [snd_seq_midi]
e098d81c d register_mutex       [snd_seq_midi]
e098b000 t snd_midi_input_event [snd_seq_midi]
e098b100 t dump_midi    [snd_seq_midi]
e098b1b0 t event_process_midi   [snd_seq_midi]
e098b2e0 t snd_seq_midisynth_new        [snd_seq_midi]
e098b330 t midisynth_subscribe  [snd_seq_midi]
e098b420 t midisynth_unsubscribe        [snd_seq_midi]
e098b480 t midisynth_use        [snd_seq_midi]
e098b540 t midisynth_unuse      [snd_seq_midi]
e098b5c0 t snd_seq_midisynth_delete     [snd_seq_midi]
e098b610 t set_client_name      [snd_seq_midi]
e098b6a0 t snd_seq_midisynth_register_port      [snd_seq_midi] 
e098bd68 t .text.lock.seq_midi  [snd_seq_midi]
e098d9c0 b synths       [snd_seq_midi]
e098bc80 t snd_seq_midisynth_unregister_port    [snd_seq_midi]
e098d82c d ops.1        [snd_seq_midi]
e08fd000 t alsa_seq_midi_init   [snd_seq_midi]
e098bdf0 t alsa_seq_midi_exit   [snd_seq_midi]

HTH,

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
