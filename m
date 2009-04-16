From: Ben Dooks <ben-linux@fluff.org>
Subject: ASoC fixes for 2.6.30-rc for s3c24xx
Date: Thu, 16 Apr 2009 10:32:19 +0100
Message-ID: <1239874343-7280-1-git-send-email-ben-linux@fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from teyla.home.fluff.org (aeryn.fluff.org.uk [87.194.8.8])
	by alsa0.perex.cz (Postfix) with ESMTP id 94F80103936
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Apr 2009 11:36:10 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

These are fixes for the S3C24XX ASOC build, and in my view should
be pushed to linus as soon as possible as I am updating the defconfigs
that will cause these to be built.

They are available at:

     git://aeryn.fluff.org.uk/bjdooks/linux.git v2630-rc2-asoc

this is based on kernel 2.6.30-rc2.
