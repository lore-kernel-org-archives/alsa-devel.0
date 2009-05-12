From: Florian Faber <faber@faberman.de>
Subject: Re: [PATCH 1/1] hdsp: allow firmware loading
 from	inside the kernel
Date: Tue, 12 May 2009 08:44:26 +0200
Message-ID: <4A091ACA.1060502@faberman.de>
References: <4A091428.2000106@free.fr> <s5hy6t2u8wh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from india820.server4you.de (india820.server4you.de [85.25.152.101])
	by alsa0.perex.cz (Postfix) with ESMTP id DFEBB246B5
	for <alsa-devel@alsa-project.org>;
	Tue, 12 May 2009 08:44:27 +0200 (CEST)
In-Reply-To: <s5hy6t2u8wh.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Tue, 12 May 2009 08:16:08 +0200,
> Rapha=EBl Doursenaud wrote:
>> From: Rapha=EBl Doursenaud <rdoursenaud@free.fr>
>>
>> Allow the use of  the FIRMWARE_IN_KERNEL option with hdsp cards and
>> in-kernel driver.
> Did it really work without problems?

Why load the digiface firmware? There's three different firmware files
for three different io boxes, each has to get it's own firmware.


Flo
-- =

Machines can do the work, so people have time to think.
public key 6C002249          x-hkp://wwwkeys.eu.pgp.net
