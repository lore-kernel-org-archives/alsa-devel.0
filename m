From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: pm, hello ??
Date: Thu, 09 Feb 2006 17:56:14 -0500
Message-ID: <1139525775.30058.123.camel@mindpipe>
References: <20060130225511.5958e72c.pochini@shiny.it>
	 <s5hslr4a3v8.wl%tiwai@suse.de>  <20060209231226.4c33f598.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20060209231226.4c33f598.pochini@shiny.it>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Giuliano Pochini <pochini@shiny.it>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 2006-02-09 at 23:12 +0100, Giuliano Pochini wrote:
> Finally I found some time to debug it.
> 
> It happens that "echo 3 > file" actually writes "3\n" into the file.
> lib/vsprintf.c:simple_strtoul() returns the first non-digit character
> in the
> second argument. Then driver/base/power/sysfs.c:state_store() does:
>         if (*rest)
>                 return -EINVAL;
> *rest is always '\n', so it exits here. 

There was a discussion not long ago on LKML about whether sysfs should
strip the trailing newline.  The consensus was that this is bloat, and
echo -n should be used.  I'm not sure I agree...

Lee



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
