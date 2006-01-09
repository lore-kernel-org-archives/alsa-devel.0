From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Subject: Re: Urgent question
Date: Mon, 9 Jan 2006 11:28:13 +0000
Message-ID: <20060109112813.GC10770@palantir8>
References: <0AEFDFCCEC85B24E8051B23293C2CB640F2503@MMMSTCAE1.muac.corp.eurocontrol.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <0AEFDFCCEC85B24E8051B23293C2CB640F2503@MMMSTCAE1.muac.corp.eurocontrol.int>
Sender: alsa-devel-admin@lists.sourceforge.net
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

On Mon, Jan 09, 2006 at 11:07:36AM +0100, PIVATY Bertrand wrote:
> The sound quality looks good when using the onboard sound card provided,
> but when using any PCI sound card the sound quality is really poor.

Have you tried different PCI cards? Or is the issue with a specific
model or chipset?

> Do you have any idea of what could be the reason, or any track where we
> should investigate.

The first obvious step is to figure out if it is an application problem
or a kernel/alsa issue. I usually run 'aplay' or 'speakertest' with a simple
test file to figure that out.
If these work okay it's most likely an application problem.

> The software is running on Suse 9.0 with the last Alsa version.

This does not mean a whole lot to me. Could you send the kernel and alsa
version as reported by uname and /proc/asound/version?

-- 
Martin


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
