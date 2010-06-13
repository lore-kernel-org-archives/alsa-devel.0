From: Paul Dugas <paul@dugasenterprises.com>
Subject: Re: Timing Info
Date: Sun, 13 Jun 2010 15:47:36 -0400
Message-ID: <AANLkTimlrYCb53D_43C0btg53xOjiAzmRXZ28Rg5opL7@mail.gmail.com>
References: <AANLkTil1tGrkCdRt1s9AZ8eWYG55hYrPOCq6TRaEhpRK@mail.gmail.com>
	<AANLkTik3ycq3POxHRG_bc0jO-KByZVvirVJ-X9-bySY_@mail.gmail.com>
	<4C14E6CB.2030909@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog105.obsmtp.com (na3sys009aog105.obsmtp.com
	[74.125.149.75]) by alsa0.perex.cz (Postfix) with SMTP id 2C5C924142
	for <alsa-devel@alsa-project.org>;
	Sun, 13 Jun 2010 21:47:39 +0200 (CEST)
Received: by wyg36 with SMTP id 36so3811160wyg.11
	for <alsa-devel@alsa-project.org>; Sun, 13 Jun 2010 12:47:36 -0700 (PDT)
In-Reply-To: <4C14E6CB.2030909@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Jun 13, 2010 at 10:10 AM, Clemens Ladisch <clemens@ladisch.de>wrote:

> Paul Dugas wrote:
> > What's the "timestamp mode".  Does it generate a timestamp each
> > period?  How would I access that timestamp?
>
> Set SND_PCM_TSTAMP_ENABLE to generate a timestamp whenever the hardware
> position is updated.  Call snd_pcm_status to read the position and the
> corresponding timestamp.
>

So, does setting SND_PCM_TSTAMP_ENABLE change the meaning of the tstamp
field in the status?  I believe I read somewhere that with TSTAMP_NONE,
tstamp was set to "now" when readi() was called.  Does it change to meaning
" the timestamp od the first frame returned"?  If not, where do I look?

Much thanks,

Paul
