From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH V4 0/5] AC97 driver for mpc5200
Date: Tue, 26 May 2009 06:39:30 -0500
Message-ID: <ed82fe3e0905260439v7f90d2b7w3f0ee400200588e5@mail.gmail.com>
References: <20090525221406.21370.30326.stgit@terra>
	<ed82fe3e0905252044w1d0e1f5cqbaf4256b9f749d42@mail.gmail.com>
	<9e4733910905260408x335ac337wc77e4d9ac5027f61@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f103.google.com (mail-qy0-f103.google.com
	[209.85.221.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 4FE832474F
	for <alsa-devel@alsa-project.org>;
	Tue, 26 May 2009 13:39:33 +0200 (CEST)
Received: by qyk1 with SMTP id 1so4945934qyk.16
	for <alsa-devel@alsa-project.org>; Tue, 26 May 2009 04:39:30 -0700 (PDT)
In-Reply-To: <9e4733910905260408x335ac337wc77e4d9ac5027f61@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@sirena.org.uk, Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
List-Id: alsa-devel@alsa-project.org

On Tue, May 26, 2009 at 6:08 AM, Jon Smirl <jonsmirl@gmail.com> wrote:
> On Mon, May 25, 2009 at 11:44 PM, Timur Tabi <timur@freescale.com> wrote:
>> On Mon, May 25, 2009 at 5:15 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
>>
>>> =A0 =A0 =A0The macro spin_event_timeout() takes a condition and timeout=
 value
>>
>> My patch is already set to go through the powerpc tree, so there's no
>> need to repost it here. =A0Please, you changed the title of the patch.
>
> I'm changing the code,

My code?  If you want to make your own version of spin_event_timeout,
then you should change the name and keep it local to your C files.

> I removed the ! on the rc. Geert just asked to
> have it changed to an in-line too.

And Geert's request won't work.

-- =

Timur Tabi
Linux kernel developer at Freescale
