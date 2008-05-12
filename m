From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: Mono streams
Date: Mon, 12 May 2008 15:08:44 +0100
Message-ID: <1210601324.20475.177.camel@odin>
References: <E0D41E29EB0DAC4E9F3FF173962E9E9401234B506B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 32BAD1037F1
	for <alsa-devel@alsa-project.org>;
	Mon, 12 May 2008 16:08:47 +0200 (CEST)
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E9401234B506B@dbde02.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Nagar, Mrigendra" <x0088697@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 2008-05-12 at 18:35 +0530, Nagar, Mrigendra wrote:
> Hi,
> I have recently started working on ALSA libraries. I am facing following problems. It would be great help If some one can help me out.
> 1) Mono streams:
>     If I try to play A MONO streams. It plays Faster.
>     My driver configuration is
> i)                     Blocking mode
> ii)                   Access mode is interleaved
> iii)                  No of channels are set to 1

It sounds like your hardware is playing mono as stereo. Check your
driver as it may always play stereo regardless of the requested number
of channels.

Liam 
