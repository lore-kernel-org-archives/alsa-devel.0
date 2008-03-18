From: "Barclay, Bruce" <bruce.barclay@intel.com>
Subject: If you have a copy callback,
	do you need to have a silence?
Date: Tue, 18 Mar 2008 11:08:53 -0700
Message-ID: <477457A8DCA386439DA800C066CF973E030A29ED@azsmsx414.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 798FA1038C4
	for <Alsa-devel@alsa-project.org>; Tue, 18 Mar 2008 19:08:56 +0100 (CET)
Content-class: urn:content-classes:message
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I was finally able to get my driver working.  I had to use the copy
callback since my memory is external to Alsa.  I have noticed that I
commented out the silence callback and the ack.  All seems to work and
just for grins, I put them in with some printk's and they were never
invoked.  I don't fully understand these callbacks.  When are they
called and am I just lucky?

Bruce

 

---------------------
Bruce Barclay
Intel Corporation
( Phone : 480-554-0553
( Cell : 480-274-7493
* Email:bruce.barclay@intel.com
* MS    : CH7-308
"Real Gold Fears No Fire" - Li Quan
