From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: snd_pcm_poll_descriptors_revents()
Date: Sun, 21 Jul 2002 10:34:29 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0207211030310.755-100000@pnote.perex-int.cz>
References: <3D393393.DB2ACD12@t-online.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id KAA25352
	for <alsa-devel@alsa-project.org>; Sun, 21 Jul 2002 10:34:50 +0200
In-Reply-To: <3D393393.DB2ACD12@t-online.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: FAU <Frank.Uepping@t-online.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sat, 20 Jul 2002, FAU wrote:

> This function has the signature:
> "int snd_pcm_poll_descriptors_revents(snd_pcm_t *pcm, struct pollfd *pfds,
> unsigned int nfds, unsigned short *revents)"
> It takes a nfds parameter which defines the number of elements of pfds for
> which revents shall be collected.
> But this interface allows only to return the revents of one fd!
> Is this a design error or do I have to interpret it differently.

I don't understand. Simply pass all pollfd structs returned from 
snd_pcm_poll_descriptors() and poll() to this function to collect one 
result to do a simple check in your application. Note that alsa-lib might 
use (for some reason) multiple file descriptors, but we cannot predict the 
purpose of all descriptors so the snd_pcm_poll_descriptors_revents() 
function returns _ONE_ collected result from all internal file 
descriptors.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
