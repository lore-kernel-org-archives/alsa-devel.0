From: Patrick Doyle <wpdster@gmail.com>
Subject: No device for DAI %s
Date: Sun, 5 Sep 2010 13:59:27 -0400
Message-ID: <AANLkTikksq9W+x7T2GqFDfZZOUvOVg0XD3Nmo=ATzw=f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 68AE4243A4
	for <alsa-devel@alsa-project.org>;
	Sun,  5 Sep 2010 19:59:49 +0200 (CEST)
Received: by iwn4 with SMTP id 4so3468331iwn.38
	for <alsa-devel@alsa-project.org>; Sun, 05 Sep 2010 10:59:48 -0700 (PDT)
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

Hello all,
In snd_soc_register_dai() there is a warning message generated:

	/* The device should become mandatory over time */
	if (!dai->dev)
		printk(KERN_WARNING "No device for DAI %s\n", dai->name);

I am curious -- what is the intent of that warning message?  If the
device "should become mandatory over time" when will that happen
(obviously, when the developer of a particular device makes it
happen), but what would motivate the developer to do so?  If I am that
developer, and I am adapting code from another device, what do I need
to do (and why should I do it) to associate a device with a DAI?

Actually, in a more general sense, is there any good
article/book/tutorial/blog explaining the design and architecture of
the SoC code in ALSA?  Right now, I am in a maze of little twisty
passages, all alike, composed of calls to snd_soc_register_dai(),
platform_register_driver(), platform_register_device, "soc-audio"
platform drivers, i2s drivers, i2c drivers, etc... and would like to
find something to help me pull my head back above water.  (Have I
mixed enough metaphors here?)

Thanks for any tips folks can give.

--wpd
