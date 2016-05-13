From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: ADAU1761 default register value problem
Date: Fri, 13 May 2016 10:20:33 +0200
Message-ID: <57358E51.7020000@metafoo.de>
References: <alpine.DEB.2.02.1604211547540.31333@lnxricardw1.se.axis.com>
 <571F2513.1020005@metafoo.de>
 <alpine.DEB.2.02.1605111440510.31333@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id BE940260438
 for <alsa-devel@alsa-project.org>; Fri, 13 May 2016 10:20:37 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.02.1605111440510.31333@lnxricardw1.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricard Wanderlof <ricard.wanderlof@axis.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 05/11/2016 05:16 PM, Ricard Wanderlof wrote:
> 
> Hi Lars,
> 
> On Tue, 26 Apr 2016, Lars-Peter Clausen wrote:
> 
>>> A while ago I posted a question to the list regarding the default values 
>>> set up for the ADAU1761 (and similar CODECs), 
>>> ...
> 
> Having researched this further, it appears that commit
> 
> 27d6e7d1c96c9f51379e0feb972fec26029098bc
> 
> ASoC: adau17x1: Cache writes when core clock is disabled

I think it is also related to commit 1c79771a7270 ("regmap: Use
regcache_mark_dirty() to indicate power loss or reset"). This changes the
regmap code to sync all registers under certain conditions.

> 
> actually fixes this problem, at least for the ADAU1361 and ADAU1761. I'm 
> no expert at the regcache mechanism, but it looks as if when the regcache 
> is synced when the bias level goes from OFF to STANDBY, it actually writes 
> out all the values including the default ones (verified by adding trace 
> printouts, and also by verifying that my original problem of the codec 
> misbehaving after reconfiguration after reboot is no longer there).


We still have the issue though that the CODEC is in an undefined state until
the first OFF to STANDBY transitions happens. Usually this will happen early
on when the CODEC is bound to the sound card, but if it is not bound
immediately it might stay there for a bit longer. So depending on the setup
this may or may not be a problem.
