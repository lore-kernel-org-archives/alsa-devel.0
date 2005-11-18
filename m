From: Delio Brignoli <dbrignoli@audioscience.com>
Subject: Re: Re: [PATCH] asihpi update
Date: Sat, 19 Nov 2005 01:21:37 +1300
Message-ID: <437DC751.6040900@audioscience.com>
References: <437D1FAE.3000400@audioscience.com>	<s5hy83mp5i1.wl%tiwai@suse.de>	<437DC1ED.6020409@audioscience.com> <s5hr79ep3ih.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hr79ep3ih.wl%tiwai@suse.de>
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


Hello Takashi,

Takashi Iwai wrote:
> OK, my concern was the change of alsa-driver/asihpi/Makefile in your
> last patch.  You added the stuff to generate at compile time there.
> I'm not against at all to process it _manually_ on your side.

The extra rules in the makefile are to be used by us internally to 
prepare dist files (and are only triggered when source files are 
missing) or by customers that want to compile ALSA with bleeding edge 
code from our CVS rep.

I'm not 100% sure about what you mean with "_manually_".
if you mean that: I generate code for an ALSA dist from our CVS, then 
diff, send the patch to alsa-devel. Then it's fine. :)

> Ah, then it might be my fix in alsa-driver tree.
> HW32 must be u32 (equivalent with unsigned int) on linux kernel.
> Using long for 32bit is wrong.

I'll look into this one too.

thanks
--
Delio


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
