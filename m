From: Brad Figg <brad.figg@canonical.com>
Subject: Re: [PATCH 1/1] Daily snapshot not building on 2.6.32
Date: Thu, 24 Jun 2010 07:56:35 -0700
Message-ID: <4C237223.6060606@canonical.com>
References: <4C22545C.2060101@canonical.com> <s5h8w65djy1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id C972E103963
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Jun 2010 16:56:52 +0200 (CEST)
In-Reply-To: <s5h8w65djy1.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 06/23/2010 11:27 PM, Takashi Iwai wrote:
> At Wed, 23 Jun 2010 11:37:16 -0700,
> Brad Figg wrote:
>>
>> I've had to apply the following patch to successfully build
>> the daily snapshot on 2.6.32. Without this patch I get:
>
> Which tarball?  The latest one works fine for me.
>
>
> Takashi

Today's snapshot is giving me the exact same error.

   CC [M]  /karmic/home/work/alsa/alsa-driver/usb/misc/ua101.o
In file included from /karmic/home/work/alsa/alsa-driver/usb/misc/ua101.c:3:
/karmic/home/work/alsa/alsa-driver/usb/misc/../../alsa-kernel/usb/misc/ua10=
1.c: In function =91alloc_stream_buffers=92:
/karmic/home/work/alsa/alsa-driver/usb/misc/../../alsa-kernel/usb/misc/ua10=
1.c:1071: error: implicit declaration of function =91usb_alloc_coherent=92
/karmic/home/work/alsa/alsa-driver/usb/misc/../../alsa-kernel/usb/misc/ua10=
1.c:1072: warning: assignment makes pointer from integer without a cast
/karmic/home/work/alsa/alsa-driver/usb/misc/../../alsa-kernel/usb/misc/ua10=
1.c: In function =91free_stream_buffers=92:
/karmic/home/work/alsa/alsa-driver/usb/misc/../../alsa-kernel/usb/misc/ua10=
1.c:1092: error: implicit declaration of function =91usb_free_coherent=92
/karmic/home/work/alsa/alsa-driver/usb/misc/../../alsa-kernel/usb/misc/ua10=
1.c: In function =91ua101_card_free=92:
/karmic/home/work/alsa/alsa-driver/usb/misc/../../alsa-kernel/usb/misc/ua10=
1.c:1172: warning: unused variable =91ua=92
make[4]: *** [/karmic/home/work/alsa/alsa-driver/usb/misc/ua101.o] Error 1
make[3]: *** [/karmic/home/work/alsa/alsa-driver/usb/misc] Error 2
make[2]: *** [/karmic/home/work/alsa/alsa-driver/usb] Error 2
make[1]: *** [_module_/karmic/home/work/alsa/alsa-driver] Error 2
make[1]: Leaving directory `/usr/src/linux-headers-2.6.32-23-generic'

Brad
-- =

Brad Figg brad.figg@canonical.com http://www.canonical.com
