From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Recent code changes for HD-audio on HG repo
Date: Sat, 11 Aug 2007 09:30:46 -0700
Message-ID: <1186849846.5512.36.camel@razman.gruemaster.com>
References: <46BDB38D.9090803@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 678F0103832
	for <alsa-devel@alsa-project.org>;
	Sat, 11 Aug 2007 18:30:48 +0200 (CEST)
In-Reply-To: <46BDB38D.9090803@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Claude Michel <cpjm@free.fr>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I have some spare cycles to look into this over the weekend.  Please
send me the output from
http://bulletproof.servebeer.com/alsa/scripts/alsa-info.sh .
We can take this off-list and I can send you some test patches.

Thanks,

Tobin

On Sat, 2007-08-11 at 15:03 +0200, Claude Michel wrote:

> Hi,
> 
> I have done come test of the new suspend/resume capabilities.
> However suspend failed to correctly work on my laptop (dell d630).
> You must note that there is a few trouble issues with sound on this laptop:
> the snd_hda_intel driver correctly detect a STAC9205 and get the default
> pin configuration from the bios. So far, so good ... however, pin B is by
> default configured as line out and is working as such. But, it does not
> correctly work with an external microphone as it need a vref. So, 
> instead of using the
> bios settings, I use the windows default settings. This is not perfectly
> working : I usually get some glinches that disappear after a logout/login
> procedure. Nothing significant appears from a diff between 
> /proc/asound/card0/codec0
> before and after this procedure ...
> 
> Now let talk about the suspend failure. The suspend procedure (which was 
> previously
> working) produce a bug (I was not able to catch the message at this 
> stage. This is a
> partial and hand written report ..):
> Bug: unable to handle kernel NULL Pointer deferred at virtual address 0000
> ....
> Call trace
> ...
> <f9546d24> hda_set_power_state+0x34/0x150 [snd_hda_intel] <f9547768> 
> hda_call_code_suspend+0x39/0x60 [snd_hda_intel]
> <f955477b7> snd_hda_suspend+0x27/0x50 [snd_hda_intel]<f954603c> 
> azx_suspend+0x60/0xd0 [snd_hda_intel]
> <c023b29ac> pci_device_suspend+0x2c/0x70 <c0f29effd> 
> suspend_devide+0xdd/0x110
> ....
> 
> By the way, I am running mandriva 2007.1 with kernel 2.6.17-14mdv.
> cpjm
> 
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
Tobin Davis <tdavis@dsl-only.net>
