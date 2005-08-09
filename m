From: Philip Prindeville <philipp_subx@redfish-solutions.com>
Subject: Skinny (and very skinny) digital packaging
Date: Tue, 09 Aug 2005 16:09:50 -0600
Message-ID: <42F929AE.3010703@redfish-solutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.redfish-solutions.com (mail.redfish-solutions.com [71.36.29.88])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5E64F19D
	for <alsa-devel@alsa-project.org>; Wed, 10 Aug 2005 00:09:53 +0200 (MEST)
Received: from [192.168.1.5] ([192.168.1.5])
	(authenticated bits=0)
	by mail.redfish-solutions.com (8.13.1/8.13.1) with ESMTP id j79M9ovY014250
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <alsa-devel@alsa-project.org>; Tue, 9 Aug 2005 16:09:51 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

As more and more hardware supports digital input and/or output
(more often output than input), I was wondering if it makes sense
to offer a build/packaging option of "skinny digital", which would
entail omitting all of the analogue portions of the driver, the
config files, and the various utilities (or the utilities could detect that
no analogue hardware support is present and simply disable it).

The idea being that if someone wanted to have a bare bones (pardon
the pun) installation that supported digital output only (or digital
input and output) with no need for analogue mixing or analogue
source routing, then they could do so with a minimum configuration.
Why?  Well, the less there is to configure, the less that can go wrong...
and since all digital media (CD, DVD, digital satellite tuners, ATSC,
etc) is more and more common, people probably have little or no need
for analogue functionality these days.

So the installer portions of the makefiles would need to be changed
to understand a digital only install, the source configuration files
could be tweaked to allow preprocessing via m4 or cpp, and the
drivers and libraries could be made conditional to omit the code
that handles analogue functionality.

Initialization too might need to change the default settings to be
digital...

What does everyone think?  Comments?  Am I off in left field?

Thanks,

-Philip



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
