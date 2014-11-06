From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] add Steinberg UR44 USB Audio
	Interface	support to quirks-table
Date: Thu, 06 Nov 2014 18:32:22 +0100
Message-ID: <545BB0A6.5030304@ladisch.de>
References: <1394388767-23658-1-git-send-email-cyrus@bobobeach.com>	<531DAB14.5080201@ladisch.de>	<76F78615-8762-4A6C-B601-97380805F450@bobobeach.com>	<531DDD04.5050902@ladisch.de>	<0EFBCC9F-93CA-4368-9530-B9049B3743FB@bobobeach.com>	<531EC9CC.4060203@ladisch.de>	<88C9DBF9-92A3-4885-87C5-A9966C326D0F@bobobeach.com>	<545895AD.7020004@ladisch.de>	<545A697C.5070800@bobobeach.com>
 <545A93E3.7020906@ladisch.de> <545B9C57.1070304@bobobeach.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 878522652AC
 for <alsa-devel@alsa-project.org>; Thu,  6 Nov 2014 18:32:33 +0100 (CET)
In-Reply-To: <545B9C57.1070304@bobobeach.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Cyrus Harmon <cyrus@bobobeach.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Cyrus Harmon wrote:
> I'm interested in finding out what quirk->type is when it gets to
> snd_usb_create_quirk as it looks like the function in the quirk_funcs
> table that gets called here produces the first suspect error.

>>> [    2.964094] snd-usb-audio 3-3.2:1.0: checking PCM interface
>>> [    2.964104] snd-usb-audio: probe of 3-3.2:1.0 failed with error -5

The first error is harmless (the control interface is not a PCM
interface).

>>> ...
>>> [    2.970930] snd-usb-audio: probe of 3-3.2:1.1 failed with error -5

The second error happens during snd_card_register().  In other words,
there's probably something about the PCM device that makes
snd_pcm_dev_register() unhappy.


Regards,
Clemens
