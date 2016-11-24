From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH 1/2] topology: Merge private data before
 embedded controls of a widget
Date: Thu, 24 Nov 2016 12:09:17 +0000
Message-ID: <1479989357.23022.135.camel@loki>
References: <1479951232-23213-1-git-send-email-mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 1ABDC266A02
 for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2016 13:09:28 +0100 (CET)
In-Reply-To: <1479951232-23213-1-git-send-email-mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mengdong.lin@linux.intel.com
Cc: tiwai@suse.de, mengdong.lin@intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2016-11-24 at 09:33 +0800, mengdong.lin@linux.intel.com wrote:
> From: Mengdong Lin <mengdong.lin@linux.intel.com>
> 
> For a widget ABI object, its private data sits before the embedded
> controls, so we should merge the private data blocks at first, and
> then the embedded controls.
> 
> Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

Both 

Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
