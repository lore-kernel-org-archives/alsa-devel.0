From: Ed Sweetman <safemode@speakeasy.net>
Subject: Re: pcm_peak code in aplay
Date: 02 Jun 2002 09:49:51 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1023025791.10826.19.camel@psuedomode>
References: <E17EVWP-0002qi-00@usw-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E17EVWP-0002qi-00@usw-sf-list1.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Ok, this is strange. arecord is not recording anything from the sound
card.  I have done this before with arecord so it's nothing new but now
it's like i'm recording silence, no matter if i'm capturing the mic, or
line in. Capture volume is way up, it doesn't change anything.  

(cvs)
Advanced Linux Sound Architecture Driver Version 0.9.0rc1.
Compiled on May 23 2002 for kernel 2.4.19-pre8-ac5-preempt.

it's a sblive.  i'm using alsamixer to set the capture interface.  Has
something changed with the last few versions of 0.9x in order to
capture?



_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
