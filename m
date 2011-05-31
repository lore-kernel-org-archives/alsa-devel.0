From: =?ISO-8859-2?Q?Prchal_Ji=F8=ED?= <jiri.prchal@aksignal.cz>
Subject: PROBLEM: ARM: PCM plugin Ima-ADPCM doesn't work
	properly
Date: Tue, 31 May 2011 15:05:58 +0200
Message-ID: <4DE4E7B6.4050706@aksignal.cz>
References: <1300949648-15078-1-git-send-email-horms@verge.net.au>
	<1300949648-15078-2-git-send-email-horms@verge.net.au>
	<4D8B2068.60402@aksignal.cz> <4D8BA47B.8050904@bluewatersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <4D8BA47B.8050904@bluewatersys.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, alsa-devel@vger.kernel.org, abramo@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,
I have a problem converting S16_LE to ADPCM using pcm plugin. Data from this conversion look like just sign in it. This 
problem is on ARM platform, on I686 it works fine. Both version 1.0.23.
Here is part of asound.conf:

pcm.toadpcm {
	type adpcm
	slave {
		pcm tofile
		format IMA_ADPCM
	}
}

And here begin of data from conversion on ARM, in hex:
38 00 00 00 00 00 88 00 00 00 88 00 00 88 00 88 88 00 88 88 88 88 88 88 88 00 88 88 88 88 88 88

and on I686:
3b 77 77 77 77 77 77 77 77 77 77 11 88 00 88 88 88 88 99 99 99 aa aa aa bb bb bb cc bb bb cc aa

Where could be the problem? I try to look in source, but if it works on some platform?
Thanks for help.
