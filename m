From: James Tappin <james@xena.uklinux.net>
Subject: Unresolved symbols in midi/seq modules
Date: Sun, 26 May 2002 11:44:07 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205261144.07151.james@xena.uklinux.net>
Reply-To: james@xena.uklinux.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

With this morning's checkout (though I'm not sure when it might nave been 
introduced I haven't done an update for a couple of weeks) I got 
unresolved symbols:

bash-2.05# depmod -ae
depmod: *** Unresolved symbols in 
/lib/modules/2.4.17/kernel/sound/acore/seq/snd-seq-midi.o
depmod:         snd_midi_event_new_R03feb57b
depmod:         snd_midi_event_free_R2e6fd181
depmod:         snd_midi_event_reset_decode_R500a45e4
depmod:         snd_midi_event_encode_R78630f6d
depmod:         snd_midi_event_decode_Rdf2f2bd1

This is after a full fresh checkout, removing the old sound modules and 
rebuilding using:

./cvscompile --with-cards=ice1712 --without-isapnp --with-sequencer
su -c 'make install'

I am running SuSE 7.2 with a kernel.org 2.4.17 kernel configured with 
soundcore enabled and no other sound options. I am using module versions.

TIA for clues/fixes etc.
	James

-- 
James Tappin,               O__      "I forget the punishment for using
james@xena.uklinux.net     --  \/`    Microsoft --- Something lingering
http://www.xena.uklinux.net/          with data loss in it I fancy"  


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
