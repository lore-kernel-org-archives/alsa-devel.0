From: Cezar <cezar@mixandgo.ro>
Subject: symbol _snd_seq_hw_open is not defined inside (null)
Date: Sun, 08 Oct 2006 10:24:28 +0300
Message-ID: <36299.2577408024$1160295353@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Hello,

I am having problems creating alsa midi device in qsampler.
I get the following error:

An error box pops up that says :

New MIDI device
Could not create device
Sorry.

and the qsampler message box says :

New MIDI device lscp_create_midi_device: Error opening ALSA sequencer
(errno=0)
New MIDI device Could not create device. Sorry
ALSA lib seq.c:911:(snd_seq_open_conf) symbol _snd_seq_hw_open is not
defined inside (null)
Error opening ALSA sequencer

I am using Ubuntu Dapper  on a Compaq Presario R3000 amd64 with RME
Multiface II / Cardbus with the default kernel.

Best regards,
Cezar


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
