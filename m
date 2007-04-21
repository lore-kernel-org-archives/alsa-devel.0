From: "Ben DiDonc" <ben.didonc@gmail.com>
Subject: Re: No sound with ATI SB450
Date: Sat, 21 Apr 2007 16:00:54 +1000
Message-ID: <feca60390704202300hd987409nd6fc8b2ee316c771@mail.gmail.com>
References: <feca60390704202156h5a34ef0ao975d8c398dee9473@mail.gmail.com>
	<1177134516.21521.143.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.242])
	by alsa0.perex.cz (Postfix) with ESMTP id 4227D243BC
	for <alsa-devel@alsa-project.org>;
	Sat, 21 Apr 2007 08:00:55 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c18so1129812anc
	for <alsa-devel@alsa-project.org>; Fri, 20 Apr 2007 23:00:54 -0700 (PDT)
In-Reply-To: <1177134516.21521.143.camel@razman.gruemaster.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tobin Davis <tdavis@dsl-only.net>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The output of alsa-info.sh is available at http://pastebin.ca/451007


On 4/21/07, Tobin Davis <tdavis@dsl-only.net> wrote:
>
>  Could you download an run
> http://bulletproof.servebeer.com/alsa/scripts/alsa-info.sh , then post the
> resulting link?  This will help determine what setup you have.
>
> Tobin Davis
>
> On Sat, 2007-04-21 at 14:56 +1000, Ben DiDonc wrote:
>
> HiI have a toshiba A100 (see attached file lspci-nnv) with a ATI SB450.Sound worked fine with kernel 2.6.17 and alsa 1.0.12rc1 (ubuntu edgy).I just did a fresh install of ubuntu feisty (kernel 2.6.20, alsa1.0.14rc1) and the only mixer settings available are those of themodem, named off-hook and caller-id (see output of amixer, aplay -l ,and the rest in attached file output_feisty)
> I decided to upgrade alsa-driver and alsa-lib to 1.0.14rc2. afterdownloading the package, I unloaded all sound related modules(everything with "snd_" in it) in the right order and did:./configure --with-oss=yes --with-cards=hda-intel;make; sudo makeinstall; sudo modprobe snd_hda_intelA minor improvement: the mixer now shows controls for both the modemand the sound card (see output_after_upgrade_to_rc2), butunfortunately, there is still no sound coming out of those speakers(even though alsamixer shows control for PCM and the rest...).
> Finally, I downloaded alsa-driver-1.0.14rc3 and gave it a shot. Thistime again, only modem related settings appeared in alsamixer, and nosound card stuff (see aplay and amixer inoutput_after_upgrade_to_rc3), and no sound either.
> Does anyone know how to get some sound out of these speakers (giventhat it used to work with alsa1.0.12rc1...) ?
> Thanks for your helpBen
> _______________________________________________Alsa-devel mailing listAlsa-devel@alsa-project.orghttp://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>   --
> Tobin Davis <tdavis@dsl-only.net>
>
