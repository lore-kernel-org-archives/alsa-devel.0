From: "Nobin Mathew" <nobin.mathew@gmail.com>
Subject: [ASoC]one Small Suggestion
Date: Thu, 7 Jun 2007 18:28:56 +0530
Message-ID: <8d6898730706070558r6c5c08aft8e00563b7a8ba607@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.231])
	by alsa0.perex.cz (Postfix) with ESMTP id DE4CF245FC
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Jun 2007 14:58:57 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id j2so467027nzf
	for <alsa-devel@alsa-project.org>; Thu, 07 Jun 2007 05:58:56 -0700 (PDT)
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

Liam,

Thank you for your support, my work is almost complete now, driver is
working perfectly now.


I have one suggestion,

I modified the wm9713.c codec driver in probe function , so that


	if(socdev->machine->dai_link->cpu_dai->private_data)
		codec->ac97->bus->private_data =
socdev->machine->dai_link->cpu_dai->private_data;

Here i am assigning the controller private data.


so that my following ac97 read and write to access codec registers become good.

static void aaci_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
unsigned short val)
{
	struct platform_controller *controller = ac97->bus->private_data;
	struct aaci *aaci = (struct aaci *)controller->bus_controller;


static unsigned short aaci_ac97_read(struct snd_ac97 *ac97, unsigned short reg)
{
	struct platform_controller *controller = ac97->bus->private_data;
	struct aaci *aaci = (struct aaci *)controller->bus_controller;
	u32 v;


Is there a way to accomodate this in existing ASoC design?
Or a better way to do this?
