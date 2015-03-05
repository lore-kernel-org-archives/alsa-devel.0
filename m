From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: davinci-mcasp: Allow complete
 shutdown of McASP when not in use
Date: Thu, 5 Mar 2015 12:51:02 +0200
Message-ID: <54F83516.7010603@ti.com>
References: <1425392792-12659-1-git-send-email-peter.ujfalusi@ti.com>
 <20150303150742.GZ21293@sirena.org.uk> <54F6DA94.2000702@ti.com>
 <20150304113004.GJ21293@sirena.org.uk> <54F6ED24.9060907@ti.com>
 <20150304171357.GP21293@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 0BD38260448
 for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2015 11:51:05 +0100 (CET)
In-Reply-To: <20150304171357.GP21293@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

On 03/04/2015 07:13 PM, Mark Brown wrote:
> On Wed, Mar 04, 2015 at 01:31:48PM +0200, Peter Ujfalusi wrote:
>> On 03/04/2015 01:30 PM, Mark Brown wrote:
> =

>>> You can just store the state before you do the enable...
> =

>> When we come out from suspend the pm_runtime status is disabled all the =
time.
> =

> It's fine at the start of the suspend though, you can just record state?

Yes, it is possible to add a bool for this, but I don't really see the point
of duplicating the dai->active within the mcasp private data.

-- =

P=E9ter
