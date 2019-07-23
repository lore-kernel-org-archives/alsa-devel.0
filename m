From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v2] ASoC: madera: Read device tree
 configuration
Date: Tue, 23 Jul 2019 16:10:07 +0100
Message-ID: <20190723151007.GQ54126@ediswmail.ad.cirrus.com>
References: <20190722135209.30302-1-ckeepax@opensource.cirrus.com>
 <7a6ca46b-9ca7-6c91-6aa9-d1be785c64c5@intel.com>
 <20190723081706.GL54126@ediswmail.ad.cirrus.com>
 <026ea350-db7b-d78c-cae5-e03cf735607c@intel.com>
 <20190723150125.GP54126@ediswmail.ad.cirrus.com>
 <20190723150302.GH5365@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5337EF800E8
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2019 17:10:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20190723150302.GH5365@sirena.org.uk>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Mark Brown <broonie@kernel.org>
Cc: patches@opensource.cirrus.com, Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 23, 2019 at 04:03:02PM +0100, Mark Brown wrote:
> On Tue, Jul 23, 2019 at 04:01:25PM +0100, Charles Keepax wrote:
> 
> > Ah.. yes I follow. Yes this is intentional, all the DT fields in
> > question are optional so the driver should proceed if even if they
> > are corrupt or missing.
> 
> If they're present but unparsable you should probably say something
> about that really.  That's clearly different to optional.

The helper logs an error message itself since essentially the
only difference in the messages is the name of the property,
there is just no need to process the return value since we
would take the same code path regardless of failure or success.

Thanks,
Charles
