From: Tisserand Patrice <Patrice.Tisserand@ircam.fr>
Subject: Is this a bug?
Date: Mon, 15 Jul 2002 15:57:35 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D32D4CF.13ED6394@ircam.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I wasn't enable to get poll descriptors for a sequencer opened for
output only,
so I checked alsa-lib/seq/seq.c and found on line 320 in function
snd_seq_poll_descriptors:

if ((events & POLLOUT) && space >= 1) {
  assert(seq->streams & SND_SEQ_OPEN_INPUT);
  revents |= POLLOUT|POLLERR;
 }

Shouldn't it read: assert(seq->streams & SND_SEQ_OPEN_OUTPUT); ?

Regards,

--
Patrice Tisserand --- email:mailto:Patrice.Tisserand@ircam.fr
IRCAM 1 place Stravinsky 75004 Paris FRANCE





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
