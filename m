From: Elie Morisse <lachienne@wanadoo.fr>
Subject: Serious issue : some MIDI module lockup when Wine is
	launched
Date: Sun, 03 Dec 2006 18:31:09 +0400
Message-ID: <1165156269l.10956l.0l@zerox>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>, "alsa-user@lists.sourceforge.net" <alsa-user@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

I just FINALLY found out the problem preventing me to use Wine since 4 months !
One of those modules : snd_seq_midi, snd_seq_oss, snd_seq_midi_event and snd_seq lockup the system immediately after Wine is launched ( even "wineprefixcreate" ). No lockup if I remove the modules before launching Wine..

I'm on Gentoo, but some Ubuntu fellas experienced this problem as well :
http://ubuntuforums.org/showthread.php?t=280155
http://ubuntuforums.org/showthread.php?t=195409


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
