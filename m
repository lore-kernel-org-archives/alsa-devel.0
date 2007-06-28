From: Thierry Vignaud <tvignaud@mandriva.com>
Subject: helping debugging
Date: Thu, 28 Jun 2007 15:08:57 +0200
Message-ID: <m2ps3gw7iu.fsf@vador.mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from office.mandriva.com (office-abk.mandriva.com [84.55.162.90])
	by alsa0.perex.cz (Postfix) with ESMTP id 356B024399
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Jun 2007 15:08:58 +0200 (CEST)
Received: from vador.mandriva.com (anakin.mandrakesoft.com [192.168.100.54])
	by office.mandriva.com (Postfix) with ESMTP id 4C6EA806E
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Jun 2007 15:16:18 +0200 (CEST)
Received: from vador.mandriva.com (vador.mandriva.com [127.0.0.1])
	by vador.mandriva.com (Postfix) with ESMTP id 6A6F31BCBB
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Jun 2007 15:08:57 +0200 (CEST)
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

Hi

Here's a suggestion from Dave Airlie:

http://airlied.livejournal.com/46087.html 
 
"If you are going to have lots of unsigned int sized free running
pointers called things like hw_ptr or hw.ptr or anything, for
debugging it would be really cool if you started those counters at
INT_MAX-100000 or something instead of at zero,

24 hours waiting for a bug to trip in the pcm rate conversion is not
fun and I'm guessing it'll be some stupid interger overflow or dumb
boundary condition hitting..."
