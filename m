From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Audigy2 Microphone capture: alsa-driver-1.0.9rc1
	works, alsa-driver-1.0.9rc2 doesn't
Date: Wed, 30 Mar 2005 16:36:19 -0500
Message-ID: <1112218579.18237.17.camel@mindpipe>
References: <20050330213009.41195.qmail@web52901.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050330213009.41195.qmail@web52901.mail.yahoo.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Chris Rankin <rankincj@yahoo.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 2005-03-30 at 22:30 +0100, Chris Rankin wrote:
> I've just compared the results with the alsa-driver-1.0.9rc1 and alsa-driver-1.0.9rc2 tarballs
> with my Audigy2 sound card.
> 
> The summary: I can record via the microphone with rc1, but can't with rc2.
> 
> The command I'm using is:
> 
> $ arecord -d10 -f cd -t wav > test.wav
> 

This is a known problem.  We have isolated it to something committed to
CVS between 3-22 and 3-24 IIRC (check list archive).  I posted the "cvs
diff" output.  We need someone to go though that patch and figure out
which change is responsible.

Lee



-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
