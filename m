From: =?ISO-8859-1?Q?Christian_St=F6veken?= <christian.stoeveken@gmail.com>
Subject: Re: VGN-P11Z_G (hda-intel ALC262) internal microphone
	not working
Date: Sat, 9 Jan 2010 22:34:41 +0100
Message-ID: <7c16f72a1001091334y67c847b7oaeed99cd97735100@mail.gmail.com>
References: <7c16f72a1001071534sd8992e9je69bab0271b491b5@mail.gmail.com>
	<604760771001071627x33c93eeemd386e026e0c8f032@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f212.google.com (mail-fx0-f212.google.com
	[209.85.220.212])
	by alsa0.perex.cz (Postfix) with ESMTP id BAFA81037E3
	for <alsa-devel@alsa-project.org>; Sat,  9 Jan 2010 22:34:43 +0100 (CET)
Received: by fxm4 with SMTP id 4so64352143fxm.32
	for <alsa-devel@alsa-project.org>; Sat, 09 Jan 2010 13:34:41 -0800 (PST)
In-Reply-To: <604760771001071627x33c93eeemd386e026e0c8f032@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Chen <seven.steps@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 8, 2010 at 1:27 AM, Daniel Chen <seven.steps@gmail.com> wrote:

> On Thu, Jan 7, 2010 at 6:34 PM, Christian St=F6veken
> <christian.stoeveken@gmail.com> wrote:
> > I already upgraded to alsa 1.0.21 using that
> >
> http://www.webupd8.org/2009/11/ubuntu-karmic-upgrade-alsa-to-1021-from.ht=
mlPPA
> > and am atm on 2.6.33-020633rc3-generic.
>
> Kernel version does not matter in this instance, because your
> alsa-driver 1.0.21 is too old. You should have used 1.0.22.1. Most
> importantly, the quirk you should use is model=3Dauto. Please confirm
> that it works, and I'll generate a patch.
>
> Best,
> -Dan
>

I just finished installing 1.0.22 and I'm sad to say the mic doesn't work
with model=3Dauto
http://www.alsa-project.org/db/?f=3De513c825e0afa3dc14068cd680645f83fd36b2e8

Regards,
Chris
