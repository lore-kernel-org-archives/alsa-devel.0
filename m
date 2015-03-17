From: "Lu, Han" <han.lu@intel.com>
Subject: Re: [PATCH 1/1] Intel: ASoC: remove duplicated code on
	merge
Date: Tue, 17 Mar 2015 00:56:44 +0000
Message-ID: <B51200AC81AB024499A3C2C9A1BB90A837E2B8@SHSMSX101.ccr.corp.intel.com>
References: <1426481189-9898-1-git-send-email-han.lu@intel.com>
 <20150316110049.GJ28806@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C5A1261A03
 for <alsa-devel@alsa-project.org>; Tue, 17 Mar 2015 01:56:49 +0100 (CET)
In-Reply-To: <20150316110049.GJ28806@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

My patch was trying to fix the error introduced by commit 527cab6 in
branch for-next, where the code block of "allocate scratch mem regions"
appears twice.
However, I see the issue has been fixed and no duplicated code found in
latest branch, so my patch is not required anymore, please ignore it.
Thanks.

BR,
Han Lu

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Monday, March 16, 2015 7:01 PM
> To: Lu, Han
> Cc: alsa-devel@alsa-project.org; Girdwood, Liam R
> Subject: Re: [PATCH 1/1] Intel: ASoC: remove duplicated code on merge
> 
> On Mon, Mar 16, 2015 at 12:46:29PM +0800, han.lu@intel.com wrote:
> > From: "Lu, Han" <han.lu@intel.com>
> >
> > Signed-off-by: Lu, Han <han.lu@intel.com>
> 
> Please include a commit description explaining what the problem you're
> trying to fix is (like where the two different copies came from).  I've tweaked
> the way the merges are being done which I think has stopped this happening,
> can you check please?
