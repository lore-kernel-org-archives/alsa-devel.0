From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [regression] 2.6.25-rc4 snd-es18xx broken on Alpha
Date: Mon, 10 Mar 2008 23:33:37 +0100
Message-ID: <47D5B741.6010702@keyaccess.nl>
References: <20080310222211.2A0BEDBA2@gherkin.frus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.groni1.gr.home.nl (smtpq1.groni1.gr.home.nl
	[213.51.130.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 0B44510384E
	for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2008 23:33:03 +0100 (CET)
In-Reply-To: <20080310222211.2A0BEDBA2@gherkin.frus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Bob Tracy <rct@frus.com>
Cc: ALSA devel <alsa-devel@alsa-project.org>, Michael Cree <mcree@orcon.net.nz>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-alpha@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 10-03-08 23:22, Bob Tracy wrote:

> Rene Herman wrote:

>> Bob? How short are "short" wav files by the way?
> 
> The one I was using for testing is 50,272 bytes. A slightly longer file 
> that exhibits "more exotic" looping behavior is 97,898 bytes (just a bit 
> over 6 seconds of audio). I'll send you the shorter file under separate 
> cover.

Thanks. No problems here, using either the ALSA or OSS interfaces. Have been 
busy switching cards -- I have no hardware that can use anything other than 
DMA 0, 1 or 3. First test is to see if it's ALSA or just the OSS emulation 
though...

Rene.
