From: Dan Nyborg <nyborg@vertice.ca>
Subject: hdsp + acpi/apm = bug/feature?
Date: Sun, 30 Nov 2003 11:30:54 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FCA1B3E.7020102@vertice.ca>
References: <20031130122331.GB15972@sirius.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20031130122331.GB15972@sirius.home>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

hello,

some posts were made by myself a couple of months back regarding system 
lockups experienced with the hdsp driver - my system would lock during 
capture or playback.

this lock has been traced to kernel power management, either acpi or 
apm. when either of these are enabled, i experience locks. without them, 
no problems.

i use a 2.4.20 kernel with andrew morton's low latency patch. the cpu is 
an athlon.

thanks,

dan.



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
