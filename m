From: "Ivica Bukvic" <ico@fuse.net>
Subject: Question regarding the CS4205 driver (used in all current Dell notebooks)
Date: Tue, 30 Apr 2002 00:02:40 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <aault7$55a$2@main.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
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
To: alsa-devel@alsa-project.org, alsa-user@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi all,

I've been trying to get the Crystal Sound (CS4205) notebook (Dell
Inspiron 8200) soundcard to work with both OSS and Alsa (although I
would prefer to get Alsa working rather than OSS), but it seems that
both drivers have insufficient info about this card to get it to work. I
did get it to "spit-out" sound, but that is the extent of it. I am using
intel8x0 audio driver (since CS4205 seems to be just the AC97 codec
while the Intel's chip does the work), but it only allows me non-duplex
operation which is horrible for any kind of serious audio purposes.

If I try to use it in full-duplex in Alsa or commercial OSS (OSS free
does not allow it at all), then I get junk from the output.

This is rather unfortunate since it seems that the latest Dell notebooks
are THX certified in terms of their audio capabilities which makes me
think that this soundcard can pack some punch (noise level so far is
extremely low), but this is unfortunately impossible in Linux as of
right now.

So, my question is does anyone know if there are any specs and or plans
on fixing this issue so that the laptop can be used in Linux?

Any help/insight regarding this issue would be greatly appreciated!
Sincerely,

Ico




_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
