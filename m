From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: 3.13 regression on panda board
Date: Wed, 4 Dec 2013 19:52:02 +0200
Message-ID: <529F6BC2.60008@ti.com>
References: <s5hfvq84qxd.wl%tiwai@suse.de>
 <20131204155531.GY29268@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 4655E2619E4
 for <alsa-devel@alsa-project.org>; Wed,  4 Dec 2013 18:51:47 +0100 (CET)
In-Reply-To: <20131204155531.GY29268@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 12/04/2013 05:55 PM, Mark Brown wrote:
> On Wed, Dec 04, 2013 at 03:43:58PM +0100, Takashi Iwai wrote:
>> Hi Peter (or anyone who is responsible):
> =

>> could you update the bugzilla report below?
>>    https://bugzilla.kernel.org/show_bug.cgi?id=3D66451
> =

> That's probably not even directly audio related but rather from core DMA
> changes (though perhaps the driver is buggy).  When akpm forwards stuff
> to the lists he tend to include the entire report and CC bugzilla -
> that's generally more helpful in getting responses since people don't
> need to click on a link or anything.

Interesting for sure. I'm running currently 3.13-rc1+ but not rc2 + my twl6=
040
reg_cache patches. I don't have issues with audio. I try mainline tomorrow =
to
see what happened.

-- =

P=E9ter
