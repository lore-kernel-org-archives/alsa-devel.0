From: "John L. Utz III" <john.utz@dmx.com>
Subject: eliminating sequencer and midi from my alsa module
	dependencies
Date: Thu, 19 Jul 2007 16:02:43 -0700
Message-ID: <20070719160243.202cf5ac@jutz-fc6.na.corp.dmxmusic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dmxmusic.com (mail.dmxmusic.com [199.201.237.35])
	by alsa0.perex.cz (Postfix) with ESMTP id A465F1037F9
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Jul 2007 00:58:41 +0200 (CEST)
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

Hello;

What arguments should give to the current version of alsa to eliminate
the aforementioned things?

here is my current conf string from hgcompile, am i missing something?

args="--with-debug=full --with-isapnp=no --with-sequencer=no
--with-oss=no --with-cards=via82xx"

tnx!

johnu
