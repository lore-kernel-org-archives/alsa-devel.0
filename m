From: Steve Longerbeam <stevel@embeddedalley.com>
Subject: SoC multiple streams
Date: Mon, 18 Jun 2007 14:55:22 -0700
Message-ID: <4676FF4A.3020508@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp104.biz.mail.re2.yahoo.com (smtp104.biz.mail.re2.yahoo.com
	[206.190.52.173])
	by alsa0.perex.cz (Postfix) with SMTP id 8C4A81037EB
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Jun 2007 23:55:28 +0200 (CEST)
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

Hi all,

I'm developing an SoC driver for a sound engine that supports playing up 
to 64 simultaneous substreams, all mixed in h/w to a stereo DAC. But it 
doesn't appear that the SoC framework supports multiple substreams, 
according to soc_new_pcm(). Am I missing something, or is this on the 
asoc development roadmap?

Thanks,
Steve
