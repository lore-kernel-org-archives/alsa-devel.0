From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v9 01/13] Documentation: Add SLIMbus summary
Date: Fri, 8 Dec 2017 14:14:54 +0530
Message-ID: <20171208084454.GD18649@localhost>
References: <20171207102720.21071-1-srinivas.kandagatla@linaro.org>
 <20171207102720.21071-2-srinivas.kandagatla@linaro.org>
 <20171207103253.25834a68@lwn.net>
 <138216ca-4351-f895-fae2-0289cf2a3872@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C7B2266B67
 for <alsa-devel@alsa-project.org>; Fri,  8 Dec 2017 09:41:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <138216ca-4351-f895-fae2-0289cf2a3872@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-doc@vger.kernel.org, pombredanne@nexb.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Jonathan Corbet <corbet@lwn.net>, j.neuschaefer@gmx.net, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org, sdharia@codeaurora.org
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 07, 2017 at 11:22:51PM +0000, Srinivas Kandagatla wrote:
> Thankyou for taking time to review the patch,
> 
> On 07/12/17 17:32, Jonathan Corbet wrote:
> >On Thu,  7 Dec 2017 10:27:08 +0000
> >srinivas.kandagatla@linaro.org wrote:
> >
> >A couple of overall comments...
> >
> >>  Documentation/driver-api/index.rst           |   1 +
> >>  Documentation/driver-api/slimbus/index.rst   |  15 ++++
> >>  Documentation/driver-api/slimbus/summary.rst | 106 +++++++++++++++++++++++++++
> >>  3 files changed, 122 insertions(+)
> >>  create mode 100644 Documentation/driver-api/slimbus/index.rst
> >>  create mode 100644 Documentation/driver-api/slimbus/summary.rst
> >
> >Do we really need a separate subdirectory for a single file?
> >
> May be not, TBH, I did take some inspiration from soundwire patches.

FWIW, SoundWire patches have more Documentation. We have 4 files atm, though
they are not part of current series, so a directory looks apt for that

> I can drop that in next version. We can think of adding directory if we end
> up adding more apis for the new features in future.
> 
> >It seems you have kerneldoc comments for your data structures and at least
> >some of your exported symbols.  If you really want to document this stuff
> >well, I'd suggest finishing out those comments, then pulling them into the
> >documentation in the appropriate places.
> Am sure all the exported symbols have kernel doc, I will pull them into
> relevant sub sections.
> 
> Do you think something like this http://paste.ubuntu.com/26135862/ makes
> sense?
> 
> thanks,
> srini
> >
> >Thanks,
> >
> >jon
> >
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
~Vinod
