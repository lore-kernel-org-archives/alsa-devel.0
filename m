From: Pascal Wichmann <pascal.wichmann@pa-w.de>
Subject: Re: Problems with the DP MST audio support patchset
Date: Fri, 31 Mar 2017 21:04:37 +0200
Message-ID: <e92f2266-c911-cbad-643a-3ce5d757f4a5@pa-w.de>
References: <6800ee6e-31c2-b5eb-fbb2-6826d8c66dc9@pa-w.de>
 <bceb4859-6dc9-b7a8-4d3a-81ac2a1fa907@pa-w.de>
 <96A12704CE18D347B625EE2D4A099D19524850F3@SHSMSX103.ccr.corp.intel.com>
 <63a71394-1cd4-e3e3-7364-37c2da90c791@pa-w.de>
 <96A12704CE18D347B625EE2D4A099D19524854BD@SHSMSX103.ccr.corp.intel.com>
 <49ff23f3-7c58-abf1-f1ff-87822f0b0585@pa-w.de>
 <96A12704CE18D347B625EE2D4A099D19524866B0@SHSMSX103.ccr.corp.intel.com>
 <s5hlgrl1mty.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web02.pwsrv.de (web02.pwsrv.de [188.68.38.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 6BFBF266C0C
 for <alsa-devel@alsa-project.org>; Fri, 31 Mar 2017 21:04:40 +0200 (CEST)
In-Reply-To: <s5hlgrl1mty.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, "Yang, Libin" <libin.yang@intel.com>
Cc: Libin Yang <libin.yang@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi all,

> I guess the digital-7.1 corresponds to HBR, and it's a special 
> setup. Meanwhile 5.1 output he has tried is likely the LPCM, so
> both are in a completely differently manner.
Thank you, that sounds like a good explanation for my first issue.


For the other problem, that seems to be some kind of HDMI handshake
related issue to me.
I have done some more research and found similar
problems like [0]. Their solution to enable a pulseaudio loopback seemed
to improve the situation at first; at least during the last two hours,
the problem did not occur as often as it did before (without explicitly
provoking it), but it occurred though.

In addition, I have disabled the power save options of the snd_hda_intel
module:
> options snd_hda_intel power_save=0 power_save_controller=N
This however does not seem to have any impact on the problem at all.

I have also found a way to reliably reproduce the problem by muting and
immediately unmuting the output in alsamixer having some audio running
- -- this way, the output gets silenced for a few seconds a moment after
the unmuting almost always.

Is the above solution using the pulseaudio loopback module not enough to
prevent handshake issues? Do handshake issues sound suitable at all? Do
you have any other ideas where the problem may lies?


Regards,
Pascal

[0]
https://ubuntuforums.org/showthread.php?t=2215224&p=13117108#post1311710
8
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE/gJ8Tpn0OtJz8hxD6+YIa34W/zYFAljeqEEACgkQ6+YIa34W
/zZxbxAAr7LprAKZpkthtxDigKtGhU+fT1ysbXLAd8af2P+nsNcNwp4IugKn+yH2
46LOfHFSt6vGks2rvBRcNZpaVHwHO2HU4x8VpH+DZF3uye7CEMP/eQ7SocsYl1jG
6/C3eI4Jj0UI7jWEIky5Qcv+vz+AbmkDrnmQXveUxMsogT3JJMQIA/X2CgPNlwWm
mM/hJKP8AP1tmWHVp4vRPvkEGJbbXDb6B/HOu3ogDBylFglFeMO0Gs6d46u93snm
Vk7BVHZagzz/AFTgRuAEHPDaTaem6Jt1yYPfCF9EkpnJTYpzg6NUDWHwriF2tBWU
wF94Dph0tEU6ad9556oYZiAS1/3SWil2spK+UNG5KN+MP/S/6rzi7JOeJnCpOe+j
kn5+DAgXqb8A+/l0YV2TQE1neyc5BsaJvWZoRExBe3xyCZz3+OC0LB8x24X8Ml8z
3g+bY5+ObQEr/sfgvEiHWP2bsf5uMda0sZsvAsqaTE9/xPx5VE3uwGBdn2ae9nnc
HuO9NFzKlDKGYE82LSFrqNrngJVxvpVK8tC4BegbTodzB00GFPcHaO6hJR1b40SK
gGbQXZ1yfhtQPOGPflcDJiXp4f2mCI9JpbTb+UMenk2qcSx9GU29HZ33XWg1xTL0
ecHtdlN0pXwEtxTG5yMijJZ4aadCOwHLoLN01OJXG4UIWO+By88=
=aohm
-----END PGP SIGNATURE-----
