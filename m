From: David Henningsson <launchpad.web@epost.diwic.se>
Subject: Re: newie, adding a file to the project
Date: Wed, 23 Jun 2010 21:29:16 +0200
Message-ID: <4C22608C.50503@epost.diwic.se>
References: <AANLkTimjzHb5NdYhYzXVKl_tZV8yc9f4NHvDF_Zam-jn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch-smtp03.sth.basefarm.net (ch-smtp03.sth.basefarm.net
	[80.76.149.214]) by alsa0.perex.cz (Postfix) with ESMTP id 7C84124153
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Jun 2010 21:29:46 +0200 (CEST)
Received: from c83-254-137-216.bredband.comhem.se ([83.254.137.216]:47250
	helo=[192.168.8.103])
	by ch-smtp03.sth.basefarm.net with esmtp (Exim 4.68)
	(envelope-from <launchpad.web@epost.diwic.se>) id 1ORVdO-0001NF-Cm
	for alsa-devel@alsa-project.org; Wed, 23 Jun 2010 21:29:21 +0200
In-Reply-To: <AANLkTimjzHb5NdYhYzXVKl_tZV8yc9f4NHvDF_Zam-jn@mail.gmail.com>
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

On 2010-06-23 16:46, javi perez wrote:
> Hello,
> 
> I am trying to add a file (aplay_miversion.c) to the project to make tests.
> I have modified the Makefile.am file of the aplay directory in the project.
> I have run ./configure and make and I don't get the file compiled. How shold
> I change the lines?

Generic answer: if there is an "autogen.sh" script, try running it,
otherwise try running "autoreconf -fi". They will update the configure
file and the makefiles for you.

// David
