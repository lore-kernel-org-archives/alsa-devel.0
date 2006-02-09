From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: pm, hello ??
Date: Thu, 9 Feb 2006 23:12:26 +0100
Message-ID: <20060209231226.4c33f598.pochini@shiny.it>
References: <20060130225511.5958e72c.pochini@shiny.it>
	<s5hslr4a3v8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hslr4a3v8.wl%tiwai@suse.de>
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

On Tue, 31 Jan 2006 15:06:35 +0100
Takashi Iwai <tiwai@suse.de> wrote:

> At Mon, 30 Jan 2006 22:55:11 +0100,
> Giuliano Pochini wrote:
> >
> > I'm trying to add suspend/resume capability to the echoaudio driver. I wrote
> > susp/res functions, I attached them to struct pci_driver, I added
> > SNDRV_PCM_INFO_RESUME in struct snd_pcm_hardware.info, I added the two
> > cases in the trigger callback and the kernel has CONFIG_PM enabled. None of
> > the new code is called when I write in
> > /sys/devices/pci0001:10/0001:10:15.0/power/state . What am I missing ?
>
> No idea.  I bet something wrong in your kernel configuration or a
> simple mistake like wrongly installed kernel image, etc.

Finally I found some time to debug it.

It happens that "echo 3 > file" actually writes "3\n" into the file.
lib/vsprintf.c:simple_strtoul() returns the first non-digit character in the
second argument. Then driver/base/power/sysfs.c:state_store() does:
	if (*rest)
		return -EINVAL;
*rest is always '\n', so it exits here.


> BTW, SNDRV_PCM_INFO_RESUME should be added only if your driver really
> supports the "full resume" mode.  i.e. the stream restarts at the very
> same position where suspended.  Otherwise, dont' set that flag.  Still
> the driver works as "partial resume".  Then the prepare is called
> after resume to reset to a sane state.

Nice to know. I can't resume the card exactly as it was before, indeed,
because the internal state of the DSP is unknown to the driver. I can only
restore all gains, monitors, etc., and restart transport from the last
period(s).


--
Giuliano.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
