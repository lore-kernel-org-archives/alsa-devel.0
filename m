From: Frank.Uepping@t-online.de (FAU)
Subject: snd_pcm_poll_descriptors_revents()
Date: Sat, 20 Jul 2002 11:55:32 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D393393.DB2ACD12@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailout03.sul.t-online.com (mailout03.sul.t-online.com [194.25.134.81])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id LAA09204
	for <alsa-devel@alsa-project.org>; Sat, 20 Jul 2002 11:56:18 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This function has the signature:
"int snd_pcm_poll_descriptors_revents(snd_pcm_t *pcm, struct pollfd *pfds,
unsigned int nfds, unsigned short *revents)"
It takes a nfds parameter which defines the number of elements of pfds for
which revents shall be collected.
But this interface allows only to return the revents of one fd!
Is this a design error or do I have to interpret it differently.

/FAU




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
