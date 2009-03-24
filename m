From: reetesh chandran <reeteshchandran@yahoo.com>
Subject: Re: How to find sampling rate supported
Date: Tue, 24 Mar 2009 09:11:52 -0700 (PDT)
Message-ID: <91919.14935.qm@web30007.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web30007.mail.mud.yahoo.com (web30007.mail.mud.yahoo.com
	[209.191.69.24]) by alsa0.perex.cz (Postfix) with SMTP id 796C81037FD
	for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2009 17:11:55 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks Takashi. =

=A0
If the lib does not provide the API to read the device capabilitiess, is th=
ere a way for applications to directly read it from the Alsa kernel driver =
? =



--- On Mon, 3/23/09, Takashi Iwai <tiwai@suse.de> wrote:


From: Takashi Iwai <tiwai@suse.de>
Subject: Re: [alsa-devel] How to find sampling rate supported
To: "reetesh chandran" <reeteshchandran@yahoo.com>
Cc: alsa-devel@alsa-project.org
Date: Monday, March 23, 2009, 3:03 AM


At Sun, 22 Mar 2009 09:00:00 -0700 (PDT),
reetesh chandran wrote:
> =

> Hi all,
> =

> I am new to the group and to Alsa.
> =

> For our project, we have to find the max sampling rate and other pcm hard=
ware parameters that the connected USB headset supports. I looked at the al=
sa library, but could not find an API which returned this information. =

> =

> I found snd_pcm_hw_params_test_* function to test a specific value is sup=
ported, but I was wondering if there was a way to query the device to get t=
he values. =


The min / max can be obtained via *_get_rate_min() and *_get_rate_max(),
at least.=A0 The other detailed information can't be get except for testing
the explicit value via *_test_rate(), so far.


HTH,

Takashi
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel



      =
