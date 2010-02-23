From: Paul Davis <paul-dDzkXPnfpdxaomM2pvQuqZqQE7yCjDx5@public.gmane.org>
Subject: Re: [LAD] [alsa-devel] 2.6.31.x vs. rme vs. alsa 1.0.22?
Date: Tue, 23 Feb 2010 16:22:27 -0500
Message-ID: <eb4b5e1d1002231322p3b63a587h92a26ffe348d0e1e@mail.gmail.com>
References: <1266371882.3361.40.camel@localhost.localdomain>
	<1266882689.3704.178.camel@localhost.localdomain>
	<1266884215.3704.208.camel@localhost.localdomain>
	<1266884449.3704.214.camel@localhost.localdomain>
	<1266958133.2507.234.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-audio-dev-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
In-Reply-To: <1266958133.2507.234.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
List-Unsubscribe: <http://lists.linuxaudio.org/listinfo/linux-audio-dev>,
	<mailto:linux-audio-dev-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxaudio.org/pipermail/linux-audio-dev>
List-Post: <mailto:linux-audio-dev-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
List-Help: <mailto:linux-audio-dev-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linuxaudio.org/listinfo/linux-audio-dev>,
	<mailto:linux-audio-dev-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: linux-audio-dev-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
Errors-To: linux-audio-dev-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
To: Fernando Lopez-Lezcano <nando-l0SEpsmuUtBegcJQxxnBRDe48wsgrGvP@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, The Linux Audio Developers' Mailing List <linux-audio-dev-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 23, 2010 at 3:48 PM, Fernando Lopez-Lezcano
<nando-l0SEpsmuUtBegcJQxxnBRDe48wsgrGvP@public.gmane.org> wrote:

>ALSA sound/pci/rme9652/hdsp.c:831: Hammerfall-DSP: wait for FIFO status
<= 0 failed after 30 iterations

this is bad, and i think may be related to your issues. this
timing-sensitive loop has always been a problem. it probably just
worked the 2nd time you tried a firmware load (by good luck).

--p
