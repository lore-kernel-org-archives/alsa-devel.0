From: "Patrick Shirkey" <pshirkey@boosthardware.com>
Subject: 2.6.18 unknown symbol ksize error
Date: Sun, 17 Jun 2012 09:27:44 +0200 (CEST)
Message-ID: <28300.101.169.127.232.1339918064.squirrel@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from boosthardware.localdomain (boosthardware.com [88.198.122.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 967422444D
	for <alsa-devel@alsa-project.org>;
	Sun, 17 Jun 2012 09:27:46 +0200 (CEST)
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

Hi,

I have compiled the latest stable alsa drivers against 2.6.18 kernel with
gcc-4.1.

I am getting an error when I insert the sound card modules.

    snd_rawmidi: Unknown symbol ksize

As far as I can tell 2.6.18 has support for ksize so I am not sure where
this error is coming from.




--
Patrick Shirkey
Boost Hardware Ltd
