From: David Mohr <damailings@mcbf.net>
Subject: Re: Front jack not working with hda-intel driver
	SigmaTel STAC9271D codec
Date: Tue, 29 Dec 2009 23:56:55 +0100
Message-ID: <472d4b250912291456k773368b9nc2de2ea49782ec8a@mail.gmail.com>
References: <472d4b250912290757r68b6d421id289314d1cb1ea9f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f53.google.com (mail-pw0-f53.google.com
	[209.85.160.53]) by alsa0.perex.cz (Postfix) with ESMTP id 24E4B243D1
	for <alsa-devel@alsa-project.org>; Tue, 29 Dec 2009 23:56:56 +0100 (CET)
Received: by pwi18 with SMTP id 18so28685510pwi.32
	for <alsa-devel@alsa-project.org>; Tue, 29 Dec 2009 14:56:55 -0800 (PST)
In-Reply-To: <472d4b250912290757r68b6d421id289314d1cb1ea9f@mail.gmail.com>
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

On Tue, Dec 29, 2009 at 4:57 PM, David Mohr <damailings@mcbf.net> wrote:
> Hi,
> I'm running ubuntu 9.10. I had to force model=5stack to get any audio
> output at all. While the jack in the back now works, I still don't get
> any sound on the front jack. I haven't found any options in alsamixer,
> and switching the output mode in pavucontrol to the headphones just
> makes the sound disappear from the back jack, but I still get nothing
> in the front.
>
> I uploaded my alsa-info.sh output here:
> http://www.alsa-project.org/db/?f=3ed2ab9e7732bf08d2bbfbe8adb74bf037d9e618
>
> Can I fix this somehow, or is it a bug?
>
> And of course thanks everyone for the usually great working alsa system.

I forgot to mention the updated alsa-info using the driver snapshot from today:
http://www.alsa-project.org/db/?f=0099c6761773d060d98a8d028c6f56d5c9498d19

~David
