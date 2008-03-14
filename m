From: "Barclay, Bruce" <bruce.barclay@intel.com>
Subject: Underrun errors in aplay
Date: Fri, 14 Mar 2008 08:17:36 -0700
Message-ID: <477457A8DCA386439DA800C066CF973E030610D1@azsmsx414.amr.corp.intel.com>
References: <mailman.3199.1205503800.2095.alsa-devel@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id BEFE924489
	for <alsa-devel@alsa-project.org>; Fri, 14 Mar 2008 16:19:16 +0100 (CET)
Content-class: urn:content-classes:message
In-Reply-To: <mailman.3199.1205503800.2095.alsa-devel@alsa-project.org>
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


I have written a driver for Alsa and I think the sound is correct but I
do get underrun errors.  I don't understand how aplay would know if I am
starved.  This doesn't make sense to me.  I would only think that the
driver should know about underruns but maybe I am confused with this.  

I am wondering if I am calling snd_pcm_period_elapsed too often.  I am
calling that when I have free H/W buffers.  
Thanks, Bruce
