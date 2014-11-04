From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [RFC] AXD Audio Processing IP ALSA support
	-	Questions
Date: Tue, 04 Nov 2014 10:58:52 +0100
Message-ID: <5458A35C.9050405@ladisch.de>
References: <5458A0E2.4010602@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 0A82926056A
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 10:58:55 +0100 (CET)
In-Reply-To: <5458A0E2.4010602@imgtec.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Qais Yousef <qais.yousef@imgtec.com>, alsa-devel@alsa-project.org
Cc: Vinod Koul <vinod.koul@intel.com>, Neil Jones <neil.jones@imgtec.com>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Qais Yousef wrote:
> 3- Can we get an example of how transcoding (back to disk) is supposed to be working?

ALSA PCM devices are assumed to run with their own clock, i.e., it is
not directly possible for applications to control when a playback device
reads data from the ring buffer, of when a capture device writes data to
it.  The ALSA API is designed for real-time opertation; it would not be
a good choice for batch conversions.


Regards,
Clemens
