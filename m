From: Dmitrij K <kdiman@live.ru>
Subject: Re: default is working, but hw:0,0 is do not...
Date: Wed, 25 Jan 2012 00:12:26 +0400
Message-ID: <BLU0-SMTP442CC9C447B91283E90406FC18B0@phx.gbl>
References: <BLU0-SMTP104845BEB7A301DD21ED66CC18B0@phx.gbl>
	<4F1F0DD0.6020101@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from blu0-omc3-s35.blu0.hotmail.com (blu0-omc3-s35.blu0.hotmail.com
	[65.55.116.110]) by alsa0.perex.cz (Postfix) with ESMTP id A2F2A2460C
	for <alsa-devel@alsa-project.org>; Tue, 24 Jan 2012 21:12:36 +0100 (CET)
In-Reply-To: <4F1F0DD0.6020101@canonical.com>
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

David Henningsson wrote:
> Make sure that nobody else is using the device at the same time.
> "hw:0,0" requires exclusive access to the device.

OK! Thanks for the important information!


I have used RtAudio library (not worked for me), and this is:

RtAudio::StreamOptions options;
options.flags = RTAUDIO_ALSA_USE_DEFAULT;

has solved the problem...


The Best Regards.
