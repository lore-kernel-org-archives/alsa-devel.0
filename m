From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] fix ymfpci port parameter handling
Date: Mon, 27 Oct 2003 12:34:01 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0310271216580.23898-100000@studcom.urz.uni-halle.de>
References: <s5hhe1v6in6.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <s5hhe1v6in6.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: perex@suse.cz, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Clemens Ladisch wrote:
> > - fix detection of omitted (default) joystick_port parameter
> > - make fm_port and mpu_port handling consistent with joystick_port
>
> i think it'd be better to check all *_port parameters of all modules
> to use the consistent values.  so far, some drivers use the value 0 to
> disable the device, some -1, and sometimes -1 is for the
> auto-detection.
>
> yes, it's cosmetic but important.  we need to define the standard
> values before ALSA 1.0 is out.
>
> the candidates are:
>
> a) -1 = disable, 0 = auto-detect, others = manual
> b) 0 = disable, -1 = auto-detect, others = manual
> c) 0 = disable, 1 = auto-detect, others = manual
> d) 0 = disable, -1 = auto-detect, others = manual
>
> i like the case (c) or (d).

I'm for (c): When autodetection is available, the parameter can behave
like a boolean, so "1" would be the least suprising value for a
'generic enable'.

And you've already begun to implement (c) anyway.  :-)


Regards,
Clemens




-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
