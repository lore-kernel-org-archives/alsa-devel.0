From: Andy Owen <andy-alsa@ultra-premium.com>
Subject: alsa-kernel repository corrupted?
Date: Tue, 21 Sep 2010 22:25:31 +1000
Message-ID: <1285071931.1852.6.camel@marvin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from starfish.geekisp.com (mail.geekisp.com [216.168.135.169])
	by alsa0.perex.cz (Postfix) with ESMTP id E254A2462E
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Sep 2010 14:25:42 +0200 (CEST)
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

Hi, I'm trying to put together a patch for the ca0106 driver, and I'm
having trouble cloning the alsa-kernel repository. I've tried it a few
times from different places and while it is downloading I get "fatal:
delta size changed" when it is partially through. Here are two runs of
git clone with slightly different output (consecutive runs on the same
computer): 

% git clone git://git.alsa-project.org/alsa-kernel.git alsa-kernel
Initialized empty Git repository in /home/andy/src/alsa-kernel/.git/
remote: Counting objects: 1708307, done.
remote: Compressing objects: 100% (313659/313659), done.
remote: fatal: delta size changed
remote: aborting due to possible repository corruption on the remote
side.
fatal: early EOF
fatal: index-pack failed

% git clone git://git.alsa-project.org/alsa-kernel.git alsa-kernel
Initialized empty Git repository in /home/andy/src/alsa-kernel/.git/
remote: Counting objects: 1708307, done.
remote: Compressing objects: 100% (313659/313659), done.
remote: fatal: delta size changed
remote: aborting due to possible repository corruption on the remote
side.
fatal: early EOFs:  15% (260156/1708307), 157.79 MiB | 47 KiB/s   
fatal: index-pack failed

Does anyone else have any luck getting the repo?

Andy
