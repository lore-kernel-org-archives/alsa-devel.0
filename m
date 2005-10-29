From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Linux 2.6.14: Total lockup using aplaymidi
Date: Fri, 28 Oct 2005 21:26:16 -0400
Message-ID: <1130549177.32367.63.camel@mindpipe>
References: <20051028233321.64683.qmail@web52909.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20051028233321.64683.qmail@web52909.mail.yahoo.com>
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

On Sat, 2005-10-29 at 00:33 +0100, Chris Rankin wrote:
> Hi,
> 
> I've just installed Linux 2.6.14-SMP with ALSA 1.0.10rc1 on my UP PIII machine, and I've found
> that:
> 
> $ aplaymidi -p 65:0 <midifile>
> 
> immediately locks my machine up hard. This machine has a "SB-Live! 5.1 Gamer" sound card, and the
> PCM driver seems to be OK. I don't get an Oops on the serial console, and so I'm suspecting a
> dead-lock somewhere. 30 seconds later, the watchdog driver forces a reboot.
> 
> I have also tried this kernel with ALSA 1.0.10rc2 CVS, with exactly the same results.

What was the last version where this worked?

Which soundfont do you have loaded?  Are any other apps using the audio
device at the time?  What does /proc/asound/card0/voices look like?

Try creating a MIDI file with only 8 notes, does that also cause the
lockup?  If this works then try 16, 32 etc until it locks up.

Can the problem be reproduced on a UP kernel?

Lee





-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
