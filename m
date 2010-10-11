From: Volkan YAZICI <yazicivo@ttmail.com>
Subject: Re: Mic + Headphone Problem in Samsung R540
Date: Mon, 11 Oct 2010 22:16:35 +0300
Message-ID: <87eibwleuk.fsf@alamut.ozu.edu.tr>
References: <87aams5t14.fsf@alamut.ozu.edu.tr>
	<87vd5cew6b.fsf@alamut.ozu.edu.tr> <4CAF104F.30201@gmail.com>
	<87y6a8de30.fsf_-_@alamut.ozu.edu.tr>
	<AANLkTi=mqYdTGZxxGH7fQN6rZLx9LMv7Hx16s+Lt_bs_@mail.gmail.com>
	<87wrprus88.fsf_-_@alamut.ozu.edu.tr> <4CB29FB7.6070305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.ttmail.com (mail.ttmail.com [88.255.235.9])
	by alsa0.perex.cz (Postfix) with ESMTP id 9FA9E1037F2
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Oct 2010 21:16:14 +0200 (CEST)
In-Reply-To: <4CB29FB7.6070305@gmail.com> (Valentine Sinitsyn's message of
	"Mon, 11 Oct 2010 11:25:11 +0600")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Valentine Sinitsyn <valentine.sinitsyn@gmail.com>
Cc: Raymond Yau <superquad.vortex2@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 11 Oct 2010, Valentine Sinitsyn <valentine.sinitsyn@gmail.com> writes:
> 1. Reload soundcard driver with no model specified (i.e. delete "model=basic"
> from modprobe.conf and reboot or do rmmod snd-hda-intel/modprobe snd-hda-intel
> model=auto). This will reset all mixers, so you'll need to enable Capture again
> in order for mic to work.
> 2. If headphones work, you are done.

Despite I tried this setting at least 4 times, this time it worked in
the first try. Maybe I should quit PhD while I am the start of it.

> 3. If not, run HDA Analyzer, find "PIN 0x21" in the left sidebar. Look at
> "Output Amplifier" checkbox group and clear mute checkboxes. Then, switch to
> "AUD_MIX (0x0C)" in the same sidebar and adjust output volume (the same checkbox
> group). You should hear sound in your headphones.
> 4. If not, look at PIN 0x1a and do the same as at step 3.
> 5. If this doesn't help, file a bug report.

Thanks so much Raymond and Valentine for your helpful support. I am in
dept to you.


Regards.
