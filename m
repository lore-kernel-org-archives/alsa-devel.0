From: "Robert Lippmann" <rlippmann@hotmail.com>
Subject: Re: snd_pcm_open() invalid argument in 1.0.10 (solved)
Date: Thu, 17 Nov 2005 16:07:31 -0500
Message-ID: <BAY102-F129B7684F67E2AF3D51A5EB45F0@phx.gbl>
References: <s5hek5fqzmu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hek5fqzmu.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tiwai@suse.de
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


>strace would reveal easily the spot in such a case.
>
>I guess it's due to the change of ipc permissions/owner in the default
>dmix.conf.
>
>
>Takashi

strace helped me track down the problem.  it appears that the rpm was making 
a self referring symlink on various conf files (alsa.conf, dmix.conf, etc).

filed a bug with the package maintainer (Atrpms).

-- rob




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
