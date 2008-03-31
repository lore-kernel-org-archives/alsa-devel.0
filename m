From: "Barclay, Bruce" <bruce.barclay@intel.com>
Subject: Keep getting underruns
Date: Mon, 31 Mar 2008 13:57:37 -0700
Message-ID: <477457A8DCA386439DA800C066CF973E032134C4@azsmsx414.amr.corp.intel.com>
References: <mailman.1.1206788402.18836.alsa-devel@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 011A624826
	for <alsa-devel@alsa-project.org>;
	Mon, 31 Mar 2008 23:00:04 +0200 (CEST)
Content-class: urn:content-classes:message
In-Reply-To: <mailman.1.1206788402.18836.alsa-devel@alsa-project.org>
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

Not sure what causes this in the Alsa framework.  I only get one at the
beginning of the song but not sure how and why I get it.  Does it have
to do with the return of my pointer callback or because I call
snd_period_elapsed in my interrupt routine too soon.  Any ideas or docs
to read?
Bruce
