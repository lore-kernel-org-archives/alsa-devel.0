From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: proper suspend / resume for PCM streams
Date: Tue, 16 Aug 2005 11:00:14 -0400
Message-ID: <1124204415.25596.1.camel@mindpipe>
References: <Pine.LNX.4.61.0508152139420.9682@tm8103.perex-int.cz>
	 <s5h8xz2xiiz.wl%tiwai@suse.de>
	 <Pine.LNX.4.61.0508161254410.9566@tm8103.perex-int.cz>
	 <s5h64u6xhpc.wl%tiwai@suse.de>
	 <Pine.LNX.4.61.0508161315320.9566@tm8103.perex-int.cz>
	 <s5h4q9qxgw4.wl%tiwai@suse.de>
	 <Pine.LNX.4.61.0508161328050.9566@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mustang.oldcity.dca.net (mustang.oldcity.dca.net [216.158.38.3])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 191E61FD
	for <alsa-devel@alsa-project.org>; Tue, 16 Aug 2005 17:00:17 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.61.0508161328050.9566@tm8103.perex-int.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 2005-08-16 at 13:33 +0200, Jaroslav Kysela wrote:
> Okay, the error code carries the state information, but the point is 
> that the application should do necessary things in this stage like:
> 
> 1) try recovery from resume and continue (standard players)
> 2) stop the stream and tell to the user that he/she is stupid to do
> such things for live performance (for example JACK will do it ;-))
> 
> The point is that the application must decide what to do with this
> state.
> 

I think 2) is broken anyway.  JACK should keep going like any other app.
suspend/resume should just look like an xrun.

I would expect to be able to suspend/resume while using ASIO apps on
Windows.  What if the neighbors complain, so you have to move band
practice to another room quickly?

Lee



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
