From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Troubles using the external SDK
Date: Thu, 25 Feb 2010 08:27:53 +0800
Message-ID: <4f3252891002241627s622e7ea1hd001d5b6b0cbc0c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id CA4C7103926
	for <alsa-devel@alsa-project.org>; Thu, 25 Feb 2010 01:27:54 +0100 (CET)
Received: by pwi9 with SMTP id 9so4659707pwi.38
	for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2010 16:27:53 -0800 (PST)
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

>> Anyways. I want to know how you'd do this.
>> The OSS driver for example doesn't even seem to define a delay()
callback,
>> which strikes me as odd.How can it know about the delay?

http://git.alsa-project.org/?p=alsa-plugins.git;a=blob_plain;f=doc/README-pcm-oss

This plugin converts the ALSA API over OSS API.  With this plugin,
ALSA native apps can run on OSS drivers.

The function supported by this plugin is limited.  For example, you
cannot use dmix together with this plugin.  Don't expect too much :)



Please note that this plugin require a real OSS driver , not ALSA oss
kernel emulation

e.g. you can use this oss plugin to use the aureal binary driver
http://aureal.sourceforge.net/ [^ <http://aureal.sourceforge.net/>] on
Fedore Core 1 when alsa au88x0 driver was not written
