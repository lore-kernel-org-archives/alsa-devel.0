From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] ASoC: au1x: Fix timeout tests in
	au1xac97c_ac97_read()
Date: Mon, 15 Jan 2018 11:37:40 +0300
Message-ID: <20180115083740.arvwplzroxvqy4qw@mwanda>
References: <20180115080838.q6nupi7rs7k5pdky@mwanda>
 <CAOLZvyGXxOdpF9kx6FcHKgVEogAkb4q0QoncH6fPS_B2nae=QQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 426BA266FBD
 for <alsa-devel@alsa-project.org>; Mon, 15 Jan 2018 09:37:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAOLZvyGXxOdpF9kx6FcHKgVEogAkb4q0QoncH6fPS_B2nae=QQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Manuel Lauss <manuel.lauss@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Manuel Lauss <manuel.lauss@googlemail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 15, 2018 at 09:25:15AM +0100, Manuel Lauss wrote:
> On Mon, Jan 15, 2018 at 9:08 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > The loop timeout doesn't work because it's a post op and ends with "tmo"
> > set to -1.  I changed it from a post-op to a pre-op and I changed the
> > initial the starting value from 5 to 6 so we still iterate 5 times.  I
> > left the other as it was because it's a large number.
> >
> > Fixes: b3c70c9ea62a ("ASoC: Alchemy AC97C/I2SC audio support")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Ackey-by: Manuel Lauss <manuel.lauss@gmail.com>
> 
> I didn't notice any failures with latest -git though, I've never
> actually hit these
> timeouts, even under maximum CPU load.
> 

Yeah.  These are static checker fixes, not something I hit in real life.

regards,
dan carpenter
