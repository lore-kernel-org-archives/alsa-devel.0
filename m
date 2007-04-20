From: Rask Ingemann Lambertsen <rask@sygehus.dk>
Subject: Re: [PATCHv2] ALSA: Support Media Vision Jazz16 chips
Date: Fri, 20 Apr 2007 21:31:13 +0200
Message-ID: <20070420193113.GB3192@sygehus.dk>
References: <20070412182238.GA5324@sygehus.dk> <4620312D.7040907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pfepc.post.tele.dk (pfepc.post.tele.dk [195.41.46.237])
	by alsa0.perex.cz (Postfix) with ESMTP id ADFE92468B
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Apr 2007 21:31:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4620312D.7040907@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Apr 14, 2007 at 03:41:01AM +0200, Rene Herman wrote:
> On 04/12/2007 08:22 PM, Rask Ingemann Lambertsen wrote:
> 
> >+	static uint dev_num = 0;
> >+
> >+	if (enable[dev_num])
> >+		card = snd_card_new(index[dev_num], id[dev_num], 
> >THIS_MODULE, 0);
> >+	else
> >+		card = NULL;
> >+	dev_num++;
> >+	if (card == NULL)
> >+		return enable[dev_num] ? -ENOMEM : -ENODEV;
> 
> You should also guard against dev_num overrunning SNDRV_CARDS. How about:

   Oops. Also notice dev_num++ between two checks of what was supposed to be
the same enable[dev_num]. :-(

   I fixed the other bits as well. I'll post a new patch in a few days.

-- 
Rask Ingemann Lambertsen
