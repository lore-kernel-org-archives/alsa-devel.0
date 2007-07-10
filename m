From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: Query regarding sampling rates etc
Date: Tue, 10 Jul 2007 22:18:08 +0100
Message-ID: <1184102288.3301.56.camel@localhost.localdomain>
References: <61445c750707100702j4e6060bdhf31ffcf51d8e1de9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id AAFB01038C9
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Jul 2007 23:18:09 +0200 (CEST)
In-Reply-To: <61445c750707100702j4e6060bdhf31ffcf51d8e1de9@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Pharaoh ." <pharaoh137@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2007-07-10 at 19:32 +0530, Pharaoh . wrote:
> Hi,
> This is a very vague question, just thought of asking it after hours of
> debugging.
> 
> I am testing my alsa driver, written for omap 730/850 based board. I am
> testing it by using aplay.
> 
> Despite checking clocks, sampling rates etc many times and after doing many
> combinations thereof, I cant hear anything more than a noise which changes
> and becomes more like the original .wav file as I change various params like
> sampling rates/clocks etc. It becomes close to the actual thing, but not
> better.
> 
> Any idea what are the params I should be tweaking? I know this is h/w
> dependent.
> 

Sounds like (no pun intended) your digital audio interface is not set up
correctly between your codec and CPU.  It's probably best to make sure
they are both using the same I2S or PCM modes.

Liam  
