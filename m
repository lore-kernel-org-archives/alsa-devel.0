From: Bryan Wu <cooloney@kernel.org>
Subject: Re: [PATCH 4/5] ASoC: Blackfin: drop pointless casts
	due to dma updates
Date: Sun, 8 Mar 2009 12:28:22 +0800
Message-ID: <386072610903072028i64865773w4e05598c7ff49ac9@mail.gmail.com>
References: <1236326010-683-1-git-send-email-cooloney@kernel.org>
	<1236326010-683-5-git-send-email-cooloney@kernel.org>
	<20090306110949.GC6493@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.173])
	by alsa0.perex.cz (Postfix) with ESMTP id 9D6CD1037F6
	for <alsa-devel@alsa-project.org>; Sun,  8 Mar 2009 05:28:23 +0100 (CET)
Received: by wf-out-1314.google.com with SMTP id 26so1217502wfd.23
	for <alsa-devel@alsa-project.org>; Sat, 07 Mar 2009 20:28:22 -0800 (PST)
In-Reply-To: <20090306110949.GC6493@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Mike Frysinger <vapier.adi@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 6, 2009 at 7:10 PM, Mark Brown <broonie@sirena.org.uk> wrote:
> On Fri, Mar 06, 2009 at 03:53:29PM +0800, Bryan Wu wrote:
>> From: Mike Frysinger <vapier.adi@gmail.com>
>>
>> Signed-off-by: Mike Frysinger <vapier.adi@gmail.com>
>> Signed-off-by: Bryan Wu <cooloney@kernel.org>
>> ---
>> =A0sound/blackfin/bf53x_sport.c | =A0 55 ++++++++++++++++++-------------=
----------
>> =A01 files changed, 24 insertions(+), 31 deletions(-)
>
> Mainline doesn't have a sound/blackfin directory at all as far as I can
> tell so this patch doesn't apply? =A0The only mainline support I can see
> for blackfin audio is sound/soc/blackfin which only has a generic
> bf5xx-sport file. =A0A similar cleanup was done there a while ago.
>

Oh, god. Sorry, my script sent out this in a mess. Please ignore this one

Thanks a lot
-Bryan
