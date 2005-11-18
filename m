From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: running out of sequencer client numbers
Date: Fri, 18 Nov 2005 12:29:47 +0100
Message-ID: <1132313387.437dbb2bb8ff6@webmail.uni-halle.de>
References: <1132309783.437dad17900ca@webmail.uni-halle.de>
 <s5hzmo2p7dd.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <s5hzmo2p7dd.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

> I think 0..15 should suffice for the static system clients.  More
> should be assigned dynamically and probed in another way.

The dummy and OSS clients numbers (62 and 63) are currently part
of the public API (SND_SEQ_CLIENT_xxx).  However, I don't think
anybody has ever used them.


Regards,
Clemens


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
