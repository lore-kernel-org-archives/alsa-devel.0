From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Subject: Re: [PATCH] ALSA: ASoC: McASP: Fix data rotation for
 playback. Enables 24bit audio playback
Date: Fri, 18 Jan 2013 08:48:36 +0000
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EB49984@DBDE01.ent.ti.com>
References: <1358260860-10370-1-git-send-email-michal.bachraty@streamunlimited.com>
 <1BAFE6F6C881BF42822005164F1491C33EB49910@DBDE01.ent.ti.com>
 <3861763.aeE9tah8r0@ganymedes>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 653A3265DE7
 for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2013 09:48:46 +0100 (CET)
In-Reply-To: <3861763.aeE9tah8r0@ganymedes>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Michal Bachraty <michal.bachraty@streamunlimited.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Girdwood,
 Liam" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 18, 2013 at 14:13:40, Michal Bachraty wrote:
> On Friday, January 18, 2013 08:22:53 Hebbar, Gururaja wrote:
> > On Tue, Jan 15, 2013 at 20:11:00, Michal Bachraty wrote:
> > > Signed-off-by: Michal Bachraty <michal.bachraty@streamunlimited.com>
> > 
> > Even simple patches need a simple changelog.
> > Add a brief description about what & why it is done?
> > 
> 
> Hi Gurujaja,
> 
> > > -	u32 rotate = (32 - word_length) / 4;
> This implementation is wrong, but it works only for 16, or 32 bit audio data.
> (rotation for 16 or 32 bit is same as in code I present) Mcasp rotated data in 
> 4 bits (max value 0x7)and then masks them . That data are sended to i2s bus. 
> For 24 bit or 20 bit or other data formats, this code rotates data badly and 
> you hear somethink like noise.  You need to use
> > > +	u32 rotate = (word_length / 4) & 0x7;
> to proper data rotation. 

Correct. Now can you add the above info into the patch and re-submit. 
That way when users sees this patch, they will get all the info needed.

> 
> Regards,
> Michal
> 
> 


Regards, 
Gururaja
