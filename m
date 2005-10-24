From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [noise] The noise problem wrt Audigy 2 ZS
Date: Mon, 24 Oct 2005 00:18:50 -0400
Message-ID: <1130127531.16563.5.camel@mindpipe>
References: <1130080668.10270.3.camel@localhost>
	 <1130084827.11980.12.camel@mindpipe>  <1130112868.10270.11.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-admin@lists.sourceforge.net>
In-Reply-To: <1130112868.10270.11.camel@localhost>
Sender: alsa-user-admin@lists.sourceforge.net
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: pomac@vapor.com
Cc: ALSA user list <alsa-user@lists.sourceforge.net>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Please make sure to cc: the ALSA lists.

On Mon, 2005-10-24 at 02:14 +0200, Ian Kumlien wrote:
> On Sun, 2005-10-23 at 12:27 -0400, Lee Revell wrote:
> > On Sun, 2005-10-23 at 17:17 +0200, Ian Kumlien wrote:
> > > Hi, 
> > > 
> > > I have found a bunch of topics on this now:
> > > Squealing / Buzzing / Static noise with EMU10k1 and Audigy 2 ZS
> > > https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1276
> > 
> > How are you able to access this site at all?  bugtrack.alsa-project.org
> > has been giving me "Connection refused" for days.
> 
> It worked before, both from here and from a friends place... 
> 
> > Can you repost the text of the bug report?
> 
> Someone else did.
> 
> The interesting part of this is that it almost works for a while, if you
> really work at it, you *can* get it to work sometimes. It feels like it
> depends on where in the memory "things" are located, and by things i
> mean either the kernel module or the app itself, i dunno which.
> 
> You can also hear more or less of the actual sound with the noise,
> sometimes you don't hear any of it and sometimes you hear some of it.
> 

Hmm.  You mentioned this bug only occurs on 64 bit machines or with more
than 1GB of memory.  Maybe it can only DMA into the first 1GB of memory
or something.  Try this patch.

--- include/sound/emu10k1.h~	2005-10-11 12:31:42.000000000 -0400
+++ include/sound/emu10k1.h	2005-10-24 00:14:40.000000000 -0400
@@ -48,7 +48,7 @@
 
 /* FIXME? - according to the OSS driver the EMU10K1 needs a 29 bit DMA mask */
 #define EMU10K1_DMA_MASK	0x7fffffffUL	/* 31bit */
-#define AUDIGY_DMA_MASK		0xffffffffUL	/* 32bit */
+#define AUDIGY_DMA_MASK		0x7fffffffUL	/* 32bit */
 
 #define TMEMSIZE        256*1024
 #define TMEMSIZEREG     4




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
