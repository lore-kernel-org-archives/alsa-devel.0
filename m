From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Clean up of ALSA kernel codes: Update
Date: Tue, 1 Nov 2005 08:59:49 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0511010857030.8966@tm8103.perex-int.cz>
References: <s5hbr19j3l5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hbr19j3l5.wl%tiwai@suse.de>
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

On Fri, 28 Oct 2005, Takashi Iwai wrote:

> Now, some questions reagarding 2:
> 
> A. What about names without snd_ like ac97_t?
>    Should it be "struct ac97" or "struct snd_ac97"? 

I would keep the namespace (naming) consistent, so I vote for the second 
(struct snd_ac97) variant.

> B. The biggest question:
>    Does anyone have strong objection against replacement of xxx_t?

None from my side. I think that the objection/idea from kernel developers 
to "know the real type of variable on first glance" is a good idea.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
