From: VDR User <user.vdr@gmail.com>
Subject: Re: Problems with snd-hda-intel and Asus M2NPV-VM.
	Please help!
Date: Tue, 30 Jun 2009 10:30:25 -0700
Message-ID: <a3ef07920906301030p7f84d4c4xe6c0590f436b4de9@mail.gmail.com>
References: <a3ef07920906241108u786a6c89j80f2ad89eebf7dcd@mail.gmail.com>
	<a3ef07920906241134m2f84ac06pef7465ce356f893f@mail.gmail.com>
	<s5hvdmfv6s6.wl%tiwai@suse.de>
	<a3ef07920906291028q670ed146t1451650d0c2a4713@mail.gmail.com>
	<s5hzlbq83o8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f189.google.com (mail-vw0-f189.google.com
	[209.85.212.189])
	by alsa0.perex.cz (Postfix) with ESMTP id 0E86F243FE
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Jun 2009 19:30:26 +0200 (CEST)
Received: by vwj27 with SMTP id 27so99869vwj.16
	for <alsa-devel@alsa-project.org>; Tue, 30 Jun 2009 10:30:26 -0700 (PDT)
In-Reply-To: <s5hzlbq83o8.wl%tiwai@suse.de>
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

On Tue, Jun 30, 2009 at 2:35 AM, Takashi Iwai<tiwai@suse.de> wrote:
> At Mon, 29 Jun 2009 10:28:24 -0700,
> VDR User wrote:
>>
>> On Mon, Jun 29, 2009 at 12:27 AM, Takashi Iwai<tiwai@suse.de> wrote:
>> > Try the very latest alsa-driver snapshot before doing any debugging.
>> > =A0 =A0ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/als=
a-driver-snapshot.tar.gz
>> >
>> > If this still doesn't work, run alsa-info.sh with --no-upload option,
>> > and attach the generated file. =A0I'll start checking after this.
>>
>> Thanks for your reply! =A0I have downloaded the link, compiled, and
>> installed. =A0Results are the same, spdif is not working.
>
> How did you play via SPDIF exactly?
> Doesn't the following work (even without model option)?
>
> =A0 =A0 =A0 =A0% aplay -Dplug:spdif some-48k-samples.wav

I have tried that exact command and also using -Dplug:iec958, without
success.  I tried both as user and using sudo from console and console
with x loaded.  Also with/without the model option and position_fix=3D1
option.  Is it possible the revision of the MCP51 I have is not
supported (yet)?  Please let me know anything further I can do to help
figure this out.

Many thanks!
-Derek
