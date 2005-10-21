From: Glen Masgai <mimosius@gmx.de>
Subject: ymfpci: AC3 passthrough broken since 1.0.10rc1
Date: Fri, 21 Oct 2005 16:57:07 +0200
Message-ID: <435901C3.7040802@gmx.de>
References: <6da067b3f311bf222020fd4e9df22fe4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <6da067b3f311bf222020fd4e9df22fe4@bugtrack.alsa-project.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

Since I installed new SUSE 10.0, AC3 passthrough on a Hoontech
Digital-XG with ymf754 isn't working anymore. I found out the
SUSE-kernel uses some patches made from alsa-kernel/driver >1.0.9b. With
recompilation of native 1.0.9b, AC3 passthrough is working again. I
already made a diff of alsa-driver/alsa-kernel/pci/ymfpci from 1.0.9b
and 1.0.10rc1, but I coulnd't figure out yet which of these
modifications breaking passthrough support. Any hints where to start
debugging?

Glen


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
