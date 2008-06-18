From: Jacob Ole Juul Kolding <dacobi@juvul.com>
Subject: Listing raw midi devices "The Right Way"?
Date: Wed, 18 Jun 2008 15:05:12 +0200
Message-ID: <1213794312.3771.5.camel@nixbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from zentipede.dk (unknown [81.161.181.194])
	by alsa0.perex.cz (Postfix) with ESMTP id AA1EE243AD
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Jun 2008 15:05:34 +0200 (CEST)
Received: from [10.20.193.42] (gprs-sonofon-6-nat.mobil.telenor.no
	[212.17.141.57]) by zentipede.dk (Postfix) with ESMTP id 51B127A9B
	for <alsa-devel@alsa-project.org>; Tue, 17 Jun 2008 16:16:47 +0000 (GMT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello all

I'm working on an app that used to run on Linux but then moved to OS X
and gained MIDI capabilities.
Now it's moving back to Linux so I need to be able to read midi events
from devices.

I already found a code example that reads raw midi packages form a
specified device but I need to have a complete list of ALL raw midi
capable devices and ports on the system.

What is the "Right Way" for an app to build such a list?

Sincerely 
Jacob Kolding
Juvul Tech
