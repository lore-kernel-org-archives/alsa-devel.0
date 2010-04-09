From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: alsa-lib pcm_share.c snd_pcm_share_open() bug ?
Date: Fri, 9 Apr 2010 11:03:03 -0400
Message-ID: <20100409150303.GA1128@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Abramo Bagnara <abramo@alsa-project.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I was looking at snd_pcm_share_open() in alsa-lib-1.0.22, and stumbled on the
following line:

        pcm->monotonic = pcm->monotonic;

what is that supposed to do ? There is clearly something wrong there.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
