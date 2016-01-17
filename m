From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH] ALSA: at73c213: manage SSC clock
Date: Sun, 17 Jan 2016 21:44:02 +0000
Message-ID: <yw1xa8o3ubj1.fsf@unicorn.mansr.com>
References: <1452969349-9810-1-git-send-email-mans@mansr.com>
 <20160117213446.GC1703@samfundet.no>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from unicorn.mansr.com (unicorn.mansr.com [81.2.72.234])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D0A8260449
 for <alsa-devel@alsa-project.org>; Sun, 17 Jan 2016 22:44:03 +0100 (CET)
In-Reply-To: <20160117213446.GC1703@samfundet.no> (Hans-Christian Noren
 Egtvedt's message of "Sun, 17 Jan 2016 22:34:46 +0100")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Hans-Christian Noren Egtvedt <egtvedt@samfundet.no> writes:

> Around Sat 16 Jan 2016 18:35:49 +0000 or thereabout, Mans Rullgard wrote:
>> Since commit 49af54ff0fc7 ("misc: atmel-ssc: prepare clock only when
>> request") the SSC driver expects clients to manage the SSC clock.
>> Update this driver accordingly.
>> =

>> Signed-off-by: Mans Rullgard <mans@mansr.com>
>
> Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>
>
> I assume this will go through the alsa tree.

As I said earlier, this patch can be improved to enable the clock only
as needed, i.e. during initial setup and when the device is open.

-- =

M=E5ns Rullg=E5rd
