From: Motti Daniel <mottid@waves.com>
Subject: Compiling an Alsa plugin with Intel compiler.
Date: Thu, 25 Sep 2008 13:13:14 +0300
Message-ID: <48DB643A.9080909@waves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maxx.waves.com (maxx.waves.com [12.34.136.4])
	by alsa0.perex.cz (Postfix) with ESMTP id D853A1037EC
	for <alsa-devel@alsa-project.org>;
	Thu, 25 Sep 2008 12:13:13 +0200 (CEST)
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

Hello people!

I'm working on an Alsa plugin for the Xandros Linux distribution
my plugin runs very well except it consume about 20% of resources
from the target machine (eee pc at 1.6Ghz)
I'm trying to compile the same code with Intel Compiler (version 10.1.017)
(before that it was compiled with gcc 4.1.2)
the plugin compiles well but when I try to play music it tells me that
the plugin library (the .so file in /usr/lib/alsa-lib/ is not there.
I tried to analyze the symbols in the executable and found that the
difference between gcc and Intel compiler is a list of symbols with
a suffix __FUNCTION__ or __PRETTY_FUNCTION__
is this the problem?
any suggestions?
can you tell me  what are the minimum alsa requirements from a dynamic
library so it can be loaded and run as an Alsa plugin?

thanks!
Motti Daniel.
