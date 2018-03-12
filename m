From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: soc-core: Add missing NULL check
Date: Mon, 12 Mar 2018 10:31:43 +0000
Message-ID: <20180312103143.y7bidz4gj6ya7dgo@localhost.localdomain>
References: <20180308200653.GA47801@beast>
 <20180309125050.GD5252@sirena.org.uk>
 <CAGXu5jJo2JVXKV+nieGwzH0XOPpzzo4DmYy0L05iZD6wwO1vGg@mail.gmail.com>
 <20180309202242.GA3073@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 2463C266F0F
 for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2018 11:31:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20180309202242.GA3073@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: moderated for non-subscribers <alsa-devel@alsa-project.org>, Kees Cook <keescook@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Pavel Machek <pavel@ucw.cz>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 09, 2018 at 08:22:42PM +0000, Mark Brown wrote:
> On Fri, Mar 09, 2018 at 10:45:16AM -0800, Kees Cook wrote:
> > On Fri, Mar 9, 2018 at 4:50 AM, Mark Brown <broonie@kernel.org> wrote:
> > > On Thu, Mar 08, 2018 at 12:06:53PM -0800, Kees Cook wrote:
> I think I might just remove the file though, it's been non-functional on
> most systems for a while now as almost all the drivers migrated to
> regmap and nobody complained so we should be safe.  There's still
> something that ought to be investigated here.

Looks like we might already be about to try that since it looks
like the componentisation actually removed these files, although
I assume inadvertently.

Thanks,
Charles
