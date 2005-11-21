From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: ALSA driver 1.10.0 and Linux 2.4.32 - a few
	problems
Date: Mon, 21 Nov 2005 14:15:49 -0500
Message-ID: <1132600550.29178.78.camel@mindpipe>
References: <20051121191031.16020.qmail@web52903.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20051121191031.16020.qmail@web52903.mail.yahoo.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 2005-11-21 at 19:10 +0000, Chris Rankin wrote:
> $ winecfg
> ALSA lib pcm_dmix.c:1101:(_snd_pcm_dmix_open) The field ipc_gid must be a valid group (create
> group audio)
> wine: Unhandled page fault on read access to 0x00000008 at address 0x7e529c1f (thread 0009),
> starting debugger...
> 
> The wine code doesn't know anything about "dmix", so I'm assuming that this _snd_pcm_dmix_open()
> function is called internally within the library, and the caller isn't handling the error code.

This is not a backtrace.  Run winecfg under gdb and when it segfaults do
"thread apply all bt".

Lee



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
