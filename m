From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: davinci-mcasp: Allow complete
 shutdown of McASP when not in use
Date: Wed, 4 Mar 2015 13:31:48 +0200
Message-ID: <54F6ED24.9060907@ti.com>
References: <1425392792-12659-1-git-send-email-peter.ujfalusi@ti.com>
 <20150303150742.GZ21293@sirena.org.uk> <54F6DA94.2000702@ti.com>
 <20150304113004.GJ21293@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 898B526500C
 for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2015 12:31:52 +0100 (CET)
In-Reply-To: <20150304113004.GJ21293@sirena.org.uk>
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

On 03/04/2015 01:30 PM, Mark Brown wrote:
> On Wed, Mar 04, 2015 at 12:12:36PM +0200, Peter Ujfalusi wrote:
>> On 03/03/2015 05:07 PM, Mark Brown wrote:
> =

>>> I see there's actually a balanced put in the resume path...  I see
>>> what's going on here but I'm thinking that perhaps something more
>>> explicit that calls the ops directly and checks pm_runtime_is_enabled()
>>> might be clearer?
> =

>> The issue with the pm_runtime_is_enabled() is going to be in the resume =
path,
>> as I did get_sync() it will return true at the end all the time.
> =

> You can just store the state before you do the enable...

When we come out from suspend the pm_runtime status is disabled all the tim=
e.

-- =

P=E9ter
