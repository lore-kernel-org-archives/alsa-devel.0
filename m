From: MPH Kernel <opendev@mph.eclipse.co.uk>
Subject: latencytest for PPC?
Date: Mon, 18 Oct 2004 13:37:25 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041018123725.GA2154@palantir7.mph.eclipse.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

Anyone have a latency testing tool for PPC?
The latest working version I have is latencytest 0.42, but it
never detects any xruns (where alsa does). So I'm suspicious
of it's output.

latencytest 0.5.5 won't work for PPC. It depends on RTC stuff
not present in the gen_rtc module.

Thanks,
	Martin


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
