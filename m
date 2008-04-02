From: "Barclay, Bruce" <bruce.barclay@intel.com>
Subject: DMIX and Alsa Drivers
Date: Wed, 2 Apr 2008 14:30:28 -0700
Message-ID: <477457A8DCA386439DA800C066CF973E03247065@azsmsx414.amr.corp.intel.com>
References: <mailman.4558.1207150039.2095.alsa-devel@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 29942244A1
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Apr 2008 23:31:46 +0200 (CEST)
Content-class: urn:content-classes:message
In-Reply-To: <mailman.4558.1207150039.2095.alsa-devel@alsa-project.org>
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

I wrote an Alsa driver with copy callbacks and it worked.  Later read
that you can use copy callbacks if you want to use dmix so I rewrote it
to not use copy callbacks.  I don't see much documentation on dmix
(/etc/asound.conf).  When I put dmix in there, I can run two versions
but the framework never updates the application pointer so I get no
data.  I take the dmix out and it works fine.  No clue on what to do.
Bruce
