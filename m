From: Gou Zhuang <gouzhuang@bigfoot.com>
Subject: Re: Oops on resume, X crashes
Date: Mon, 27 Oct 2003 09:03:59 +0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F9C6EFF.9030909@bigfoot.com>
References: <3F939367.80804@bigfoot.com>	<s5h4qy4dkx5.wl@alsa2.suse.de>	<3F94F094.80109@Sun.COM>	<s5hr816de2j.wl@alsa2.suse.de>	<3F979B68.9030006@bigfoot.com>	<s5hptgn96lc.wl@alsa2.suse.de>	<3F98BC91.3090606@bigfoot.com> <s5hoew77xmd.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hoew77xmd.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Gou Zhuang <gouzhuang@bigfoot.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Fri, 24 Oct 2003 13:45:53 +0800,
> Gou Zhuang wrote:
> 
>>I applied the patch, the oops went away :) But I still get a lot of
>>"ALSA pcm_oss.c:552: snd_pcm_oss_prepare: SNDRV_PCM_IOCTL_PREPARE failed".
>>
>>And the artsd crashed after resume with the following errmsg:
>>
>>Sound Server fatal error:
>>AudioSubSystem::handleIO: write failed
>>len = 16, can_write = 24, errno = 4 (interrupted system call)
>>
>>Do you have any clue on this?
> 
> 
> how about the attached patch?  (in replacement with the previous one.)
> 
> 
> Takashi

Yes, this patch fixed it.

Thanks,
Gouzhuang



-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
