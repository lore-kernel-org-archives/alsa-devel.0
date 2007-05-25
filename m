From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: [ALSA] ALSA Power Management,
	Drivers behaving	unexpectedly after suspend/resume cycle
Date: Fri, 25 May 2007 10:09:28 +0100
Message-ID: <1180084168.13652.11.camel@localhost.localdomain>
References: <8d6898730705242257k6da2088fi80f0d4034ed78986@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id 3455C2441A
	for <alsa-devel@alsa-project.org>;
	Fri, 25 May 2007 11:09:30 +0200 (CEST)
In-Reply-To: <8d6898730705242257k6da2088fi80f0d4034ed78986@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Nobin Mathew <nobin.mathew@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2007-05-25 at 11:27 +0530, Nobin Mathew wrote:
> I am implementing power management in my ALSA sound drivers. ALSA
> drivers are not working properly after resume. All registers values
> are proper and I am able to read back the codec register contents.
> 

Iirc, you are using an AC97 codec. This means that the AC97 link is
running as expected after resume.

> If I do a playback after resume then I am getting lots of "underrun".
> 

Do you hear any audio at all ? The underruns are probably being caused
by the AC97 Tx FIFO not being filled quickly enough by DMA. Is your DMA
being set up correctly after resume ?

> 
> After a reboot playback is working fine.
> 
> Is there any known issues with ALSA power  management?

ALSA suspend and resume works fine on lots of devices (all the ones I
have). I suspect you have a driver problem.

Liam
