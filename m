From: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Subject: Re: ALSA:ATMEL: common arch for audio via ssc(patch
 3/3: adding directories)
Date: Fri, 26 Sep 2008 14:57:22 +0200
Message-ID: <48DCDC32.8060207@atmel.com>
References: <48DCAA3A.8030209@atmel.com> <20080926125035.GB15493@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atmel-es2.atmel.fr (mail.atmel.fr [81.80.104.162])
	by alsa0.perex.cz (Postfix) with ESMTP id 56CB5103819
	for <alsa-devel@alsa-project.org>;
	Fri, 26 Sep 2008 14:57:46 +0200 (CEST)
In-Reply-To: <20080926125035.GB15493@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sedji Gaouaou <sedji.gaouaou@atmel.com>, alsa-devel@alsa-project.org, Frank Mandarino <fmandarino@endrelia.com>, Geoffrey Wossum <geoffrey@pager.net>, Haavard Skinnemoen <haavard.skin>
List-Id: alsa-devel@alsa-project.org

Hi Mark,
Mark Brown a =E9crit :
> On Fri, Sep 26, 2008 at 11:24:10AM +0200, Sedji Gaouaou wrote:
>> This last patch contains the board specific files.
>> I have not changed playpaq_wm8510.c, and I did few changes on =

>> eti_b1_wm8731.c.
> =

> It'd be better to submit this as two separate patches, one making the
> modifications to eti_b1_wm8731.c and another doing the simple code move
> (in either order).  This would make it easier to review the changes -
> due to the file move they're not really visible in the current patch.
> =

> It'd also be good to see acks from Frank and Geoffrey since I can't test
> any of this.
> =

> Thanks for doing this work - it looks good, unifying the support for the
> AT91 and AVR32 platforms is a substantial win and it's good to see Atmel
> contributing this support.
> =

Unfortunately I can't test this code on eti nor avr boards since we =

don't have any here. So any test would be much appreciated indeed.

Furthermore I didn't change the i2c initialization since I don't know =

what is the status of the patch(I tried this one: =

http://git.kernel.org/?p=3Dlinux/kernel/git/tiwai/sound-2.6.git;a=3Dcommitd=
iff;h=3Dbe99827ea333eb15560a8b52ba57a2dce1bdfbb8
but I not sure whether it is complete or not?

I have send a first patch which is removing the two directories(at91 and =

at32), but I am not sure it is the proper way to do it.(it seems that it =

is blocked by the moderator).

I will work on your comments and I will send another patch.

Regards,
Sedji
