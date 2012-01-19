From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v5] ASoC: Apply msbits constraint for
 sample size bigger than the msbits
Date: Thu, 19 Jan 2012 09:27:33 +0100
Message-ID: <4F17D3F5.3020901@ti.com>
References: <1326899114-26979-1-git-send-email-peter.ujfalusi@ti.com>
	<20120118152905.GP8732@opensource.wolfsonmicro.com>
	<4F16F6B0.7030707@ti.com>
	<20120118174648.GQ8732@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog119.obsmtp.com (na3sys009aog119.obsmtp.com
	[74.125.149.246])
	by alsa0.perex.cz (Postfix) with ESMTP id 3BD3724567
	for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2012 09:27:38 +0100 (CET)
Received: by ghrr18 with SMTP id r18so2178590ghr.25
	for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2012 00:27:37 -0800 (PST)
In-Reply-To: <20120118174648.GQ8732@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 01/18/2012 06:46 PM, Mark Brown wrote:
> That'd help a bit.  Though I'd just go with a for loop, the while
> clearly doesn't look any better - I was just suggesting it without
> actually having tried writing it out.

Are you going to take the for version of patch, or should I resend it?
I can add a comment to explain that we bail out, and not checking the
sample sizes lower than the requested msbits, if it helps.

-- =

P=E9ter
