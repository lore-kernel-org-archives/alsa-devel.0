From: Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH v5 8/9] soundwire: Add support for multi
 link bank switch
Date: Tue, 10 Jul 2018 22:07:55 +0530
Message-ID: <20180710163754.GA22349@buildpc-HP-Z230>
References: <1530791196-15483-1-git-send-email-shreyas.nc@intel.com>
 <1530791196-15483-9-git-send-email-shreyas.nc@intel.com>
 <6ac86676-ad92-141d-bda7-99549e0d76ea@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id ED0D32676FE
 for <alsa-devel@alsa-project.org>; Tue, 10 Jul 2018 18:37:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <6ac86676-ad92-141d-bda7-99549e0d76ea@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: patches.audio@intel.com, gregkh@linuxfoundation.org, alsa-devel@alsa-project.org, vkoul@kernel.org, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 09, 2018 at 06:22:26PM -0500, Pierre-Louis Bossart wrote:
> 
> >@@ -1170,6 +1276,17 @@ int sdw_stream_add_master(struct sdw_bus *bus,
> >  	stream->m_rt_count++;
> >+	/*
> >+	 * For multi link streams, add the second master only if
> >+	 * the bus supports it.
> >+	 * Check if bus->multi_link is set
> >+	 */
> >+	if (!bus->multi_link && stream->m_rt_count > 1) {
> >+		dev_err(bus->dev,
> >+			"Multilink not supported, link %d", bus->link_id);
> >+		goto stream_error;
> >+	}
> >+
> >  	goto unlock;
> >  stream_error:
> >
> 
> This error handling is a bit weird. It's make more sense to check upfront if
> there is already one m_rt allocated (m_rt_count > 0) and bail to avoid
> allocating/releasing a stream. Also there should be a return value set
> (-EINVAL?)

Agreed, this error check should be done upfront. Will fix this and
also the return value.

-- 
