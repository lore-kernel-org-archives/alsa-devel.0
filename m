From: Lu Guanqun <guanqun.lu@intel.com>
Subject: Re: ALSA underruns for S32_LE format
Date: Mon, 22 Aug 2011 14:28:53 +0800
Message-ID: <20110822062853.GC7993@guanqun-laptop.sh.intel.com>
References: <CAL5CBvJBrk=euqXgOK=QWP4NC5yYKsm92Y+vC4dJiirgW1o_+A@mail.gmail.com>
	<CABb+yY2SnCwoHANNPiekz0TqqV2L=gzz2mk_6tvC-VYDtmEJtg@mail.gmail.com>
	<CAL5CBvLB8QJdH0m_SqpZRAY6ka279akzKdoUS6naPCEWPYh4cA@mail.gmail.com>
	<CABb+yY2-TxP6K+OkbkM0CgY5uW8tTi1CHH5Cv9vz3PAYLdEBoA@mail.gmail.com>
	<CAL5CBv+vndvMub3Psgo=zPUzYPQ1yNjOTf-1pZFZS65VLhRGuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 1E3C9103870
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Aug 2011 08:28:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAL5CBv+vndvMub3Psgo=zPUzYPQ1yNjOTf-1pZFZS65VLhRGuw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: kuldeep ghan <ghankp@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Jassi Brar <jassisinghbrar@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 22, 2011 at 02:21:07PM +0800, kuldeep ghan wrote:
> On Sat, Aug 20, 2011 at 12:40 AM, Jassi Brar <jassisinghbrar@gmail.com>wrote:
> 
> > On Sat, Aug 20, 2011 at 12:03 AM, kuldeep ghan <ghankp@gmail.com> wrote:
> > > Hi,
> > >  Thanks Jassi, I dont my System is too slow, I have dual core processor,
> > > 1.5GHz. no CPU consuming process running on it.
> > It sure is not slow. Most probably I can't help anyways.
> >
> > >  I Shall confirm if it does not support S32_LE.. Is  there any means by
> > > which I can confirm the same without
> > >  going through Codec Driver??
> > Generally, if the following works fine
> >  $ speaker-test -Dhw -c 2 -t sine -f 200 -r 48000 -F S32_LE
> >
> Speaker-test mentioned above results into write error -32. I tried googling
> it but did not get the right reason yet.
> what does the write error -32. error imply?

Hi,

Could you please run `alsa-info.sh` and post the output here?
Thus other people will know more details about your platform and have a
better chance to figure out what might be wrong.

-- 
guanqun
