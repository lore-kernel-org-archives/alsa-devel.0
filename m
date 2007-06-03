From: "Edwin Smulders" <edwin.smulders@gmail.com>
Subject: Re: snd_hda_intel: Conexant CX20551 (Waikiki)
Date: Sun, 3 Jun 2007 20:07:47 +0200
Message-ID: <9a85a1550706031107p98ff5f7o617bd10229a9534@mail.gmail.com>
References: <9a85a1550706030812s61d5112dk45e735ca82e28ac6@mail.gmail.com>
	<1180884802.4335.74.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 38239244B9
	for <alsa-devel@alsa-project.org>;
	Sun,  3 Jun 2007 20:07:49 +0200 (CEST)
Received: by py-out-1112.google.com with SMTP id a29so1936799pyi
	for <alsa-devel@alsa-project.org>; Sun, 03 Jun 2007 11:07:47 -0700 (PDT)
In-Reply-To: <1180884802.4335.74.camel@razman.gruemaster.com>
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Yeah, that is probably going to fix it.

I'm adding my laptop model to this thread for the sake of google and other
owners of toshiba laptops :) (forgot in the original mail)
Toshiba Satellite P100-232

Im having a bit of trouble using the howto because of differences in
distributions but ill ask around on the ubuntu forums and on irc for that.

Many thanks for the links Tobin, this problem has been bugging me for almost
a year now.

~~Edwin

On 6/3/07, Tobin Davis <tdavis@dsl-only.net> wrote:
>
>  This is a known acpi issue with Toshiba (I can tell by the subsystem id:
> 1179:ff31 for device 0:1b.0).   Here are a few links to help fix the
> problem:
>
> http://www.linuxquestions.org/questions/showthread.php?t=531575
> http://gentoo-wiki.com/HARDWARE_Toshiba_Satellite_P100
>
>
> Tobin
>
> On Sun, 2007-06-03 at 17:12 +0200, Edwin Smulders wrote:
>
> Hi,
> I believe there's still a problem with the HDA Intel chip ConexantCX20551 (Waikiki) not working.However, im not entirely sure the problem the problem is with alsa,because it starts working when i boot with acpi=off (a fix suggestedon the ubuntu forums, but not quite useful on a laptop [plus, itbreaks my ethernet])
> The reason I'm mailing is, can you confirm this is something alsacan/should/will fix or are we all looking in the wrong direction andthis is really an acpi problem?
> If you can fix this or know of something that might work, I would behappy to hear it.I've attached my lspci -nv and cat /proc/asound/card0/codec\#* just incase. I would be happy to give you any more info you might need.
> ~~ Edwin
> _______________________________________________Alsa-devel mailing listAlsa-devel@alsa-project.orghttp://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>   --
> Tobin Davis <tdavis@dsl-only.net>
>
