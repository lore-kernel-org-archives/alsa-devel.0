From: Ian Molton <ian@mnementh.co.uk>
Subject: Re: [Pull request] Support for wm9705 codec and two
 machines that use it.
Date: Thu, 15 Jan 2009 23:58:36 +0000
Message-ID: <496FCDAC.70900@mnementh.co.uk>
References: <496E8DD0.4090006@mnementh.co.uk> <s5hfxjl3v6s.wl%tiwai@suse.de>
	<496F0ABD.4080207@mnementh.co.uk>
	<20090115172057.GC12768@sirena.org.uk>
	<496FB5AA.1030205@mnementh.co.uk>
	<20090115222228.GA8806@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mnementh.co.uk (mail.mnementh.co.uk [173.45.232.4])
	by alsa0.perex.cz (Postfix) with ESMTP id EF4C61038B7
	for <alsa-devel@alsa-project.org>; Fri, 16 Jan 2009 00:58:10 +0100 (CET)
In-Reply-To: <20090115222228.GA8806@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Thu, Jan 15, 2009 at 10:16:10PM +0000, Ian Molton wrote:
>> Mark Brown wrote:
> 
>>>> +	soc_ac97_ops.reset(codec->ac97);
> 
>>> This should check the return value, resets can and do fail.
> 
>> This call returns void. So no.
> 
> Oh, sorry - thinko.  You should read back the ID register and verify the
> value.

Implemented, tested, checkpatch passed.

Pushed out and available at:

git://git.mnementh.co.uk/linux-2.6-im.git asoc

gitweb at:

http://git.mnementh.co.uk/cgi-bin/gitweb.cgi?p=linux-2.6-im.git;a=shortlog;h=refs/heads/asoc

Thanks for the review,

-Ian
