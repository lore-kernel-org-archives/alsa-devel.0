From: Andrei Boros <andrei@srr.ro>
Subject: opti92x-ad1848 and sequencer
Date: Thu, 13 Mar 2003 14:05:09 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E7073F5.2B2E8D2D@srr.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


 Attempting to compile the above driver as recommended with sequencer
support too, I get the following.

gate:~/install/alsa-cvs/alsa-driver# depmod -ae
/lib/modules/2.2.23/misc/snd-opl3-synth.o: unresolved symbol(s)
        snd_seq_instr_find_R8fff548c
        snd_seq_instr_free_use_Rf8a556ca
        snd_midi_channel_free_set_Rcfb054f4
        snd_seq_instr_event_R7bdca607
        snd_seq_instr_list_new_Rb61f0009
        snd_seq_instr_list_free_R192a43fe
        snd_midi_process_event_R789db613
        snd_midi_channel_alloc_set_R7b6f0fa7
        snd_seq_fm_init_Ra759f38d

=A6/CVS    =A6 ./include/modules/                                       =20
=A6        =A6
=A6 .cvsig =A6     1:acore-seq__seq_instr.ver                           =20
=A6        =A6
=A6 .depen =A6     2:acore-seq__seq_instr.ver                           =20
=A6        =A6

This is the only place where I find these . I am lost trying to figure
out where are these...





--=20
ing. Andrei Boros
mailto:andrei@srr.ro / +40-21-303-1870
Centrul pt. Tehnologia Informatiei
Societatea Romana de Radiodifuziune


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
