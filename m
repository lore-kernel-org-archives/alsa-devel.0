From: "Aaron J. Grier" <agrier@poofygoof.com>
Subject: snd_pcm_sw_params_set_xfer_align replacement?
Date: Fri, 18 Jul 2008 12:23:15 -0700
Message-ID: <20080718192315.GU835@arwen.poofy.goof.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.poofygoof.com (209-162-215-114.dq1sn.easystreet.com
	[209.162.215.114])
	by alsa0.perex.cz (Postfix) with ESMTP id 1D99F1037FC
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Jul 2008 21:23:19 +0200 (CEST)
Received: from arwen.poofy.goof.com (muzgash.poofy.goof.com [10.0.0.26])
	by smtp.poofygoof.com (Postfix) with ESMTP id 29F7229ED
	for <alsa-devel@alsa-project.org>; Fri, 18 Jul 2008 12:23:17 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

snd_pcm_sw_params_set_xfer_align() has been deprecated but the docs
don't mention what it was replaced with.

I don't ever want or need partial reads and writes -- my app would
actually be happiest being completely synchronous to the hardware with
fixed-size buffers.  any suggestions how to get ALSA to do this?

-- 
  Aaron J. Grier | "Not your ordinary poofy goof." | agrier@poofygoof.com
