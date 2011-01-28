From: Andy Robinson <ajr55555@gmail.com>
Subject: Re: [PATCH] ALSA: HDA: Fix microphone(s) on Lenovo
	Edge 13
Date: Fri, 28 Jan 2011 10:59:25 -0500
Message-ID: <AANLkTikzwy8L0Xk_5-P2sO3qPFO_TfJQyTbpx2Qz=WHf@mail.gmail.com>
References: <4D413CBE.9080409@canonical.com>
	<s5hd3nhcv7u.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id A898310380C
	for <alsa-devel@alsa-project.org>; Fri, 28 Jan 2011 16:59:26 +0100 (CET)
Received: by gwaa20 with SMTP id a20so1315749gwa.38
	for <alsa-devel@alsa-project.org>; Fri, 28 Jan 2011 07:59:25 -0800 (PST)
In-Reply-To: <s5hd3nhcv7u.wl%tiwai@suse.de>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 28, 2011 at 3:01 AM, Takashi Iwai <tiwai@suse.de> wrote:
> And I hope that we should go further a bit for now -- more clean up of
> the cxt5066 code either checking BIOS pins or hp/mic/spk pre-defined
> pins. =A0Currently, the code is fairly messy (partly because of olpc
> support), and now is a good chance to improve it a bit more.

The parsing code that was put in place for the CX206xx almost works
for the cxt5066 as well, except that it does not handle inputs
connected to the audio selector. Would it be better to add more
auto-configuration to the cxt5066 code, or to enhance the CX206xx code
to make it work with the cxt5066? I suppose the cxt5066 code is more
mature at this point, so enhancing the cxt5066 code might have less
risk of breaking something.

Also, it looks like there's a bug in cx_auto_check_auto_mic. Both "if"
statements are checking if cfg->inputs[0].pin is an external mic and
cfg->inputs[1].pin is an internal mic. The first one should be doing
the opposite.
