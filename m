From: "Nobin Mathew" <nobin.mathew@gmail.com>
Subject: Re: [ASoC]one Small Suggestion
Date: Fri, 8 Jun 2007 13:17:08 +0530
Message-ID: <8d6898730706080047x37a2ddb4m9766246017e43029@mail.gmail.com>
References: <8d6898730706070558r6c5c08aft8e00563b7a8ba607@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.237])
	by alsa0.perex.cz (Postfix) with ESMTP id DF14F2467A
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Jun 2007 09:47:10 +0200 (CEST)
Received: by qb-out-0506.google.com with SMTP id c7so838787qbc
	for <alsa-devel@alsa-project.org>; Fri, 08 Jun 2007 00:47:09 -0700 (PDT)
In-Reply-To: <8d6898730706070558r6c5c08aft8e00563b7a8ba607@mail.gmail.com>
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
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Adding a nice proc interface to read codec registers will be a nice
feature have, like we have in generic ac97 registers, i added that
that in wm9713.c by using ac97_proc.c

On 6/7/07, Nobin Mathew <nobin.mathew@gmail.com> wrote:
> Liam,
>
> Thank you for your support, my work is almost complete now, driver is
> working perfectly now.
>
>
> I have one suggestion,
>
> I modified the wm9713.c codec driver in probe function , so that
>
>
>         if(socdev->machine->dai_link->cpu_dai->private_data)
>                 codec->ac97->bus->private_data =
> socdev->machine->dai_link->cpu_dai->private_data;
>
> Here i am assigning the controller private data.
>
>
> so that my following ac97 read and write to access codec registers become good.
>
> static void aaci_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
> unsigned short val)
> {
>         struct platform_controller *controller = ac97->bus->private_data;
>         struct aaci *aaci = (struct aaci *)controller->bus_controller;
>
>
> static unsigned short aaci_ac97_read(struct snd_ac97 *ac97, unsigned short reg)
> {
>         struct platform_controller *controller = ac97->bus->private_data;
>         struct aaci *aaci = (struct aaci *)controller->bus_controller;
>         u32 v;
>
>
> Is there a way to accomodate this in existing ASoC design?
> Or a better way to do this?
>
