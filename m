From: Daniel Mack <daniel@caiaq.de>
Subject: Re: usbaudio: Support for USB audio v2.0 devices
Date: Tue, 2 Mar 2010 19:35:42 +0100
Message-ID: <20100302183542.GU28972@buzzloop.caiaq.de>
References: <1266856137-26252-1-git-send-email-daniel@caiaq.de>
	<4B8CD6A0.40204@freemail.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id CF486103815
	for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2010 19:35:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4B8CD6A0.40204@freemail.gr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: adelias <adelias@freemail.gr>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 02, 2010 at 11:13:04AM +0200, adelias wrote:
> Thanks to all involved for working on usb audio v2.
> 
> Last night I installed the 20100226 snapshot. I did a little testing 
> with my XMOS board using toslink out into may DAC. I tried various files
> ranging 16bit/44110kHz-24bit/192000kHz. The 44110 files had quite a bit
> of static, the higher bitrate files were better. As you stated the 
> sampling rate is not correct and be verified by looking at the flashing
> LEDs on the XMOS board. They should flash faster as sampling rate 
> increase. In this case no change was observed.

Yes - this is all do be done. The sample rate setting is done with a
different type of class request, which also addresses the interface now,
unlike v1 devices which send that to the endpoint. But that's just one
out of many differences that need to be addressed, and it's still a long
way to go. I'm on it :)

Daniel
