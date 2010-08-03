From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: ALC269 mixer nodes
Date: Tue, 03 Aug 2010 08:49:05 +0200
Message-ID: <4C57BBE1.7040703@canonical.com>
References: <4C56D6A1.5030805@canonical.com> <s5h7hk9nk6c.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id B89762438E
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Aug 2010 08:49:06 +0200 (CEST)
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.69 #1 (Debian))
	id 1OgBJC-0005je-Es
	for <alsa-devel@alsa-project.org>; Tue, 03 Aug 2010 07:49:06 +0100
Received: from [88.83.60.91] (helo=[192.168.8.103])
	by hutte.canonical.com with esmtpsa
	(TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.69)
	(envelope-from <david.henningsson@canonical.com>) id 1OgBJC-00035W-B4
	for alsa-devel@alsa-project.org; Tue, 03 Aug 2010 07:49:06 +0100
In-Reply-To: <s5h7hk9nk6c.wl%tiwai@suse.de>
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

2010-08-02 16:50, Takashi Iwai skrev:
> At Mon, 02 Aug 2010 16:30:57 +0200,
> David Henningsson wrote:
>>
>> Here's yet another ALC269 which I'm unsure of how to fix the right way.
>> There is no way to enable the microphone, and I think the trouble has to
>> do with that the auto parser does not check whether the node is a mixer
>> or a selector. It might be that the "alc269" vs "alc269vb" detection is
>> wrong as well (btw, what does vb stand for?).
>>
>> I unfortunately do not have the full alsa-info output, but the
>> codec-proc is here:
>> http://launchpadlibrarian.net/49076615/Card0.Codecs.codec.2.txt
>> and PCI IDs:
>> http://launchpadlibrarian.net/49076618/PciMultimedia.txt
> 
> Are you sure that it's the result with the very latest driver?

The codec-proc might not have been generated with the very latest
driver, but when I run it through hda-emu (with a just-pulled
sound-2.6.git as hda-dir), I get errors as:

send: NID=0x23, VERB=0x701(set_connect_sel), PARM=0x1
invalid connect select for node 0x23

...which makes me believe the error is still there. The error above
comes from patch_realtek.c:14366, btw.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
