From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: How do I get a pcm device?
Date: Mon, 30 Jan 2006 19:07:03 -0500
Message-ID: <1138666024.16102.44.camel@mindpipe>
References: <1138664619.10183.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1138664619.10183.7.camel@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Cc: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 2006-01-30 at 23:43 +0000, Adrian McMenamin wrote:
> My device module can be successfully loaded and itself loads the
> firmware it needs, but there is no device I can see in /dev. How do I
> create one?
> 
> modprobe snd-pcm creates the /dev/snd directory but only puts a timer in
> it.

This depends on whether you are using udev, devfs, etc.  You can rule
out a problem with those by testing with a static /dev.

Can you post a link to the source code for your driver?

Lee



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
