From: Valentine Sinitsyn <valentine.sinitsyn@gmail.com>
Subject: Re: Mic + Headphone Problem in Samsung R540
Date: Mon, 11 Oct 2010 11:25:11 +0600
Message-ID: <4CB29FB7.6070305@gmail.com>
References: <87aams5t14.fsf@alamut.ozu.edu.tr>	<87vd5cew6b.fsf@alamut.ozu.edu.tr>
	<4CAF104F.30201@gmail.com>	<87y6a8de30.fsf_-_@alamut.ozu.edu.tr>	<AANLkTi=mqYdTGZxxGH7fQN6rZLx9LMv7Hx16s+Lt_bs_@mail.gmail.com>
	<87wrprus88.fsf_-_@alamut.ozu.edu.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 430B72414F
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Oct 2010 07:25:14 +0200 (CEST)
Received: by ewy9 with SMTP id 9so79929ewy.38
	for <alsa-devel@alsa-project.org>; Sun, 10 Oct 2010 22:25:13 -0700 (PDT)
In-Reply-To: <87wrprus88.fsf_-_@alamut.ozu.edu.tr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Volkan YAZICI <yazicivo@ttmail.com>
Cc: Raymond Yau <superquad.vortex2@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

> Thanks Raymond and Valentine for your detailed replies. I played with
> HDA Analyzer GUI but couldn't manage to make headphones work, I am
> probably missing something again. Would you mind elaborating the details
> about the steps that I need to follow?
If I were you, I'd do the following:
1. Reload soundcard driver with no model specified (i.e. delete 
"model=basic" from modprobe.conf and reboot or do rmmod 
snd-hda-intel/modprobe snd-hda-intel model=auto). This will reset all 
mixers, so you'll need to enable Capture again in order for mic to work.
2. If headphones work, you are done.
3. If not, run HDA Analyzer, find "PIN 0x21" in the left sidebar. Look 
at "Output Amplifier" checkbox group and clear mute checkboxes. Then, 
switch to "AUD_MIX (0x0C)" in the same sidebar and adjust output volume 
(the same checkbox group). You should hear sound in your headphones.
4. If not, look at PIN 0x1a and do the same as at step 3.
5. If this doesn't help, file a bug report.

Regards,
Valentine
