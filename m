From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Help in understanding SND_PCM_TSTAMP_ENABLE mode
 snd_pcm_htimestamp function
Date: Wed, 17 Jul 2013 15:52:47 +0200
Message-ID: <51E6A1AF.5040609@ladisch.de>
References: <CACQjdxDywzxBgHg0v++m4L4NuuvAPt9qnw=9v3j+5fFxhNFjBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 0FFFF2654A0
 for <alsa-devel@alsa-project.org>; Wed, 17 Jul 2013 15:52:51 +0200 (CEST)
In-Reply-To: <CACQjdxDywzxBgHg0v++m4L4NuuvAPt9qnw=9v3j+5fFxhNFjBw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: divya v <divyasslv@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

divya v wrote:
> I am looking for a method to maintain timestamps for every sample read or
> written.

ALSA does not have timestamps for every sample.

> I noticed the *SND_PCM_TSTAMP_ENABLE mode. But the description mentions - ""
> *pdate timestamp at every hardware position update"
> Doe this mean that the when snd_pcm_htimestamp() is issued, we will get the
> last hardware update timestamp

Yes, this is what the documentation says.

> or does it mean that it will fetch the timestamp of that particular
> sample?

Yes; it will fetch the timestamp of the particular sample that is
returned in "avail".


Regards,
Clemens
