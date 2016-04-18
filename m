From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: mcasp: stream has more channels (2) than are
 enabled in mcasp (0)
Date: Mon, 18 Apr 2016 18:36:05 +0300
Message-ID: <5714FEE5.5070002@ti.com>
References: <14D46C39-5FDF-40DD-A16B-2DA7BDE930CB@latencyzero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id C23F8260867
 for <alsa-devel@alsa-project.org>; Mon, 18 Apr 2016 17:36:37 +0200 (CEST)
In-Reply-To: <14D46C39-5FDF-40DD-A16B-2DA7BDE930CB@latencyzero.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rick Mann <rmann@latencyzero.com>, Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 04/04/2016 11:59 AM, Rick Mann wrote:
> I've got a Beaglebone Green with a custom cape (CODEC and amp and some
> other stuff).
> =

> Kernel 4.4.6-bone-rt-r6. When I load the overlay that should set up my
> CODEC in the device tree, I get the following in the log.
> =

> [  367.172337] davinci-mcasp 48038000.mcasp: stream has more channels (2)
> than are enabled in mcasp (0) [  367.172374] davinci-mcasp 48038000.mcasp:
> ASoC: can't set 48038000.mcasp hw params: -22
> =

> You can see a little more log context, along with the DTS, here:
> =

> http://pastebin.com/UPB1xjPF
> =

> Can anyone tell me what this means? Thanks!

The fragment mostly looks OK, but am335x have 4 serializers, not 16 and the
num-serializer is deprecated at least in upstream kernel.

Something goes wrong when the McASP is loaded for sure, some parameters did
not got updated via DT perhaps, or most likely the DT fragment is loaded af=
ter
the McASP is loaded.
Can you print out:
slots, max_active_serializers, active_serializers and channels in
mcasp_common_hw_param() function?
Also just in case, can you put a dev_err() print in davinci_mcasp_probe() to
see when the driver is loaded compared to the time when the fragment is loa=
ded?

If McASP is built in, try to build it as module and load the audio modules
after the DT fragments are handled.

-- =

P=E9ter
